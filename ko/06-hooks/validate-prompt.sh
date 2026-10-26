#!/bin/bash
# 사용자 프롬프트를 검증한다
# 훅: UserPromptSubmit
#
# 표준 입력의 JSON에서 사용자 프롬프트를 읽어 위험한 작업을 차단한다.
#
# 지원: macOS, Linux, Windows(Git Bash)

# Claude Code 훅 프로토콜에 따라 표준 입력에서 JSON을 읽는다
INPUT=$(cat)

# JSON 입력에서 프롬프트 본문을 추출
# Claude Code는 UserPromptSubmit의 본문을 "prompt" 필드로 보낸다
PROMPT=$(echo "$INPUT" | sed -n 's/.*"prompt"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)

if [ -z "$PROMPT" ]; then
  exit 0
fi

# 위험한 작업 탐지
DANGEROUS_PATTERNS=(
  "rm -rf /"
  "delete database"
  "drop database"
  "format disk"
  "dd if="
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "$PROMPT" | grep -qi "$pattern"; then
    printf '{"decision": "block", "reason": "위험한 작업 감지: %s"}' "$pattern"
    exit 0
  fi
done

# 프로덕션 배포 탐지
if echo "$PROMPT" | grep -qiE "(deploy|push).*production"; then
  if [ ! -f ".deployment-approved" ]; then
    echo '{"decision": "block", "reason": "프로덕션 배포에는 승인이 필요합니다. 계속하려면 .deployment-approved 파일을 만드세요."}'
    exit 0
  fi
fi

# 특정 작업에 대한 컨텍스트 요건 점검
if echo "$PROMPT" | grep -qi "refactor"; then
  if [ ! -d "tests" ] && [ ! -d "test" ]; then
    printf '{"hookSpecificOutput": {"hookEventName": "UserPromptSubmit", "additionalContext": "경고: 테스트 없는 리팩터링은 위험을 동반합니다. 먼저 테스트를 작성하는 것을 검토하세요."}}'
  fi
fi

exit 0
