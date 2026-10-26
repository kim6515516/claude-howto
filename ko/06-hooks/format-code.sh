#!/bin/bash
# 쓰기 후 코드를 자동 포맷합니다
# 훅: PostToolUse(matcher: Write)
#
# 표준 입력의 JSON에서 대상 파일 경로를 읽어, Claude가 파일을 쓴 뒤
# 그 파일에 적절한 포맷터를 인플레이스로 실행합니다.
#
# 지원: macOS, Linux, Windows(Git Bash)

# Claude Code 훅 프로토콜에 따라 표준 입력에서 JSON을 읽습니다
INPUT=$(cat)

# sed로 file_path를 추출합니다(모든 플랫폼 호환)
FILE_PATH=$(echo "$INPUT" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# 파일 종류를 판별해 포맷합니다
case "$FILE_PATH" in
  *.js|*.jsx|*.ts|*.tsx)
    if command -v prettier &> /dev/null; then
      prettier --write "$FILE_PATH" 2>/dev/null
    fi
    ;;
  *.py)
    if command -v black &> /dev/null; then
      black "$FILE_PATH" 2>/dev/null
    fi
    ;;
  *.go)
    if command -v gofmt &> /dev/null; then
      gofmt -w "$FILE_PATH" 2>/dev/null
    fi
    ;;
  *.rs)
    if command -v rustfmt &> /dev/null; then
      rustfmt "$FILE_PATH" 2>/dev/null
    fi
    ;;
  *.java)
    if command -v google-java-format &> /dev/null; then
      google-java-format -i "$FILE_PATH" 2>/dev/null
    fi
    ;;
esac

exit 0
