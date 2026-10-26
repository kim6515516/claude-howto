#!/usr/bin/env bash
# SessionEnd 훅: 학습한 모듈을 기록하고 ~/.claude-howto-progress.json에
# 세션 기록을 추가해 학습 진행 상황을 영구적으로 추적합니다.
#
# Claude Code 세션이 끝날 때 한 번만 실행됩니다(응답마다가 아님).
# 훅은 제어 터미널 없이 실행되어 /dev/tty를 쓸 수 없으므로, 모듈과 메모는
# 환경 변수 CLAUDE_HOWTO_MODULES / CLAUDE_HOWTO_NOTES로 전달받습니다.
#
# 설치: .claude/settings.json의 "SessionEnd" 이벤트에 등록합니다(아래 참조).

PROGRESS_FILE="$HOME/.claude-howto-progress.json"

# 가드: 이 저장소 안에서만 동작합니다
if [[ "$CLAUDE_PROJECT_DIR" != *"claude-howto"* ]] && [[ "$PWD" != *"claude-howto"* ]]; then
  exit 0
fi

# 진행 상황 파일이 없으면 생성합니다
if [ ! -f "$PROGRESS_FILE" ]; then
  echo '{"sessions":[]}' > "$PROGRESS_FILE"
fi

DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M")

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Claude Code — 학습 세션 종료"
echo " $DATE $TIME"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
# 학습한 모듈. 예: CLAUDE_HOWTO_MODULES=06,07 claude 로 시작합니다
# 01=Slash  02=Memory  03=Skills  04=Subagents  05=MCP
# 06=Hooks  07=Plugins 08=Checkpoints 09=Advanced 10=CLI
INPUT="${CLAUDE_HOWTO_MODULES:-}"

if [ -z "$INPUT" ] || [ "$INPUT" = "skip" ]; then
  echo " 건너뜀 — 세션을 기록하지 않습니다."
  echo ""
  exit 0
fi

# 짧은 번호를 모듈 이름에 매핑합니다(bash 3.2가 파싱하지 못하므로 pipeline+while은 피합니다)
IFS=',' read -ra PARTS <<< "$INPUT"
MODULES_JSON=""
for m in "${PARTS[@]}"; do
  m="${m// /}"  # 공백 제거
  case "$m" in
    01) label='"01-slash-commands"' ;;
    02) label='"02-memory"' ;;
    03) label='"03-skills"' ;;
    04) label='"04-subagents"' ;;
    05) label='"05-mcp"' ;;
    06) label='"06-hooks"' ;;
    07) label='"07-plugins"' ;;
    08) label='"08-checkpoints"' ;;
    09) label='"09-advanced-features"' ;;
    10) label='"10-cli"' ;;
    *)  label="\"$m\"" ;;
  esac
  MODULES_JSON="${MODULES_JSON:+$MODULES_JSON,}$label"
done

# 선택적 메모. 예: CLAUDE_HOWTO_NOTES="pre-commit 예제를 시도했음"
NOTES="${CLAUDE_HOWTO_NOTES:-}"

# NOTES는 별도 인자로 Python에 넘겨 JSON 이스케이프를 Python에 맡깁니다.
# 메모에 따옴표나 백슬래시가 들어 있어도 JSON이 깨지지 않도록 하기 위해서입니다.
python3 - "$PROGRESS_FILE" "$DATE" "$TIME" "$MODULES_JSON" "$NOTES" <<'PYEOF'
import sys, json

path, date, time_str, modules_raw, notes = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5]

new_session = {
    "date": date,
    "time": time_str,
    "modules": json.loads(f"[{modules_raw}]") if modules_raw else [],
    "notes": notes,
}

with open(path, 'r') as f:
    data = json.load(f)

data.setdefault('sessions', []).append(new_session)

with open(path, 'w') as f:
    json.dump(data, f, indent=2)
PYEOF

echo ""
echo " $PROGRESS_FILE 에 저장했습니다"
[ -n "$NOTES" ] && echo " 메모: $NOTES"
echo ""

exit 0
