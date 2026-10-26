#!/bin/bash
# 모든 bash 명령어를 기록합니다
# 훅: PostToolUse (matcher: Bash)
#
# 표준 입력의 JSON에서 실행된 명령어를 읽어 파일에 기록합니다.
#
# 지원: macOS, Linux, Windows (Git Bash)

# Claude Code 훅 프로토콜에 따라 표준 입력에서 JSON을 읽습니다
INPUT=$(cat)

# tool_input에서 bash 명령어를 추출합니다
# 참고: sed의 [^"]*는 JSON 안의 이스케이프된 따옴표에서 멈춥니다. 큰따옴표가
# 포함된 명령어는 첫 번째 \" 까지만 캡처됩니다. 이는 sed 기반 JSON 파싱의
# 알려진 제약이지만 로깅 용도로는 허용 가능한 수준입니다.
COMMAND=$(echo "$INPUT" | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)

if [ -z "$COMMAND" ]; then
  exit 0
fi

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
LOGFILE="$HOME/.claude/bash-commands.log"

# 로그 디렉터리가 없으면 생성합니다
mkdir -p "$(dirname "$LOGFILE")"

# 명령어를 기록합니다
echo "[$TIMESTAMP] $COMMAND" >> "$LOGFILE"

exit 0
