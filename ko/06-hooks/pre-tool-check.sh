#!/bin/bash
# Bash 명령어 사전 안전 검사
# 훅: PreToolUse(matcher: Bash)
#
# 이 훅은 Bash 도구가 실행될 때마다 동작하며, 파괴적이거나 고위험인 셸
# 명령어를 차단/경고합니다.
#
# 설정:
#   cp 06-hooks/pre-tool-check.sh ~/.claude/hooks/
#   chmod +x ~/.claude/hooks/pre-tool-check.sh
#
# ~/.claude/settings.json 설정 예:
#   {
#     "hooks": {
#       "PreToolUse": [
#         {
#           "matcher": "Bash",
#           "hooks": [
#             {
#               "type": "command",
#               "command": "~/.claude/hooks/pre-tool-check.sh"
#             }
#           ]
#         }
#       ]
#     }
#   }
#
# 입력: 다음 형식의 JSON을 표준 입력으로 받습니다:
#   { "tool_name": "Bash", "tool_input": { "command": "..." } }
#
# 출력 규약(Claude Code 훅 프로토콜 준수):
#   - exit 0 → 허용. stdout에는 JSON(hookSpecificOutput)을 출력할 수 있습니다. stderr는
#     조용히 버려지므로 stderr로 내보낸 경고는 표시되지 않습니다. 허용된
#     명령어의 관측 가능성을 확보하려면 감사 로그 파일에 기록합니다.
#   - exit 2 → 차단. stderr가 Claude에 차단 사유로 전달됩니다.
#     차단 사유를 설명하는 echo는 반드시 `>&2`로 stderr에 리다이렉트합니다.
#     그렇지 않으면 Claude Code는 "No stderr output"이라고 보고합니다.
#
# 감사 로그: 모든 호출을 다음 위치에 기록합니다
#   $CLAUDE_PROJECT_DIR/.claude/hooks/audit.log
# 판정(BLOCK/WARN/ALLOW)과 함께 저장하므로, stderr가 Claude Code에 버려지는
# WARN 계층의 매치도 관측할 수 있습니다.

# 표준 입력에서 JSON 전체를 읽습니다
INPUT=$(cat)

# 이식성 있는 sed로 명령어를 추출합니다(macOS / Linux 모두 호환)
COMMAND=$(echo "$INPUT" | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)

# 추출에 실패하면 원본 입력으로 폴백합니다
if [ -z "$COMMAND" ]; then
  COMMAND="$INPUT"
fi

# ── 감사 로그 ─────────────────────────────────────────────────────────────────
# 모든 호출을 최종 판정과 함께 기록합니다. Claude Code는 exit 0일 때
# stderr를 조용히 버리므로, WARN 계층을 확실히 관측할 수 있는 유일한 수단입니다.
# Claude Code 밖(로컬 테스트 등)에서는 $(pwd)로 폴백합니다.
LOG_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}/.claude/hooks"
LOG_FILE="$LOG_DIR/audit.log"
mkdir -p "$LOG_DIR" 2>/dev/null
log_decision() {
  echo "$(date -u +%FT%TZ) [$1] $COMMAND" >> "$LOG_FILE"
}

# ── 차단 패턴 ─────────────────────────────────────────────────────────────────
# 자동화된 문맥에서는 거의 확실히 파괴적이고 의도치 않은 것이므로 무조건 차단합니다.

BLOCKED_PATTERNS=(
  # `rm -rf /`를 엄밀히 판정하기 위해 `/` 뒤에 공백 또는 줄 끝을 요구합니다.
  # 부분 일치로 하면 `rm -rf /tmp/foo` 같은 정당한 경우를 오탐합니다.
  "rm -rf /([[:space:]]|$)"
  "rm -rf \*"
  "dd if=/dev/zero"
  "dd if=/dev/random"
  ":\(\)\{:\|:&\};:"  # 포크 폭탄(정규식 메타 문자를 이스케이프)
  "mkfs\."           # 파일 시스템 포맷
  "format c:"        # Windows 디스크 포맷
)

for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qE "$pattern"; then
    log_decision "BLOCK:$pattern"
    # 여기의 echo는 반드시 stderr로 — Claude Code는 exit 2일 때 stderr를
    # 차단 사유로 표시합니다. stdout에 쓰면 "No stderr output"으로 표시됩니다.
    echo "❌ 차단: 파괴적일 가능성이 있는 명령어를 감지했습니다: $pattern" >&2
    echo "   명령어: $COMMAND" >&2
    exit 2
  fi
done

# ── 경고 패턴 ─────────────────────────────────────────────────────────────────
# 위험은 높지만 의도적인 경우도 있습니다. 경고를 기록하고 허용합니다.

WARNING_PATTERNS=(
  "rm -rf"
  "git push --force"
  "git reset --hard"
  "git clean -f"
  "chmod -R 777"
  "sudo rm"
  "DROP TABLE"
  "DROP DATABASE"
  "truncate"
)

MATCHED_WARNINGS=""
for pattern in "${WARNING_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qi "$pattern"; then
    MATCHED_WARNINGS="${MATCHED_WARNINGS:+$MATCHED_WARNINGS,}$pattern"
    # 훅을 수동으로 실행하는 사람을 위해 stderr에도 경고를 출력합니다.
    # Claude Code는 exit 0일 때 이를 버리므로, 확실한 기록은 감사 로그
    # (WARN 항목)를 참고하세요.
    echo "⚠️  경고: 고위험 작업을 감지했습니다: $pattern" >&2
  fi
done

if [ -n "$MATCHED_WARNINGS" ]; then
  log_decision "WARN:$MATCHED_WARNINGS"
  echo "   명령어: $COMMAND" >&2
  echo "   계속 진행합니다 — 위의 경고를 확인한 뒤 계속하세요." >&2
else
  log_decision "ALLOW"
fi

# ── 허용 ────────────────────────────────────────────────────────────────────
exit 0
