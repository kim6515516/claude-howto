#!/bin/bash
# 커밋 전에 테스트를 실행합니다
# 훅: PreToolUse(matcher: Bash) — 명령어가 git commit인지 판별합니다
# 참고: "PreCommit" 훅 이벤트는 존재하지 않습니다. PreToolUse와 Bash matcher를 조합해
# 명령어를 검사하고 git commit을 감지합니다.
#
# 종료 코드: 2는 도구 호출을 차단하고 stderr 내용을 차단 사유로 제시합니다.
# 그 외의 0이 아닌 값은 "차단하지 않는 오류"이므로 커밋이 그대로 진행되어 버립니다.
# 출처: https://code.claude.com/docs/en/hooks

# 표준 입력에서 훅 JSON을 읽고, git commit 명령어일 때만 테스트를 실행합니다
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
if ! echo "$COMMAND" | grep -q 'git commit'; then
  exit 0
fi

echo "🧪 커밋 전에 테스트를 실행하고 있습니다..."

# package.json 존재 여부 확인(Node.js 프로젝트)
if [ -f "package.json" ]; then
  if grep -q "\"test\":" package.json; then
    npm test
    if [ $? -ne 0 ]; then
      echo "❌ 테스트 실패. 커밋을 차단합니다." >&2
      exit 2
    fi
  fi
fi

# pytest 사용 가능 여부 확인(Python 프로젝트)
if [ -f "pytest.ini" ] || [ -f "setup.py" ]; then
  if command -v pytest &> /dev/null; then
    pytest
    if [ $? -ne 0 ]; then
      echo "❌ 테스트 실패. 커밋을 차단합니다." >&2
      exit 2
    fi
  fi
fi

# go.mod 존재 여부 확인(Go 프로젝트)
if [ -f "go.mod" ]; then
  go test ./...
  if [ $? -ne 0 ]; then
    echo "❌ 테스트 실패. 커밋을 차단합니다." >&2
    exit 2
  fi
fi

# Cargo.toml 존재 여부 확인(Rust 프로젝트)
if [ -f "Cargo.toml" ]; then
  cargo test
  if [ $? -ne 0 ]; then
    echo "❌ 테스트 실패. 커밋을 차단합니다." >&2
    exit 2
  fi
fi

echo "✅ 모든 테스트 통과. 커밋을 진행합니다."
exit 0
