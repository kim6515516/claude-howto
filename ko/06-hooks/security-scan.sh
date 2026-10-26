#!/bin/bash
# 파일 쓰기 시 보안 스캔
# 훅: PostToolUse(matcher: Write)
#
# 파일에서 하드코딩된 시크릿, API 키, 자격 증명을 스캔합니다.
# 발견되면 additionalContext를 통해 비차단 경고를 출력합니다.
#
# 지원: macOS, Linux, Windows(Git Bash)

# Claude Code 훅 프로토콜에 따라 표준 입력에서 JSON을 읽습니다
INPUT=$(cat)

# sed로 file_path를 추출합니다(Windows Git Bash를 포함한 모든 플랫폼과 호환)
# grep -P(Windows Git Bash에서 사용 불가)와 python3 의존을 피합니다
FILE_PATH=$(echo "$INPUT" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# 바이너리 파일, 벤더 디렉터리, 빌드 산출물은 건너뜁니다
case "$FILE_PATH" in
  *.png|*.jpg|*.jpeg|*.gif|*.svg|*.ico|*.woff|*.woff2|*.ttf|*.eot) exit 0 ;;
  */node_modules/*|*/.git/*|*/dist/*|*/build/*) exit 0 ;;
esac

ISSUES=""

# 하드코딩된 비밀번호 감지
# JSON 형식("password": "value")과 코드 형식(password = 'value')을 모두 지원합니다
# 구분자로 \\n을 사용합니다 — 유효한 JSON 줄바꿈 이스케이프이며 printf에서도 안전하게 통과합니다
if grep -qiE '"password"[[:space:]]*:[[:space:]]*"[^"]+"' "$FILE_PATH" 2>/dev/null; then
  ISSUES="${ISSUES}- 경고: 하드코딩된 비밀번호로 의심되는 값을 감지\\n"
elif grep -qiE '(password|passwd|pwd)[[:space:]]*=[[:space:]]*'"'"'[^'"'"']+'"'"'' "$FILE_PATH" 2>/dev/null; then
  ISSUES="${ISSUES}- 경고: 하드코딩된 비밀번호로 의심되는 값을 감지\\n"
fi

# 하드코딩된 API 키 감지
if grep -qiE '"(api[_-]?key|apikey|access[_-]?token)"[[:space:]]*:[[:space:]]*"[^"]+"' "$FILE_PATH" 2>/dev/null; then
  ISSUES="${ISSUES}- 경고: 하드코딩된 API 키로 의심되는 값을 감지\\n"
fi

# 하드코딩된 시크릿·토큰 감지
if grep -qiE '(secret|token)[[:space:]]*=[[:space:]]*['"'"'"][^'"'"'"]+['"'"'"]' "$FILE_PATH" 2>/dev/null; then
  ISSUES="${ISSUES}- 경고: 하드코딩된 시크릿 또는 토큰으로 의심되는 값을 감지\\n"
fi

# 개인 키 감지
if grep -q "BEGIN.*PRIVATE KEY" "$FILE_PATH" 2>/dev/null; then
  ISSUES="${ISSUES}- 경고: 개인 키를 감지\\n"
fi

# AWS 액세스 키 감지
if grep -qE "AKIA[0-9A-Z]{16}" "$FILE_PATH" 2>/dev/null; then
  ISSUES="${ISSUES}- 경고: AWS 액세스 키를 감지\\n"
fi

# semgrep을 사용할 수 있으면 스캔합니다(JSON 출력과 섞이지 않도록 stdout은 숨깁니다)
if command -v semgrep &> /dev/null; then
  semgrep --config=auto "$FILE_PATH" --quiet >/dev/null 2>/dev/null
fi

# trufflehog를 사용할 수 있으면 스캔합니다(JSON 출력과 섞이지 않도록 stdout은 숨깁니다)
if command -v trufflehog &> /dev/null; then
  trufflehog filesystem "$FILE_PATH" --only-verified --quiet >/dev/null 2>/dev/null
fi

# 문제가 발견되면 additionalContext로 출력합니다(비차단 경고)
# Claude Code PostToolUse 프로토콜이 요구하는 hookSpecificOutput 형식을 사용합니다
if [ -n "$ISSUES" ]; then
  # 파일 경로를 JSON용으로 이스케이프합니다(백슬래시와 큰따옴표)
  # ISSUES는 이미 \\n을 구분자로 사용하므로(유효한 JSON 이스케이프) 큰따옴표만 이스케이프합니다
  SAFE_PATH=$(printf '%s' "$FILE_PATH" | sed 's/\\/\\\\/g; s/"/\\"/g')
  SAFE_ISSUES=$(printf '%s' "$ISSUES" | sed 's/"/\\"/g')
  printf '{"hookSpecificOutput": {"hookEventName": "PostToolUse", "additionalContext": "보안 스캔에서 %s의 문제를 감지했습니다:\\n%s환경 변수 사용을 검토해 주세요."}}' "$SAFE_PATH" "$SAFE_ISSUES"
fi

exit 0
