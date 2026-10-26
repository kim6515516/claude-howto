<!-- i18n-source: QUICK_REFERENCE.md -->
<!-- i18n-source-sha: d17d515 -->
<!-- i18n-date: 2026-10-26 -->

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

# Claude Code 예제 — 빠른 참조 카드

## 🚀 설치용 빠른 명령어

### 슬래시 명령어
```bash
# 전부 설치
cp 01-slash-commands/*.md .claude/commands/

# 특정 항목만 설치
cp 01-slash-commands/optimize.md .claude/commands/
```

### 메모리
```bash
# 프로젝트 메모리
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# 개인 메모리
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

### 스킬
```bash
# 개인 스킬
cp -r 03-skills/code-review-specialist ~/.claude/skills/

# 프로젝트 스킬
cp -r 03-skills/code-review-specialist .claude/skills/
```

### 서브에이전트
```bash
# 전부 설치
cp 04-subagents/*.md .claude/agents/

# 특정 항목만 설치
cp 04-subagents/code-reviewer.md .claude/agents/
```

### MCP
```bash
# 인증 정보 설정
export GITHUB_PERSONAL_ACCESS_TOKEN="your_token"
export DATABASE_URL="postgresql://..."

# 설정 설치 (프로젝트 스코프)
cp 05-mcp/github-mcp.json .mcp.json

# 또는 사용자 스코프: ~/.claude.json에 추가
```

### 훅
```bash
# 훅 설치
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# 설정 파일에서 구성 (~/.claude/settings.json)
```

### 플러그인
```bash
# 예제에서 설치 (공개된 경우)
claude --plugin-dir ./07-plugins/pr-review
/plugin install devops-automation
/plugin install documentation
```

### 체크포인트
```bash
# 체크포인트는 사용자 프롬프트마다 자동으로 생성됩니다
# 되돌리려면 Esc를 두 번 누르거나 다음을 실행:
/rewind

# 선택지: 코드와 대화 복원, 대화 복원,
# 코드 복원, 여기부터 요약, 취소
```

### 고급 기능
```bash
# 설정 파일에서 구성 (.claude/settings.json)
# 09-advanced-features/config-examples.json 참고

# 플랜 모드
/plan Task description

# 권한 모드 (--permission-mode 플래그 사용)
# default        - 위험한 작업에서 승인을 요청
# acceptEdits    - 파일 편집은 자동 승인, 그 외는 확인
# plan           - 읽기 전용 분석, 변경 없음
# dontAsk        - 사전 승인된 도구만 실행, 그 외는 모두 거부
# auto           - 백그라운드 분류기가 자동으로 권한을 판단
# bypassPermissions - 모두 승인 (--permission-mode bypassPermissions. --dangerously-skip-permissions도 동일)

# 세션 관리
/resume                # 이전 대화 재개
/rename "name"         # 현재 세션에 이름 붙이기
/fork                  # 현재 세션 포크
claude -c              # 가장 최근 대화 이어가기
claude -r "session"    # 이름 / ID로 세션 재개
```

---

## 📋 기능 치트시트

| 기능 | 설치 위치 | 사용법 |
|---------|-------------|-------|
| **슬래시 명령어 (55개 이상)** | `.claude/commands/*.md` | `/command-name` |
| **메모리** | `./CLAUDE.md` | 자동 로드 |
| **스킬** | `.claude/skills/*/SKILL.md` | 자동 실행 |
| **서브에이전트** | `.claude/agents/*.md` | 자동 위임 |
| **MCP** | `.mcp.json` (프로젝트) 또는 `~/.claude.json` (사용자) | `/mcp__server__action` |
| **훅 (33개 이벤트)** | `~/.claude/hooks/*.sh` | 이벤트 트리거 (5종류) |
| **플러그인** | `/plugin install`로 설치 | 모든 것을 번들 |
| **체크포인트** | 내장 | `Esc+Esc` 또는 `/rewind` |
| **플랜 모드** | 내장 | `/plan <task>` |
| **권한 모드 (6개 모드)** | 내장 | `--allowedTools`, `--permission-mode` |
| **세션** | 내장 | `/resume`, `/rename`, `/branch`, `/fork` |
| **백그라운드 작업** | 내장 | 백그라운드에서 실행 |
| **리모트 컨트롤** | 내장 | `claude --remote-control` 또는 `/remote-control` |
| **웹 세션** | 내장 | `claude --cloud "task"` |
| **Git 워크트리** | 내장 | `claude -w <name>` |
| **Auto Memory** | 내장 | `~/.claude/projects/<project>/memory/`에 자동 저장 |
| **작업 목록** | 내장 | `Ctrl+T`(체크리스트), `/tasks`(백그라운드 작업) |
| **번들 스킬 (5개)** | 내장 | `/simplify`, `/loop`, `/claude-api`, `/voice`, `/browse` |

---

## 🎯 자주 쓰는 사용 사례

### 코드 리뷰
```bash
# 방법 1: 슬래시 명령어
cp 01-slash-commands/optimize.md .claude/commands/
# 사용: /optimize

# 방법 2: 서브에이전트
cp 04-subagents/code-reviewer.md .claude/agents/
# 사용: 자동 위임

# 방법 3: 스킬
cp -r 03-skills/code-review-specialist ~/.claude/skills/
# 사용: 자동 실행

# 방법 4: 플러그인 (권장)
claude --plugin-dir ./07-plugins/pr-review
# 사용: /review-pr
```

### 문서
```bash
# 슬래시 명령어
cp 01-slash-commands/generate-api-docs.md .claude/commands/

# 서브에이전트
cp 04-subagents/documentation-writer.md .claude/agents/

# 스킬
cp -r 03-skills/doc-generator ~/.claude/skills/

# 플러그인 (완전한 솔루션)
/plugin install documentation
```

### DevOps
```bash
# 완전한 플러그인
/plugin install devops-automation

# 명령어: /deploy, /rollback, /status, /incident
```

### 팀 표준
```bash
# 프로젝트 메모리
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# 팀에 맞게 편집
vim CLAUDE.md
```

### 자동화와 훅
```bash
# 훅 설치 (33개 이벤트, 5종류: command, http, mcp_tool, prompt, agent)
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# 예:
# - 커밋 전 테스트: pre-commit.sh
# - 코드 자동 정리: format-code.sh
# - 보안 스캔: security-scan.sh

# 완전 자율 워크플로를 위한 Auto Mode
claude --enable-auto-mode -p "Refactor and test the auth module"
# 또는 Shift+Tab으로 대화형 모드 전환
```

### 안전한 리팩터링
```bash
# 체크포인트는 각 프롬프트 전에 자동으로 생성됩니다
# 리팩터링을 시도합니다
# 잘 되면: 계속 진행
# 실패하면: Esc+Esc를 누르거나 /rewind로 되돌리기
```

### 복잡한 구현
```bash
# 플랜 모드 사용
/plan Implement user authentication system

# Claude가 상세한 계획을 만듭니다
# 검토하고 승인합니다
# Claude가 체계적으로 구현합니다
```

### CI/CD 통합
```bash
# 헤드리스 모드로 실행 (비대화형)
claude -p "Run all tests and generate report"

# CI용 권한 모드 지정
claude -p "Run tests" --permission-mode dontAsk

# 완전 자율 CI 작업을 위한 Auto Mode
claude --enable-auto-mode -p "Run tests and fix failures"

# 자동화를 위한 훅 사용
# 09-advanced-features/README.md 참고
```

### 학습과 실험
```bash
# 안전한 분석을 위해 plan 모드 사용
claude --permission-mode plan

# 안전하게 실험 - 체크포인트는 자동으로 생성됩니다
# 되돌려야 한다면: Esc+Esc 또는 /rewind
```

### Agent Teams
```bash
# Agent Teams 활성화
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1

# 또는 settings.json에서
{ "env": { "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1" } }

# 시작: "Implement feature X using a team approach"
```

### 예약 작업
```bash
# 5분마다 명령어 실행
/loop 5m /check-status

# 일회성 리마인더: 평범한 말로 요청합니다 (/loop는 취소할 때까지 반복됩니다)
30분 후에 배포를 확인하라고 알려 줘
```

---

## 📁 파일 배치 레퍼런스

```text
Your Project/
├── .claude/
│   ├── commands/              # 슬래시 명령어는 여기
│   ├── agents/                # 서브에이전트는 여기
│   ├── skills/                # 프로젝트 스킬은 여기
│   └── settings.json          # 프로젝트 설정 (훅 등)
├── .mcp.json                  # MCP 설정 (프로젝트 스코프)
├── CLAUDE.md                  # 프로젝트 메모리
└── src/
    └── api/
        └── CLAUDE.md          # 디렉터리 고유 메모리

User Home/
├── .claude/
│   ├── commands/              # 개인 명령어
│   ├── agents/                # 개인 에이전트
│   ├── skills/                # 개인 스킬
│   ├── hooks/                 # 훅 스크립트
│   ├── settings.json          # 사용자 설정
│   └── CLAUDE.md              # 개인 메모리
└── .claude.json               # 개인 MCP 설정 (사용자 스코프)

시스템 디렉터리/              # macOS /Library/Application Support/ClaudeCode/, Linux /etc/claude-code/, Windows C:\Program Files\ClaudeCode\
├── managed-settings.json      # 관리 설정 (엔터프라이즈 / 조직)
└── managed-settings.d/        # 관리 설정 드롭인
```

---

## 🔍 예제 찾는 법

### 카테고리별
- **슬래시 명령어**: `01-slash-commands/`
- **메모리**: `02-memory/`
- **스킬**: `03-skills/`
- **서브에이전트**: `04-subagents/`
- **MCP**: `05-mcp/`
- **훅**: `06-hooks/`
- **플러그인**: `07-plugins/`
- **체크포인트**: `08-checkpoints/`
- **고급 기능**: `09-advanced-features/`
- **CLI**: `10-cli/`

### 사용 사례별
- **성능**: `01-slash-commands/optimize.md`
- **보안**: `04-subagents/secure-reviewer.md`
- **테스트**: `04-subagents/test-engineer.md`
- **문서**: `03-skills/doc-generator/`
- **DevOps**: `07-plugins/devops-automation/`

### 복잡도별
- **단순**: 슬래시 명령어
- **중간**: 서브에이전트, 메모리
- **고급**: 스킬, 훅
- **완전**: 플러그인

---

## 🎓 학습 경로

### 1일 차
```bash
# 개요 읽기
cat README.md

# 명령어 설치
cp 01-slash-commands/optimize.md .claude/commands/

# 사용해 보기
/optimize
```

### 2~3일 차
```bash
# 메모리 설정
cp 02-memory/project-CLAUDE.md ./CLAUDE.md
vim CLAUDE.md

# 서브에이전트 설치
cp 04-subagents/code-reviewer.md .claude/agents/
```

### 4~5일 차
```bash
# MCP 설정
export GITHUB_PERSONAL_ACCESS_TOKEN="your_token"
cp 05-mcp/github-mcp.json .mcp.json

# MCP 명령어 사용해 보기
/mcp__github__list_prs
```

### 2주 차
```bash
# 스킬 설치
cp -r 03-skills/code-review-specialist ~/.claude/skills/

# 자동 실행시키기
# 이렇게 말하기만 하면 됩니다: "Review this code for issues"
```

### 3주 차 이후
```bash
# 완전한 플러그인 설치
claude --plugin-dir ./07-plugins/pr-review

# 번들 기능 사용
/review-pr
/check-security
/check-tests
```

---

## 새 기능(2026년 3월)

| 기능 | 설명 | 사용법 |
|---------|-------------|-------|
| **Auto Mode** | 백그라운드 분류기를 통한 완전 자율 동작 | `--enable-auto-mode` 플래그, `Shift+Tab`으로 모드 전환 |
| **채널** | Discord와 Telegram 통합 | `--channels` 플래그, Discord / Telegram 봇 |
| **음성 입력** | 명령과 컨텍스트를 Claude에 음성으로 전달 | `/voice` 명령어 |
| **훅 (33개 이벤트)** | 5종류로 확장된 훅 시스템 | command, http, mcp_tool, prompt, agent 훅 종류 |
| **MCP Elicitation** | MCP 서버가 실행 중에 사용자 입력을 요청 가능 | 서버가 명확화를 요구하면 자동 프롬프트 |
| **Plugin LSP** | 플러그인의 Language Server Protocol 지원 | `userConfig`, `${CLAUDE_PLUGIN_DATA}` 변수 |
| **리모트 컨트롤** | claude.ai 또는 Claude 앱에서 로컬 세션 조작 | `claude --remote-control`(세션 안에서는 `/remote-control`) |
| **웹 세션** | claude.ai/code의 클라우드 세션 | 터미널에서 시작: `claude --cloud "task"` |
| **데스크톱 앱** | 네이티브 데스크톱 앱 | claude.ai/download에서 다운로드 |
| **작업 목록** | 백그라운드 작업 관리 | `/tasks`(별칭 `/bashes`) |
| **Auto Memory** | 대화에서 자동으로 메모리 저장 | Claude가 `~/.claude/projects/<project>/memory/MEMORY.md`에 메모를 저장. `/memory`로 관리 |
| **Git 워크트리** | 병렬 개발을 위한 격리 워크스페이스 | `claude --worktree <name>`(또는 `-w`) |
| **모델 선택** | Fable 5.1, Fable 5, Opus 5, Sonnet 5.5, Sonnet 5, Sonnet 4.6, Opus 4.8, Haiku 4.5 전환 | `/model` 또는 `--model` 플래그(Anthropic API에서 `sonnet`은 Sonnet 5.5를 가리킴, v2.1.284+) |
| **Agent Teams** | 작업에 여러 에이전트를 협업시킴 | 환경 변수 `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`로 활성화(실험적) |
| **예약 작업** | `/loop`를 통한 반복 작업 | `/loop 5m /command` 또는 CronCreate 도구 |
| **Chrome 연동** | 브라우저 자동화 | `--chrome` 플래그 또는 `/chrome` 명령어 |
| **키 바인딩 커스터마이징** | 사용자 정의 키 바인딩 | `/keybindings` 명령어 |

---

## 팁과 요령

### 커스터마이징
- 예제를 그대로 사용하는 것부터 시작합니다
- 자신의 필요에 맞게 고칩니다
- 팀에 공유하기 전에 테스트합니다
- 설정을 버전 관리합니다

### 모범 사례
- 팀 표준에는 메모리를 사용합니다
- 완전한 워크플로에는 플러그인을 사용합니다
- 복잡한 작업에는 서브에이전트를 사용합니다
- 단순한 작업에는 슬래시 명령어를 사용합니다

### 문제 해결
```bash
# 파일 배치 확인
ls -la .claude/commands/
ls -la .claude/agents/

# YAML 문법 검증
head -20 .claude/agents/code-reviewer.md

# MCP 연결 테스트
echo $GITHUB_PERSONAL_ACCESS_TOKEN
```

---

## 📊 기능 매트릭스

| 필요한 것 | 사용할 기능 | 예 |
|------|----------|---------|
| 빠른 단축키 | 슬래시 명령어 (55개 이상) | `01-slash-commands/optimize.md` |
| 팀 표준 | 메모리 | `02-memory/project-CLAUDE.md` |
| 자동 워크플로 | 스킬 | `03-skills/code-review-specialist/` |
| 전문 작업 | 서브에이전트 | `04-subagents/code-reviewer.md` |
| 외부 데이터 | MCP(+ Elicitation) | `05-mcp/github-mcp.json` |
| 이벤트 자동화 | 훅 (33개 이벤트, 5종류) | `06-hooks/pre-commit.sh` |
| 완전한 솔루션 | 플러그인 (+ LSP 지원) | `07-plugins/pr-review/` |
| 안전한 실험 | 체크포인트 | `08-checkpoints/checkpoint-examples.md` |
| 완전 자율 | Auto Mode | `--enable-auto-mode` 또는 `Shift+Tab` |
| 채팅 연동 | 채널 | `--channels`(Discord, Telegram) |
| CI/CD 파이프라인 | CLI | `10-cli/README.md` |

---

## 🔗 빠른 링크

- **메인 가이드**: `README.md`
- **전체 색인**: `INDEX.md`
- **요약**: `EXAMPLES_SUMMARY.md`
- **원본 가이드**: `claude_concepts_guide.md`

---

## 📞 자주 묻는 질문

**Q: 어느 것을 사용해야 하나요?**
A: 슬래시 명령어부터 시작하고, 필요에 따라 기능을 추가합니다.

**Q: 기능을 조합할 수 있나요?**
A: 가능합니다. 함께 동작합니다. 메모리 + 명령어 + MCP는 강력합니다.

**Q: 팀과 공유하려면?**
A: `.claude/` 디렉터리를 git에 커밋합니다.

**Q: 시크릿은 어떻게 하나요?**
A: 환경 변수를 사용하고, 하드코딩하지 않습니다.

**Q: 예제를 고쳐 써도 되나요?**
A: 물론입니다. 커스터마이징을 위한 템플릿입니다.

---

## ✅ 체크리스트

시작용 체크리스트:

- [ ] `README.md` 읽기
- [ ] 슬래시 명령어 1개 설치
- [ ] 그 명령어 사용해 보기
- [ ] 프로젝트 `CLAUDE.md` 만들기
- [ ] 서브에이전트 1개 설치
- [ ] MCP 통합 1개 설정
- [ ] 스킬 1개 설치
- [ ] 완전한 플러그인 사용해 보기
- [ ] 자신의 필요에 맞게 커스터마이징
- [ ] 팀과 공유

---

**빠른 시작**: `cat README.md`

**전체 색인**: `cat INDEX.md`

**이 카드**: 가까이 두고 빠른 참조로 활용하세요!

---
**최종 업데이트**: 2026년 10월 18일
**Claude Code 버전**: 2.1.302
**출처**:
- https://code.claude.com/docs/en/overview
- https://code.claude.com/docs/en/hooks
- https://code.claude.com/docs/en/commands
- https://github.com/anthropics/claude-code/releases/tag/v2.1.119
- https://code.claude.com/docs/en/cli-reference
- https://code.claude.com/docs/en/remote-control
- https://code.claude.com/docs/en/agent-teams
- https://code.claude.com/docs/en/memory#storage-location
- https://code.claude.com/docs/en/permission-modes
- https://code.claude.com/docs/en/managed-settings
- https://code.claude.com/docs/en/scheduled-tasks
- https://code.claude.com/docs/en/model-config
**호환 모델**: Claude Fable 5, Claude Opus 5, Claude Sonnet 5, Claude Sonnet 4.6, Claude Opus 4.8, Claude Haiku 4.5
