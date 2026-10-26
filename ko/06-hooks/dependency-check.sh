#!/bin/bash
# 매니페스트 파일이 변경된 뒤 의존성의 알려진 취약점을 점검합니다.
# 훅: PostToolUse (matcher: Write)
#
# 대상 파일 경로는 표준 입력의 JSON에서 읽습니다(Claude Code 훅 프로토콜).
# 출처: https://code.claude.com/docs/en/hooks

# Claude Code 훅 프로토콜에 따라 표준 입력에서 JSON을 읽습니다
INPUT=$(cat)

# sed로 file_path를 추출합니다(모든 플랫폼 호환)
FILE=$(echo "$INPUT" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)

if [ -z "$FILE" ]; then
  exit 0
fi

# 매칭에는 basename을 사용합니다 — file_path는 절대 경로일 수 있습니다
BASENAME=$(basename "$FILE")

# 의존성 매니페스트가 변경된 경우에만 실행합니다
case "$BASENAME" in
  package.json|package-lock.json|yarn.lock|pnpm-lock.yaml| \
  requirements.txt|Pipfile|Pipfile.lock|pyproject.toml| \
  go.mod|go.sum| \
  Cargo.toml|Cargo.lock| \
  Gemfile|Gemfile.lock| \
  composer.json|composer.lock| \
  pom.xml|build.gradle|build.gradle.kts)
    echo "📦 의존성 매니페스트 업데이트: $FILE — 취약점을 스캔하는 중..."
    ;;
  *)
    exit 0
    ;;
esac

ISSUES_FOUND=0

# ── npm / yarn / pnpm ────────────────────────────────────────────────────────
if [[ "$BASENAME" == package*.json || "$BASENAME" == yarn.lock || "$BASENAME" == pnpm-lock.yaml ]]; then
  if command -v npm &>/dev/null; then
    echo "🔍 npm audit 실행 중..."
    if ! npm audit --audit-level=high --json 2>/dev/null | \
        python3 -c "
import sys, json
data = json.load(sys.stdin)
vulns = data.get('metadata', {}).get('vulnerabilities', {})
high = vulns.get('high', 0) + vulns.get('critical', 0)
if high:
    print(f'  ⚠️  높음/치명적 npm 취약점 {high}건 발견. 실행: npm audit fix')
    sys.exit(1)
" 2>/dev/null; then
      ISSUES_FOUND=1
    else
      echo "  ✅ 높음/치명적 npm 취약점 없음"
    fi
  fi

  if command -v yarn &>/dev/null && [[ "$BASENAME" == yarn.lock ]]; then
    echo "🔍 yarn audit 실행 중..."
    if ! yarn audit --level high --json 2>/dev/null | \
        grep -q '"type":"auditAdvisory"' 2>/dev/null; then
      echo "  ✅ 높음 수준의 yarn 취약점 없음"
    else
      echo "  ⚠️  yarn audit가 취약점을 발견했습니다. 실행: yarn audit --level high"
      ISSUES_FOUND=1
    fi
  fi
fi

# ── Python ───────────────────────────────────────────────────────────────────
if [[ "$BASENAME" == requirements.txt || "$BASENAME" == Pipfile* || "$BASENAME" == pyproject.toml ]]; then
  if command -v pip-audit &>/dev/null; then
    echo "🔍 pip-audit 실행 중..."
    if pip-audit --format=json 2>/dev/null | \
        python3 -c "
import sys, json
data = json.load(sys.stdin)
vulns = [d for d in data.get('dependencies', []) if d.get('vulns')]
if vulns:
    for dep in vulns:
        for v in dep['vulns']:
            print(f'  ⚠️  {dep[\"name\"]} {dep[\"version\"]}: {v[\"id\"]} — {v[\"fix_versions\"]}')
    sys.exit(1)
" 2>/dev/null; then
      echo "  ✅ Python 취약점 없음"
    else
      ISSUES_FOUND=1
      echo "  자세한 내용은 실행: pip-audit"
    fi
  elif command -v safety &>/dev/null; then
    echo "🔍 safety check 실행 중..."
    OUTPUT=$(safety check --short-report 2>&1)
    EXIT_CODE=$?
    if [ $EXIT_CODE -eq 0 ]; then
      echo "  ✅ Python 취약점 없음"
    elif echo "$OUTPUT" | grep -qiE "vulnerability|CVE|insecure"; then
      echo "$OUTPUT"
      ISSUES_FOUND=1
    else
      echo "  ⚠️  safety check를 완료하지 못했습니다(네트워크 또는 설정 오류)" >&2
    fi
  fi
fi

# ── Go ───────────────────────────────────────────────────────────────────────
if [[ "$BASENAME" == go.mod || "$BASENAME" == go.sum ]]; then
  if command -v govulncheck &>/dev/null; then
    echo "🔍 govulncheck 실행 중..."
    OUTPUT=$(govulncheck ./... 2>&1)
    EXIT_CODE=$?
    if [ $EXIT_CODE -eq 0 ]; then
      echo "  ✅ Go 취약점 없음"
    elif echo "$OUTPUT" | grep -q "Vulnerability #"; then
      echo "$OUTPUT"
      ISSUES_FOUND=1
    else
      echo "  ⚠️  govulncheck를 완료하지 못했습니다: $OUTPUT" >&2
    fi
  fi
fi

# ── Rust ─────────────────────────────────────────────────────────────────────
if [[ "$BASENAME" == Cargo.toml || "$BASENAME" == Cargo.lock ]]; then
  if command -v cargo-audit &>/dev/null; then
    echo "🔍 cargo audit 실행 중..."
    if ! cargo audit 2>/dev/null; then
      ISSUES_FOUND=1
    else
      echo "  ✅ Rust 취약점 없음"
    fi
  fi
fi

# ── Ruby ─────────────────────────────────────────────────────────────────────
if [[ "$BASENAME" == Gemfile || "$BASENAME" == Gemfile.lock ]]; then
  if command -v bundler-audit &>/dev/null; then
    echo "🔍 bundler-audit 실행 중..."
    bundler-audit check --update 2>/dev/null || ISSUES_FOUND=1
  fi
fi

# ── 범용 폴백: trivy ─────────────────────────────────────────────────────────
if command -v trivy &>/dev/null; then
  echo "🔍 trivy fs scan 실행 중..."
  if ! trivy fs --exit-code 1 --severity HIGH,CRITICAL --quiet . 2>/dev/null; then
    ISSUES_FOUND=1
  else
    echo "  ✅ trivy가 HIGH/CRITICAL 문제를 발견하지 않음"
  fi
fi

if [ "$ISSUES_FOUND" -eq 0 ]; then
  echo "✅ 의존성 점검 통과 — 취약점이 발견되지 않았습니다"
else
  echo ""
  echo "⚠️  취약점이 발견되었습니다. 커밋 전에 의존성을 확인하고 업데이트하세요."
  echo "   이 훅은 조언만 제공하며 워크플로를 차단하지 않습니다."
fi

# 항상 exit 0 — 이 훅은 경고만 하고 차단하지 않습니다
exit 0
