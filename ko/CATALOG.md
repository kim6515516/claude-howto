<!-- i18n-source: CATALOG.md -->
<!-- i18n-source-sha: d17d515 -->
<!-- i18n-date: 2026-10-26 -->

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

# Claude Code 기능 카탈로그

> Claude Code 전체 기능의 빠른 참조: 명령어, 에이전트, 스킬, 플러그인, 훅.

**내비게이션**: [명령어](#슬래시-명령어) | [권한 모드](#권한-모드) | [서브에이전트](#서브에이전트) | [스킬](#스킬) | [플러그인](#플러그인) | [MCP 서버](#mcp-서버) | [훅](#훅) | [메모리](#메모리-파일) | [새 기능](#새-기능2026년-4월)

---

## 요약

| 기능 | 내장 | 예시 | 합계 | 레퍼런스 |
|---------|----------|----------|-------|-----------|
| **슬래시 명령어** | 60개 이상 | 8 | 68개 이상 | [01-slash-commands/](01-slash-commands/) |
| **서브에이전트** | 6 | 9 | 15 | [04-subagents/](04-subagents/) |
| **스킬** | 번들 10 | 6 | 16 | [03-skills/](03-skills/) |
| **플러그인** | - | 3 | 3 | [07-plugins/](07-plugins/) |
| **MCP 서버** | - | 4 | 4 | [05-mcp/](05-mcp/) |
| **훅** | 33 이벤트 | 9 | 42 | [06-hooks/](06-hooks/) |
| **메모리** | 7종류 | 3 | 10 | [02-memory/](02-memory/) |
| **합계** | **116** | **42** | **158** | |

---

## 슬래시 명령어

명령어는 사용자가 호출하는, 특정 동작을 실행하는 단축키입니다.

### 내장 명령어

| 명령어 | 설명 | 사용 상황 |
|---------|-------------|-------------|
| `/help` | 도움말 정보 표시 | 초보자, 명령어 익히기 |
| `/btw` | 일시적인 곁가지 질문 — 메인 컨텍스트를 오염시키지 않음 | 가벼운 곁가지 질문 |
| `/chrome` | Chrome 연동 설정 | 브라우저 자동화 |
| `/clear` | 대화 이력 지우기 | 다시 시작, 컨텍스트 축소 |
| `/diff` | 대화형 diff 뷰어 | 변경 리뷰 |
| `/config` | 설정 표시·편집 | 동작 커스터마이즈 |
| `/status` | 세션 상태 표시 | 현황 확인 |
| `/agents` | 삭제됨: 마법사는 v2.1.198에서 삭제되었고, 명령어는 v2.1.281에서 `/` 메뉴와 `/help`에서 빠짐 — 서브에이전트 생성이나 관리는 Claude에게 요청하거나 `.claude/agents/`를 편집 | Claude에게 요청해 서브에이전트 관리 |
| `/skills` | 사용 가능한 스킬 표시 | 자동 호출 기능 확인 |
| `/hooks` | 설정된 훅 표시 | 자동화 디버깅 |
| `/insights` | 세션 패턴 분석 | 세션 최적화 |
| `/install-slack-app` | Claude Slack 앱 설치 | Slack 연동 |
| `/keybindings` | 키보드 단축키 커스터마이즈 | 키 커스터마이즈 |
| `/mcp` | MCP 서버 목록 표시 | 외부 통합 확인 |
| `/memory` | 읽어 들인 메모리 파일 표시 | 컨텍스트 로드 디버깅 |
| `/mobile` | 모바일용 QR 코드 생성 | 모바일 접근 |
| `/passes` | Claude Code 무료 1주일을 친구와 공유(대상 계정만) | 친구 소개 |
| `/plugin` | 플러그인 관리 | 확장 설치/삭제 |
| `/plan` | 플랜 모드 진입 | 복잡한 구현 |
| `/proactive` | `/loop`의 별칭(v2.1.105) | `/loop`와 동일 |
| `/recap` | 세션에 돌아왔을 때 요약 표시 | 자리를 비운 뒤 컨텍스트 파악 |
| `/rewind` | 체크포인트로 되감기 | 변경 취소, 대안 탐색 |
| `/checkpoint` | `/rewind`의 별칭 | `/rewind`와 동일 |
| `/cost` | `/usage`의 비용 탭을 여는 별칭(v2.1.118+) | 지출 모니터링 |
| `/context` | 컨텍스트 윈도우 사용량 표시 | 대화 길이 관리 |
| `/export` | 대화 내보내기 | 참고용으로 저장 |
| `/extra-usage` | 추가 사용 상한 설정 | 속도 제한 관리 |
| `/feedback` | 피드백이나 버그 리포트 보내기 | 문제 보고 |
| `/login` | Anthropic으로 인증 | 기능 접근 |
| `/logout` | 로그아웃 | 계정 전환 |
| `/sandbox` | 샌드박스 모드 전환 | 안전한 명령어 실행 |
| `/doctor` | 진단 실행 | 문제 해결 |
| `/reload-plugins` | 설치된 플러그인 다시 읽기. v2.1.221 이후 대부분의 설치는 즉시 활성화되므로, 설치 요약이 `Run /reload-plugins to activate.`라고 표시한 경우에만 필요 | 플러그인 관리 |
| `/release-notes` | 릴리스 노트 표시 | 새 기능 확인 |
| `/remote-control` | 원격 제어 활성화 | 원격 접근 |
| `/permissions` | 권한 관리 | 접근 제어 |
| `/rename` | 현재 세션 이름 변경 | 세션 정리 |
| `/resume` | 과거 세션 재개 | 작업 이어 가기 |
| `/tui [default\|fullscreen]` | 터미널 UI 렌더러 설정(`fullscreen` = 깜빡임 없는 대체 화면). 인수 없는 `/tui`는 현재 렌더러 표시 | 전체 화면/tmux에서 깜빡임 없는 그리기 |
| `/tasks` | 백그라운드 작업 표시 | 비동기 처리 모니터링 |
| `/copy` | 직전 응답을 클립보드에 복사 | 출력의 빠른 공유 |
| `/teleport` | 세션을 다른 머신으로 전송 | 원격에서 작업 이어 가기 |
| `/desktop` | Claude 데스크톱 앱 열기 | 데스크톱으로 전환 |
| `/theme` | 컬러 테마 변경. v2.1.118에서 `~/.claude/themes/<name>.json`을 통한 커스텀 테마 추가(플러그인은 `themes/` 디렉터리를 동봉 가능) | 외관 커스터마이즈 |
| `/usage` | 사용량·비용·통계의 정식 명령어 — `/cost`와 `/stats`를 하나의 탭 뷰로 통합(v2.1.118) | 쿼터와 비용 모니터링 |
| `/focus` | 포커스 뷰(주의 분산을 막는 출력 표시) 전환 | 장시간 작업 중 시각적 소음 감소 |
| `/fork` | 현재 대화를 포크 | 대안 탐색 |
| `/stats` | `/usage`의 stats 탭을 여는 별칭(v2.1.118+) | 세션 지표 확인 |
| `/statusline` | 상태 표시줄 설정 | 상태 표시 커스터마이즈 |
| `/stickers` | Claude Code 스티커 주문 | 재미있는 보상 |
| `/fast` | 고속 출력 모드 전환 | 응답 속도 향상 |
| `/terminal-setup` | 터미널 통합 설정 | 터미널 기능 설정 |
| `/undo` | `/rewind`의 별칭(v2.1.108) | `/rewind`와 동일 |
| `/upgrade` | 업그레이드 페이지를 열어 상위 플랜으로 전환 | 플랜 업그레이드 |
| `/team-onboarding` | 이 프로젝트의 Claude Code 이용 현황으로 온보딩 가이드 생성 | 새 멤버 온보딩(v2.1.101) |
| `/code-review ultra` | 현재 변경에 대한 클라우드 멀티 에이전트 코드 리뷰 실행. `/ultrareview`는 별칭으로 남아 있으며 `/code-review ultra`가 권장 호출. Pro와 Max에서는 3회까지 무료, 이후에는 사용 크레딧 필요 | 머지 전 깊이 있는 멀티 에이전트 리뷰(v2.1.112) |
| `/fewer-permission-prompts` | 트랜스크립트를 스캔해 자주 쓰는 읽기 전용 도구의 우선 허용 목록을 제안 | 프로젝트에서 반복되는 권한 프롬프트 감소(v2.1.112) |

### 커스텀 명령어(예시)

| 명령어 | 설명 | 사용 상황 | 범위 | 설치 |
|---------|-------------|-------------|-------|--------------|
| `/optimize` | 코드 최적화 분석 | 성능 개선 | 프로젝트 | `cp 01-slash-commands/optimize.md .claude/commands/` |
| `/pr` | 풀 리퀘스트 준비 | PR 제출 전 | 프로젝트 | `cp 01-slash-commands/pr.md .claude/commands/` |
| `/generate-api-docs` | API 문서 생성 | API 문서화 | 프로젝트 | `cp 01-slash-commands/generate-api-docs.md .claude/commands/` |
| `/commit` | 컨텍스트가 담긴 git 커밋 작성 | 변경 커밋 | 사용자 | `cp 01-slash-commands/commit.md .claude/commands/` |
| `/push-all` | 스테이징·커밋·푸시 | 빠른 배포 | 사용자 | `cp 01-slash-commands/push-all.md .claude/commands/` |
| `/doc-refactor` | 문서 재구성 | 문서 개선 | 프로젝트 | `cp 01-slash-commands/doc-refactor.md .claude/commands/` |
| `/setup-ci-cd` | CI/CD 파이프라인 구축 | 신규 프로젝트 | 프로젝트 | `cp 01-slash-commands/setup-ci-cd.md .claude/commands/` |
| `/unit-test-expand` | 테스트 커버리지 확장 | 테스트 강화 | 프로젝트 | `cp 01-slash-commands/unit-test-expand.md .claude/commands/` |

> **범위**: `사용자` = 개인 워크플로(`~/.claude/commands/`), `프로젝트` = 팀 공유(`.claude/commands/`)

**레퍼런스**: [01-slash-commands/](01-slash-commands/) | [공식 문서](https://code.claude.com/docs/en/interactive-mode)

**빠른 설치(모든 커스텀 명령어)**:
```bash
cp 01-slash-commands/*.md .claude/commands/
```

---

## 권한 모드

Claude Code는 도구 사용 허가를 제어하는 6가지 권한 모드를 지원합니다.

| 모드 | 설명 | 사용 상황 |
|------|-------------|-------------|
| `default` | 도구 호출마다 확인 | 모든 작업을 직접 확인하고 싶을 때. v2.1.283 이후 대화형 터미널과 VS Code 세션의 내장 시작 모드는 auto |
| `acceptEdits` | 파일 편집은 자동 승인, 그 외는 확인 | 신뢰할 수 있는 편집 워크플로 |
| `plan` | 조사해서 계획을 제안. 승인할 때까지 소스는 편집하지 않음 | 계획과 탐색 |
| `auto` | 백그라운드 안전 분류기 검사와 함께 모든 작업 허용 | 장시간 작업, 확인 프롬프트 감소 |
| `bypassPermissions` | 모든 권한 검사 건너뜀 | CI/CD, 헤드리스 환경 |
| `dontAsk` | 권한이 필요한 도구를 건너뜀 | 비대화형 스크립트 |

> **참고**: `auto` 모드는 대상 플랜·모델·프로바이더 조건을 충족해야 합니다 — [09-advanced-features/](09-advanced-features/#auto-mode) 참고. `bypassPermissions`는 신뢰할 수 있는 샌드박스 환경에서만 사용하세요.

**레퍼런스**: [공식 문서](https://code.claude.com/docs/en/permissions)

---

## 서브에이전트

특정 작업을 위해 분리된 컨텍스트를 갖는 전문 특화 AI 어시스턴트입니다.

### 내장 서브에이전트

| 에이전트 | 설명 | 도구 | 모델 | 사용 상황 |
|-------|-------------|-------|-------|-------------|
| **general-purpose** | 다단계 작업, 조사 | 모든 도구 | 모델 상속 | 복잡한 조사, 여러 파일 작업 |
| **Plan** | 구현 계획 | Read, Glob, Grep, Bash | 모델 상속 | 아키텍처 설계, 계획 |
| **Explore** | 코드베이스 탐색 | Read, Glob, Grep | 상속(상한은 Opus) | 빠른 검색, 코드 이해 |
| **claude** | 더 전문적인 에이전트에 해당하지 않는 작업을 위한 범용 에이전트 | 모든 도구 | 모델 상속 | 전용 에이전트가 없는 작업, 디스패치된 백그라운드 세션의 기본값 |
| **statusline-setup** | 상태 표시줄 설정 | Bash, Read, Write | Sonnet | 상태 표시줄 표시 설정 |
| **claude-code-guide** | 도움말과 문서 | Read, Glob, Grep | Haiku | 도움말, 기능 학습 |

### 서브에이전트 설정 필드

| 필드 | 타입 | 설명 |
|-------|------|-------------|
| `name` | 문자열 | 에이전트 식별자 |
| `description` | 문자열 | 에이전트의 역할 |
| `model` | 문자열 | 모델 재정의(`sonnet`, `opus`, `haiku`, `fable`, 전체 모델 ID 또는 `inherit`) |
| `tools` | 배열 | 허용 도구 목록 |
| `effort` | 문자열 | 노력 수준(`low`, `medium`, `high`, `xhigh`, `max`. 모델에 따라 다름) |
| `initialPrompt` | 문자열 | 에이전트를 메인 세션의 에이전트로 실행했을 때(`--agent`) 자동으로 보내지는 첫 사용자 턴 |
| `disallowedTools` | 배열 | 이 에이전트에 명시적으로 금지하는 도구 |

### 커스텀 서브에이전트(예시)

| 에이전트 | 설명 | 사용 상황 | 범위 | 설치 |
|-------|-------------|-------------|-------|--------------|
| `code-reviewer` | 종합적인 코드 품질 | 코드 리뷰 | 프로젝트 | `cp 04-subagents/code-reviewer.md .claude/agents/` |
| `code-architect` | 기능 아키텍처 설계 | 새 기능 계획 | 프로젝트 | `cp 04-subagents/code-architect.md .claude/agents/` |
| `code-explorer` | 코드베이스 심층 분석 | 기존 기능 이해 | 프로젝트 | `cp 04-subagents/code-explorer.md .claude/agents/` |
| `clean-code-reviewer` | 클린 코드 원칙 리뷰 | 유지보수성 리뷰 | 프로젝트 | `cp 04-subagents/clean-code-reviewer.md .claude/agents/` |
| `test-engineer` | 테스트 전략과 커버리지 | 테스트 계획 | 프로젝트 | `cp 04-subagents/test-engineer.md .claude/agents/` |
| `documentation-writer` | 기술 문서 | API 문서, 가이드 | 프로젝트 | `cp 04-subagents/documentation-writer.md .claude/agents/` |
| `secure-reviewer` | 보안 중심 리뷰 | 보안 감사 | 프로젝트 | `cp 04-subagents/secure-reviewer.md .claude/agents/` |
| `implementation-agent` | 전체 기능 구현 | 기능 개발 | 프로젝트 | `cp 04-subagents/implementation-agent.md .claude/agents/` |
| `debugger` | 근본 원인 분석 | 버그 조사 | 사용자 | `cp 04-subagents/debugger.md .claude/agents/` |
| `data-scientist` | SQL 쿼리, 데이터 분석 | 데이터 작업 | 사용자 | `cp 04-subagents/data-scientist.md .claude/agents/` |
| `performance-optimizer` | 프로파일링과 튜닝 | 병목 조사 | 프로젝트 | `cp 04-subagents/performance-optimizer.md .claude/agents/` |

> **범위**: `사용자` = 개인(`~/.claude/agents/`), `프로젝트` = 팀 공유(`.claude/agents/`)

**레퍼런스**: [04-subagents/](04-subagents/) | [공식 문서](https://code.claude.com/docs/en/sub-agents)

**빠른 설치(모든 커스텀 에이전트)**:
```bash
cp 04-subagents/*.md .claude/agents/
```

---

## 스킬

지시서, 스크립트, 템플릿을 동반한 자동 호출 기능입니다.

### 스킬 예시

| 스킬 | 설명 | 자동 호출 조건 | 범위 | 설치 |
|-------|-------------|-------------------|-------|--------------|
| `code-review` | 종합적인 코드 리뷰 | "Review this code", "Check quality" | 프로젝트 | `cp -r 03-skills/code-review-specialist .claude/skills/` |
| `brand-voice` | 브랜드 일관성 검사 | 마케팅 카피 작성 시 | 프로젝트 | `cp -r 03-skills/brand-voice .claude/skills/` |
| `doc-generator` | API 문서 생성 | "Generate docs", "Document API" | 프로젝트 | `cp -r 03-skills/doc-generator .claude/skills/` |
| `refactor` | 체계적 리팩터링(Martin Fowler) | "Refactor this", "Clean up code" | 사용자 | `cp -r 03-skills/refactor ~/.claude/skills/` |

> **범위**: `사용자` = 개인(`~/.claude/skills/`), `프로젝트` = 팀 공유(`.claude/skills/`)

### 스킬 구조

```
~/.claude/skills/skill-name/
├── SKILL.md          # 스킬 정의와 지시
├── scripts/          # 보조 스크립트
└── templates/        # 출력 템플릿
```

### 스킬 프런트매터 필드

스킬은 설정을 위해 `SKILL.md` 안에서 YAML 프런트매터를 지원합니다.

| 필드 | 타입 | 설명 |
|-------|------|-------------|
| `name` | 문자열 | 스킬 표시 이름 |
| `description` | 문자열 | 스킬의 역할 |
| `when_to_use` | 문자열 | `description`에 덧붙여지는 트리거 문구나 요청 예시 |
| `effort` | 문자열 | 노력 수준(`low`, `medium`, `high`, `xhigh`, `max`. 모델에 따라 다름) |
| `shell` | 문자열 | 인라인 `` !`command` `` 블록에서 사용할 셸(기본은 `bash`, 또는 `powershell`) |

**레퍼런스**: [03-skills/](03-skills/) | [공식 문서](https://code.claude.com/docs/en/skills)

**빠른 설치(모든 스킬)**:
```bash
cp -r 03-skills/* ~/.claude/skills/
```

### 번들 스킬

| 스킬 | 설명 | 자동 호출 조건 |
|-------|-------------|-------------------|
| `/simplify` | 품질 관점에서 코드 리뷰 | 코드 작성 후 |
| `/batch` | 큰 변경을 5~30개의 독립된 단위로 나누고, 단위마다 백그라운드 서브에이전트가 전용 워크트리에서 실행 | 대규모 병렬 리팩터링 |
| `/debug [description]` | 세션의 디버그 로그를 활성화하고 그 로그를 읽어 문제를 조사 | Claude Code 자체의 디버깅 |
| `/loop` | 일정 간격으로 프롬프트 실행 | 반복 작업 |
| `/claude-api` | Claude API로 앱 구축 | API 개발 |

---

## 플러그인

명령어, 에이전트, MCP 서버, 훅을 묶은 번들입니다.

### 플러그인 예시

| 플러그인 | 설명 | 구성 요소 | 사용 상황 | 범위 | 설치 |
|--------|-------------|------------|-------------|-------|--------------|
| `pr-review` | PR 리뷰 워크플로 | 명령어 3, 에이전트 3, GitHub MCP | 코드 리뷰 | 프로젝트 | `claude --plugin-dir ./07-plugins/pr-review` |
| `devops-automation` | 배포와 모니터링 | 명령어 4, 에이전트 3, K8s MCP | DevOps 작업 | 프로젝트 | `/plugin install devops-automation` |
| `documentation` | 문서 생성 스위트 | 명령어 4, 에이전트 3, 템플릿 | 문서 | 프로젝트 | `/plugin install documentation` |

> **범위**: `프로젝트` = 팀 공유, `사용자` = 개인 워크플로

### 플러그인 구조

```text
my-plugin/
├── .claude-plugin/
│   └── plugin.json   # 매니페스트 파일(.claude-plugin/ 안에는 이 파일만)
├── commands/         # 슬래시 명령어
├── agents/           # 서브에이전트
├── skills/           # 스킬 (<name>/SKILL.md)
├── hooks/
│   └── hooks.json    # 훅 설정
├── .mcp.json         # MCP 설정
├── bin/              # 실행 파일
└── scripts/          # 유틸리티 스크립트
```

**레퍼런스**: [07-plugins/](07-plugins/) | [공식 문서](https://code.claude.com/docs/en/plugins)

**플러그인 관리 명령어**:
```bash
/plugin list              # 설치된 플러그인 목록
/plugin install <name>    # 플러그인 설치
/plugin uninstall <name>  # 플러그인 제거
claude plugin update <name>   # 플러그인 업데이트(CLI. /plugin update라는 슬래시 형식은 설명문에서 언급되지만 명령어 레퍼런스에는 존재하지 않음)
```

---

## MCP 서버

외부 도구와 API 접근을 위한 Model Context Protocol 서버입니다.

### 일반적인 MCP 서버

| 서버 | 설명 | 사용 상황 | 범위 | 설치 |
|--------|-------------|-------------|-------|--------------|
| **GitHub** | PR 관리, issue, 코드 | GitHub 워크플로 | 로컬 | `claude mcp add github -- npx -y @modelcontextprotocol/server-github` |
| **Database** | SQL 쿼리, 데이터 접근 | DB 작업 | 로컬 | `claude mcp add db -- npx -y @modelcontextprotocol/server-postgres` |
| **Filesystem** | 고급 파일 작업 | 복잡한 파일 작업 | 로컬 | `claude mcp add fs -- npx -y @modelcontextprotocol/server-filesystem` |
| **Slack** | 팀 커뮤니케이션 | 알림, 업데이트 | 프로젝트 | 설정으로 구성 |
| **Google Docs** | 문서 접근 | 문서 편집·리뷰 | 프로젝트 | 설정으로 구성 |
| **Asana** | 프로젝트 관리 | 작업 추적 | 프로젝트 | 설정으로 구성 |
| **Stripe** | 결제 데이터 | 재무 분석 | 프로젝트 | 설정으로 구성 |
| **Memory** | 영속 메모리 | 세션을 넘나드는 기억 | 사용자 | 설정으로 구성 |
| **Context7** | 라이브러리 문서 | 최신 문서 검색 | 사용자 | 설정으로 구성(서드파티 서버) |

> **범위**: `로컬` = `--scope` 없는 `claude mcp add`의 기본값(나만·이 프로젝트, `~/.claude.json`), `프로젝트` = 팀(`.mcp.json`, `--scope project`), `사용자` = 개인(`~/.claude.json`, `--scope user`), `내장` = 사전 설치

### MCP 설정 예시

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**레퍼런스**: [05-mcp/](05-mcp/) | [MCP 프로토콜 문서](https://modelcontextprotocol.io)

**빠른 설치(GitHub MCP)**:
```bash
export GITHUB_TOKEN="your_token" && claude mcp add github -- npx -y @modelcontextprotocol/server-github
```

---

## 훅

Claude Code의 이벤트에서 셸 명령어를 자동 실행하는 이벤트 기반 자동화입니다.

### 훅 이벤트

| 이벤트 | 설명 | 발생 시점 | 사용 사례 |
|-------|-------------|----------------|-----------|
| `SessionStart` | 세션 시작·재개 | 세션 초기화 시 | 설정 작업 |
| `Setup` | 저장소 설정 또는 유지보수 실행 | `--init-only`, 또는 `-p`와 함께 쓴 `--init`/`--maintenance`인 경우만 | 도구 준비, 의존성 설치 |
| `InstructionsLoaded` | 지시 읽기 완료 | CLAUDE.md 또는 규칙 파일 로드 시 | 커스텀 지시 처리 |
| `UserPromptSubmit` | 프롬프트 처리 전 | 사용자가 메시지 전송 시 | 입력 검증 |
| `UserPromptExpansion` | 입력한 슬래시 명령어(스킬, 커스텀 명령어, MCP 프롬프트)가 프롬프트로 확장됨 | `UserPromptSubmit` 뒤, 확장된 프롬프트가 Claude에 도달하기 전 | `/command` 직접 사용 차단, 스킬별 컨텍스트 추가, 명령어 로그 기록 |
| `PreToolUse` | 도구 실행 전 | 어떤 도구든 실행되기 전 | 검증, 로그 |
| `PermissionRequest` | 권한 대화 상자 표시 | 민감한 작업 전 | 커스텀 승인 흐름 |
| `PermissionDenied` | 사용자가 권한 요청을 거부 | 권한 거부 후 | 로그, 분석, 정책 적용 |
| `PostToolUse` | 도구 성공 후 | 어떤 도구든 완료 후 | 정형화, 알림 |
| `PostToolUseFailure` | 도구 실행 실패 | 도구 오류 후 | 오류 처리, 로그 |
| `PostToolBatch` | 도구 실행 배치 완료 후 | 도구 배치 종료 시 | 집계 보고, 배치 검증 |
| `Notification` | 알림 전송 | Claude가 알림 전송 시 | 외부 경보 |
| `MessageDisplay` | 어시스턴트 메시지 표시 시 | 메시지 그리는 중 | 표시 텍스트 변환·숨김 |
| `SubagentStart` | 서브에이전트 생성 | 서브에이전트 작업 시작 시 | 서브에이전트 컨텍스트 초기화 |
| `SubagentStop` | 서브에이전트 종료 | 서브에이전트 작업 완료 시 | 액션 연쇄 |
| `Stop` | Claude가 응답 완료 | 응답 완료 시 | 후처리, 보고 |
| `StopFailure` | API 오류로 턴 종료 | API 오류 발생 시 | 오류 복구, 로그 |
| `TeammateIdle` | 팀 멤버 에이전트가 유휴 상태 | 에이전트 팀 협업 시 | 작업 분배 |
| `TaskCompleted` | 작업 완료 표시(todo 도구가 활성화된 경우에만 발생 — Claude 3.x, Opus 4~4.7, Sonnet 4~4.6, Haiku 4.5에서만 기본 활성화. `CLAUDE_CODE_ENABLE_TODO_TOOLS=1`로 복원) | 작업 완료 시 | 작업 후처리 |
| `TaskCreated` | TaskCreate로 작업 생성(todo 도구가 활성화된 경우에만 발생 — Claude 3.x, Opus 4~4.7, Sonnet 4~4.6, Haiku 4.5에서만 기본 활성화. `CLAUDE_CODE_ENABLE_TODO_TOOLS=1`로 복원) | 새 작업 생성 시 | 작업 추적, 로그 |
| `ConfigChange` | 설정 업데이트 | 설정 변경 시 | 설정 변경 대응 |
| `CwdChanged` | 작업 디렉터리 변경 | 디렉터리 변경 시 | 디렉터리별 설정 |
| `DirectoryAdded` | 세션 중 작업 디렉터리가 추가 등록됨 | `/add-dir` 또는 SDK `register_repo_root` | 새 디렉터리용 도구 설정 |
| `FileChanged` | 감시 파일 변경 | 파일 변경 시 | 파일 감시, 재빌드 |
| `PreCompact` | 컴팩트 작업 전 | 컨텍스트 압축 시 | 상태 보존 |
| `PostCompact` | 컴팩트 완료 후 | 컴팩트 완료 시 | 컴팩트 후 액션 |
| `PreModelSwitch` | 모델 전환 적용 전 | 모델 전환 요청 시 | 모델 변경 게이트·거부 |
| `PostModelSwitch` | 세션의 모델 변경 후 | 모델 전환 완료 시 | 모델 변경 로그·연동 |
| `WorktreeCreate` | 워크트리 생성 중 | Git 워크트리 생성 시 | 워크트리 환경 설정 |
| `WorktreeRemove` | 워크트리 삭제 중 | Git 워크트리 삭제 시 | 워크트리 리소스 정리 |
| `Elicitation` | MCP 서버가 입력을 요청 | MCP elicitation 발생 시 | 입력 검증 |
| `ElicitationResult` | 사용자가 elicitation에 응답 | 사용자 응답 시 | 응답 처리 |
| `SessionEnd` | 세션 종료 | 세션 종료 시 | 정리, 상태 저장 |

### 훅 예시

| 훅 | 설명 | 이벤트 | 범위 | 설치 |
|------|-------------|-------|-------|--------------|
| `validate-bash.py` | 명령어 검증 | PreToolUse:Bash | 프로젝트 | `cp 06-hooks/validate-bash.py .claude/hooks/` |
| `security-scan.py` | 보안 스캔 | PostToolUse:Write | 프로젝트 | `cp 06-hooks/security-scan.py .claude/hooks/` |
| `format-code.sh` | 자동 정형화 | PostToolUse:Write | 사용자 | `cp 06-hooks/format-code.sh ~/.claude/hooks/` |
| `validate-prompt.py` | 프롬프트 검증 | UserPromptSubmit | 프로젝트 | `cp 06-hooks/validate-prompt.py .claude/hooks/` |
| `context-tracker.py` | 토큰 사용량 추적 | Stop | 사용자 | `cp 06-hooks/context-tracker.py ~/.claude/hooks/` |
| `pre-commit.sh` | 커밋 전 검증 | PreToolUse:Bash | 프로젝트 | `cp 06-hooks/pre-commit.sh .claude/hooks/` |
| `log-bash.sh` | 명령어 로그 | PostToolUse:Bash | 사용자 | `cp 06-hooks/log-bash.sh ~/.claude/hooks/` |
| `dependency-check.sh` | 매니페스트 변경 시 취약점 스캔 | PostToolUse:Write | 프로젝트 | `cp 06-hooks/dependency-check.sh .claude/hooks/` |

> **범위**: `프로젝트` = 팀(`.claude/settings.json`), `사용자` = 개인(`~/.claude/settings.json`)

### 훅 설정

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          { "type": "command", "command": "~/.claude/hooks/validate-bash.py" }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write",
        "hooks": [
          { "type": "command", "command": "~/.claude/hooks/format-code.sh" }
        ]
      }
    ]
  }
}
```

**레퍼런스**: [06-hooks/](06-hooks/) | [공식 문서](https://code.claude.com/docs/en/hooks)

**빠른 설치(모든 훅)**:
```bash
mkdir -p ~/.claude/hooks && cp 06-hooks/*.sh ~/.claude/hooks/ && chmod +x ~/.claude/hooks/*.sh
```

---

## 메모리 파일

세션을 넘나들며 자동으로 읽어 들이는 영속 컨텍스트입니다.

### 메모리 종류

| 종류 | 위치 | 범위 | 사용 상황 |
|------|----------|-------|-------------|
| **관리형 정책** | 조직 관리 정책 | 조직 | 조직 전체 표준 강제 |
| **프로젝트** | `./CLAUDE.md` | 프로젝트(팀) | 팀 규약, 프로젝트 맥락 |
| **프로젝트 규칙** | `.claude/rules/` | 프로젝트(팀) | 모듈화된 프로젝트 규칙 |
| **사용자** | `~/.claude/CLAUDE.md` | 사용자(개인) | 개인 선호 |
| **사용자 규칙** | `~/.claude/rules/` | 사용자(개인) | 모듈화된 개인 규칙 |
| **로컬** | `./CLAUDE.local.md` | 로컬(git 무시) | 머신 고유 재정의(2026년 3월 기준 공식 문서에 기재 없음, 레거시일 가능성) |
| **Auto Memory** | 자동 | 세션 | 자동으로 수집된 통찰과 정정 |

> **범위**: `조직` = 관리자 관리, `프로젝트` = git으로 팀 공유, `사용자` = 개인 선호, `로컬` = 커밋 대상 아님, `세션` = 자동 관리

**레퍼런스**: [02-memory/](02-memory/) | [공식 문서](https://code.claude.com/docs/en/memory)

**빠른 설치**:
```bash
cp 02-memory/project-CLAUDE.md ./CLAUDE.md
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

---

## 새 기능(2026년 4월)

| 기능 | 설명 | 사용법 |
|---------|-------------|------------|
| **/focus** | 주의 분산을 막는 출력 표시를 위한 포커스 뷰 전환(v2.1.110) | `/focus`로 장시간 작업 중 시각적 소음 감소 |
| **/proactive** | `/loop`의 별칭 — 같은 반복 작업 동작(v2.1.105) | `/proactive`를 `/loop`와 호환되게 사용 |
| **/recap** | 기존 세션에 돌아왔을 때 요약 표시(v2.1.108) | 자리를 비운 뒤 `/recap`을 실행해 맥락 되찾기 |
| **/tui** | 터미널 UI 렌더러 설정: `/tui fullscreen`으로 깜빡임 없는 그리기, `/tui default`로 원래대로. 인수 없으면 현재 렌더러 표시(v2.1.110) | 전체 화면 터미널이나 tmux에서 `/tui fullscreen` 사용 |
| **/undo** | `/rewind`의 별칭(v2.1.108) | `/undo`, `/checkpoint`, `/rewind` 어느 것이든 같은 방식으로 사용 가능 |
| **Monitor 도구** | 백그라운드 명령어의 stdout을 감시해 폴링이 아니라 이벤트로 반응(v2.1.98+) | [고급 기능](09-advanced-features/)을 통해 Monitor 도구 사용 |
| **/team-onboarding** | 프로젝트의 Claude Code 설정에서 온보딩 가이드를 자동 생성(v2.1.101) | 프로젝트에서 `/team-onboarding` 실행 |
| **원격 제어** | API를 통해 Claude Code 세션을 원격 제어 | 원격 제어 API로 프롬프트 전송과 응답 수신을 프로그램적으로 수행 |
| **웹 세션** | 클라우드 세션에서 Claude Code 실행 | `claude --cloud "task"` 또는 claude.ai/code에서 시작 |
| **데스크톱 앱** | Claude Code의 네이티브 데스크톱 앱 | `/desktop` 또는 Anthropic 사이트에서 다운로드 |
| **Agent Teams** | 관련 작업에서 여러 에이전트를 협업 | 협업과 맥락 공유를 수행하는 teammate 에이전트 설정 |
| **작업 목록** | 백그라운드 작업 관리와 모니터링 | `/tasks`로 백그라운드 처리 표시·관리 |
| **프롬프트 후보** | 컨텍스트 의존적인 명령어 후보 | 현재 맥락에 따라 후보가 자동 표시 |
| **Git 워크트리** | 병렬 개발을 위한 격리된 git 워크트리 | 워크트리 명령어로 안전한 병렬 브랜치 작업 |
| **샌드박스화** | 안전을 위한 격리 실행 환경 | `/sandbox`로 전환, 제한 환경 안에서 명령어 실행 |
| **MCP OAuth** | MCP 서버용 OAuth 인증 | 안전한 접근을 위해 MCP 서버 설정에서 OAuth 인증 정보 구성 |
| **MCP 도구 검색** | MCP 도구를 동적으로 검색·발견 | 연결된 서버 전체에서 사용 가능한 MCP 도구 검색 |
| **예약 작업** | `/loop`와 cron 도구로 반복 작업 설정 | `/loop 5m /command` 또는 CronCreate 도구 사용 |
| **Chrome 연동** | Claude in Chrome 확장 기능을 통해 자신의 Chrome/Edge 조작(보이는 창, 자신의 로그인 상태) | `--chrome` 플래그 또는 `/chrome` 명령어 사용 |
| **키 바인딩 커스터마이즈** | 코드 대응을 포함한 키 바인딩 커스터마이즈 | `/keybindings`를 사용하거나 `~/.claude/keybindings.json` 편집 |
| **Auto Mode** | 백그라운드 안전 분류기 검사와 함께 완전 자율 동작 | `Shift+Tab`으로 전환, 또는 `--permission-mode auto` |
| **채널** | 다중 채널 통신(Telegram, Slack 등)(Research Preview) | 채널 플러그인 설정, 2026년 3월 |
| **음성 입력** | 프롬프트 음성 입력 | 마이크 아이콘 또는 음성 키 바인딩 사용 |
| **Agent 훅 종류** | 셸 명령어 실행이 아니라 서브에이전트를 생성하는 훅 | 훅 설정에서 `"type": "agent"` 지정 |
| **Prompt 훅 종류** | Claude 모델에 프롬프트를 보내 단일 턴으로 평가하게 하는 훅. 모델은 판정을 JSON으로 반환 | 훅 설정에서 `"type": "prompt"` 지정 |
| **MCP Elicitation** | MCP 서버가 도구 실행 중 사용자 입력을 요청할 수 있음 | `Elicitation`과 `ElicitationResult` 훅 이벤트로 처리 |
| **플러그인 LSP 지원** | 플러그인을 통한 Language Server Protocol 통합 | 에디터 기능을 위해 `plugin.json`에서 LSP 서버 설정 |
| **관리형 Drop-in** | 조직 관리 드롭인 설정(v2.1.83) | 관리 정책으로 관리자가 설정, 모든 사용자에게 자동 적용 |

---

## 빠른 참조 매트릭스

### 기능 선정 가이드

| 필요한 것 | 권장 기능 | 이유 |
|------|---------------------|-----|
| 빠른 단축키 | 슬래시 명령어 | 수동, 즉시 |
| 영속 컨텍스트 | 메모리 | 자동 읽기 |
| 복잡한 자동화 | 스킬 | 자동 호출 |
| 전문 작업 | 서브에이전트 | 컨텍스트 분리 |
| 외부 데이터 | MCP 서버 | 실시간 접근 |
| 이벤트 자동화 | 훅 | 이벤트 트리거 |
| 완전한 솔루션 | 플러그인 | 올인원 |

### 설치 우선순위

| 우선순위 | 기능 | 명령어 |
|----------|---------|---------|
| 1. 필수 | 메모리 | `cp 02-memory/project-CLAUDE.md ./CLAUDE.md` |
| 2. 일상 사용 | 슬래시 명령어 | `cp 01-slash-commands/*.md .claude/commands/` |
| 3. 품질 | 서브에이전트 | `cp 04-subagents/*.md .claude/agents/` |
| 4. 자동화 | 훅 | `cp 06-hooks/*.sh ~/.claude/hooks/ && chmod +x ~/.claude/hooks/*.sh` |
| 5. 외부 | MCP | `claude mcp add github -- npx -y @modelcontextprotocol/server-github` |
| 6. 고급 | 스킬 | `cp -r 03-skills/* ~/.claude/skills/` |
| 7. 완전 | 플러그인 | `claude --plugin-dir ./07-plugins/pr-review` |

---

## 한 번의 명령어로 전체 설치

이 저장소의 모든 예제를 설치합니다:

```bash
# 디렉터리 생성
mkdir -p .claude/{commands,agents,skills} ~/.claude/{hooks,skills}

# 모든 기능 설치
cp 01-slash-commands/*.md .claude/commands/ && \
cp 02-memory/project-CLAUDE.md ./CLAUDE.md && \
cp -r 03-skills/* ~/.claude/skills/ && \
cp 04-subagents/*.md .claude/agents/ && \
cp 06-hooks/*.sh ~/.claude/hooks/ && \
chmod +x ~/.claude/hooks/*.sh
```

---

## 추가 리소스

- [Claude Code 공식 문서](https://code.claude.com/docs/en/overview)
- [MCP 프로토콜 사양](https://modelcontextprotocol.io)
- [학습 로드맵](LEARNING-ROADMAP.md)
- [메인 README](README.md)

---

**최종 업데이트**: 2026년 10월 18일
**Claude Code 버전**: 2.1.302
**정보 출처**:
- https://code.claude.com/docs/en/tools-reference#task-tool-availability
- https://code.claude.com/docs/en/overview
- https://code.claude.com/docs/en/commands
- https://code.claude.com/docs/en/hooks
- https://github.com/anthropics/claude-code/releases/tag/v2.1.118
- https://code.claude.com/docs/en/plugins-reference
- https://code.claude.com/docs/en/discover-plugins
- https://code.claude.com/docs/en/sub-agents
- https://code.claude.com/docs/en/permission-modes
- https://code.claude.com/docs/en/cli-reference
- https://code.claude.com/docs/en/skills
- https://code.claude.com/docs/en/mcp
- https://code.claude.com/docs/en/chrome
- https://code.claude.com/docs/en/plugins/manifest-reference
- https://code.claude.com/docs/en/plugins/cli-reference
**호환 모델**: Claude Fable 5, Claude Opus 5, Claude Sonnet 5, Claude Sonnet 4.6, Claude Opus 4.8, Claude Haiku 4.5
