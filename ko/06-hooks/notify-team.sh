#!/bin/bash
# 이벤트 발생 시 알림을 보냅니다
# 훅: PostToolUse(matcher: Bash) — 모든 Bash 호출 뒤에 실행되며, 명령어가 git push가 아니면 스크립트를 종료합니다
# 참고: Claude Code에는 네이티브 PostPush 이벤트가 없습니다. git push를 트리거로 삼으려면
# matcher 또는 이 스크립트 안의 조건으로 bash 명령어 문자열에 "git push"가 포함되어 있는지 확인합니다.

# 훅 입력을 읽고, Bash 명령어가 git push가 아니면 종료합니다
INPUT=$(cat)
# 명령어 문자열을 추출하고(\"msg\" 같은 이스케이프된 따옴표 포함), 그 안 어딘가에 있는 "git push"를 명령어 단어로 매칭합니다
COMMAND=$(echo "$INPUT" | sed -nE 's/.*"command"[[:space:]]*:[[:space:]]*"(([^"\\]|\\.)*)".*/\1/p' | head -1)
printf '%s\n' "$COMMAND" | grep -qE '(^|[^[:alnum:]_-]|\\n)git[[:space:]]+push([^[:alnum:]_-]|$)' || exit 0

REPO_NAME=$(basename $(git rev-parse --show-toplevel 2>/dev/null) 2>/dev/null)
COMMIT_MSG=$(git log -1 --pretty=%B 2>/dev/null)
AUTHOR=$(git log -1 --pretty=%an 2>/dev/null)
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

echo "📢 팀에 알림을 보내는 중..."

# Slack Webhook 예시(Webhook URL은 자신의 것으로 교체하세요)
SLACK_WEBHOOK="${SLACK_WEBHOOK_URL:-}"

if [ -n "$SLACK_WEBHOOK" ]; then
  curl -X POST "$SLACK_WEBHOOK" \
    -H 'Content-Type: application/json' \
    -d "{
      \"text\": \"*$REPO_NAME*에 새 push가 있습니다\",
      \"attachments\": [{
        \"color\": \"good\",
        \"fields\": [
          {\"title\": \"브랜치\", \"value\": \"$BRANCH\", \"short\": true},
          {\"title\": \"작성자\", \"value\": \"$AUTHOR\", \"short\": true},
          {\"title\": \"커밋\", \"value\": \"$COMMIT_MSG\"}
        ]
      }]
    }" \
    --silent --output /dev/null

  echo "✅ Slack 알림을 보냈습니다"
fi

# Discord Webhook 예시(Webhook URL은 자신의 것으로 교체하세요)
DISCORD_WEBHOOK="${DISCORD_WEBHOOK_URL:-}"

if [ -n "$DISCORD_WEBHOOK" ]; then
  curl -X POST "$DISCORD_WEBHOOK" \
    -H 'Content-Type: application/json' \
    -d "{
      \"content\": \"**$REPO_NAME에 새 push가 있습니다**\",
      \"embeds\": [{
        \"title\": \"$COMMIT_MSG\",
        \"color\": 3066993,
        \"fields\": [
          {\"name\": \"브랜치\", \"value\": \"$BRANCH\", \"inline\": true},
          {\"name\": \"작성자\", \"value\": \"$AUTHOR\", \"inline\": true}
        ]
      }]
    }" \
    --silent --output /dev/null

  echo "✅ Discord 알림을 보냈습니다"
fi

# Email 알림 예시
EMAIL_TO="${TEAM_EMAIL:-}"

if [ -n "$EMAIL_TO" ]; then
  echo "$AUTHOR 님이 $REPO_NAME에 push했습니다" | \
    mail -s "Git Push: $BRANCH" "$EMAIL_TO"

  echo "✅ Email 알림을 보냈습니다"
fi

exit 0
