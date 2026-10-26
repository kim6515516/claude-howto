<!-- i18n-source: 09-advanced-features/README.md -->
<!-- i18n-source-sha: a7a0ea2 -->
<!-- i18n-date: 2026-10-26 -->

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../../resources/logos/claude-howto-logo.svg">
</picture>

# 고급 기능

Claude Code의 고급 기능을 포괄적으로 해설하는 가이드입니다. 플랜 모드, 확장 사고, 자동 모드, 백그라운드 작업, 권한 모드, 프린트 모드(비대화 모드), 세션 관리, 대화 기능, 채널, 음성 입력, 리모트 컨트롤, Web 세션, 데스크톱 앱, 태스크 리스트, 프롬프트 추천, Git 워크트리, 샌드박스, 관리형 설정, 설정 파일 등을 다룹니다.

## 목차

1. [개요](#개요)
2. [플랜 모드](#플랜-모드)
3. [확장 사고](#확장-사고)
4. [자동 모드](#자동-모드)
5. [백그라운드 작업](#백그라운드-작업)
6. [Monitor 도구(이벤트 기반 스트림)](#monitor-도구이벤트-기반-스트림)
7. [예약 작업](#예약-작업)
8. [권한 모드](#권한-모드)
9. [헤드리스 모드](#헤드리스-모드)
10. [세션 관리](#세션-관리)
11. [대화 기능](#대화-기능)
12. [TUI 모드(전체 화면)](#tui-모드전체-화면)
13. [음성 입력](#음성-입력)
14. [채널](#채널)
15. [Chrome 연동](#chrome-연동)
16. [리모트 컨트롤](#리모트-컨트롤)
17. [Web 세션](#web-세션)
18. [데스크톱 앱](#데스크톱-앱)
19. [태스크 리스트](#태스크-리스트)
20. [프롬프트 추천](#프롬프트-추천)
21. [Git 워크트리](#git-워크트리)
22. [샌드박스](#샌드박스)
23. [관리형 설정(엔터프라이즈)](#관리형-설정엔터프라이즈)
24. [설정과 구성](#설정과-구성)
25. [에이전트 팀](#에이전트-팀)
26. [모범 사례](#모범-사례)
27. [추가 자료](#추가-자료)

---

## 개요

Claude Code의 고급 기능은 플랜, 추론, 자동화, 제어의 각 메커니즘으로 핵심 기능을 확장합니다. 이러한 기능을 통해 복잡한 개발 작업, 코드 리뷰, 자동화, 다중 세션 관리에 대응하는 고도화된 워크플로를 구현할 수 있습니다.

**주요 고급 기능:**
- **플랜 모드**: 코딩 전에 상세한 구현 계획을 작성합니다
- **확장 사고**: 복잡한 문제에 대해 깊은 추론을 수행합니다
- **자동 모드**: 백그라운드 안전 분류기가 각 작업을 실행 전에 검토합니다
- **백그라운드 작업**: 대화를 막지 않고 장시간 처리를 실행합니다
- **권한 모드**: Claude가 실행할 수 있는 작업을 제어합니다(`default`, `acceptEdits`, `plan`, `auto`, `dontAsk`, `bypassPermissions`)
- **프린트 모드**: 자동화나 CI/CD를 위해 Claude Code를 비대화형으로 실행합니다(`claude -p`)
- **세션 관리**: 여러 작업 세션을 관리합니다
- **대화 기능**: 키보드 단축키, 여러 줄 입력, 명령어 히스토리
- **음성 입력**: 푸시 투 토크 방식의 음성 입력(20개 언어 STT 지원)
- **채널**: MCP 서버가 실행 중인 세션에 메시지를 푸시합니다(Research Preview)
- **리모트 컨트롤**: Claude.ai 또는 Claude 앱에서 Claude Code를 조작합니다
- **Web 세션**: claude.ai/code에서 브라우저로 Claude Code를 실행합니다
- **데스크톱 앱**: 시각적 diff 리뷰와 다중 세션을 지원하는 독립 실행형 앱
- **태스크 리스트**: 컨텍스트 컴팩션 후에도 유지되는 영속적인 작업 추적
- **프롬프트 추천**: 컨텍스트에 맞는 스마트한 명령어 추천 표시
- **Git 워크트리**: 병렬 작업을 위한 격리된 워크트리 브랜치
- **샌드박스**: OS 수준의 파일 시스템과 네트워크 격리
- **관리형 설정**: plist, 레지스트리, 관리형 파일을 통한 엔터프라이즈 배포
- **설정**: JSON 설정 파일로 동작을 커스터마이즈합니다

---

## 플랜 모드

플랜 모드에서는 복잡한 작업을 구현하기 전에 Claude가 충분히 생각하여, 검토와 승인이 가능한 상세한 계획을 작성할 수 있습니다.

### 플랜 모드란

플랜 모드는 2단계 접근 방식입니다:
1. **계획 단계**: Claude가 작업을 분석하고 상세한 구현 계획을 작성합니다
2. **구현 단계**: 승인 후 Claude가 계획을 실행합니다

### 플랜 모드를 사용해야 할 때

✅ 플랜 모드가 적합한 경우:
- 여러 파일에 걸친 복잡한 리팩터링
- 새 기능 구현
- 아키텍처 변경
- 데이터베이스 마이그레이션
- 대규모 API 재설계

❌ 플랜 모드가 적합하지 않은 경우:
- 단순한 버그 수정
- 포맷 변경
- 단일 파일 편집
- 간단한 질문

### 플랜 모드 시작하기

**슬래시 명령어:**
```bash
/plan Implement user authentication system
```

**CLI 플래그:**
```bash
claude --permission-mode plan
```

**기본값으로 설정:**
```json
{
  "permissions": {
    "defaultMode": "plan"
  }
}
```

**키보드 단축키:**
- `Shift + Tab` — 권한 모드를 전환합니다(플랜 모드 포함)
- `Alt + M` — 권한 모드를 전환합니다(Windows 전용. 런타임이 VT 입력 모드를 활성화하지 않는 경우)

### 플랜 모드의 장점

- **구조화된 구현 접근**: 구현 단계를 상세하게 분해합니다
- **검토와 승인**: 실행 전에 계획을 승인하거나 조정할 수 있습니다
- **위험 식별**: 구현 전에 잠재적인 문제를 찾아냅니다
- **명확한 단계 구분**: 구현 단계와 마일스톤을 정리합니다

### 예: 기능 구현

```
User: /plan Add a real-time notification system

Claude: I'll create a plan for implementing real-time notifications.

## Implementation Plan

### Phase 1: Infrastructure Setup
1. Install WebSocket libraries (socket.io)
2. Set up WebSocket server
3. Configure connection management

### Phase 2: Backend Implementation
4. Create notification service
5. Implement notification queue
6. Add database schema for notifications
7. Create API endpoints

### Phase 3: Frontend Integration
8. Set up WebSocket client
9. Create notification UI components
10. Implement notification state management
11. Add notification permissions

### Phase 4: Testing & Deployment
12. Write unit tests
13. Write integration tests
14. Update documentation
15. Deploy to staging

Estimated time: 3-4 hours
Files to modify: 12
New files to create: 8

Ready to proceed? (yes/no/modify plan)

User: yes

Claude: [Begins implementation following the plan]
```

### 계획 수정

```
User: Modify the plan - skip the queue for now, we'll add it later

Claude: Updated plan:
[Shows modified plan with queue removed]

User: Looks good, proceed

Claude: [Implements modified plan]
```

### 플랜 모드 설정

플랜 모드는 CLI 플래그 또는 슬래시 명령어로 시작합니다:

```bash
# CLI에서 플랜 모드를 시작
claude --permission-mode plan

# 또는 REPL 안에서 /plan 슬래시 명령어를 사용
/plan Implement user authentication system
```

**플랜용 모델 별칭:** `opusplan`을 모델 별칭으로 사용하면 플랜에는 Opus, 실행에는 Sonnet을 나눠 쓸 수 있습니다:

```bash
claude --model opusplan "design and implement the new API"
```

**외부 편집기에서 계획 편집:** `Ctrl+G`를 누르면 현재 계획을 외부 편집기에서 열어 상세하게 수정할 수 있습니다.

> **v2.1.112 업데이트:** 계획 파일이 무작위 단어 대신 생성 원본 프롬프트에 기반한 이름으로 저장되어, 찾아보고 재사용하기 쉬워졌습니다.

---

## 확장 사고

확장 사고를 통해 Claude는 복잡한 문제에 대해 해답을 제시하기 전에 더 많은 시간을 들여 추론할 수 있습니다.

### 확장 사고란

확장 사고는 의도적인 단계별 추론 과정으로, Claude는 다음을 수행합니다:
- 복잡한 문제 분해
- 여러 접근 방식 검토
- 트레이드오프 평가
- 엣지 케이스 추론

### 확장 사고 시작하기

**키보드 단축키:**
- `Option + T`(macOS) / `Alt + T`(Windows/Linux) — 확장 사고를 전환합니다

**자동 시작:**
- 모든 모델(Opus 4.7, Sonnet 4.6, Haiku 4.5)에서 기본 활성화
- Opus 4.7: 적응형 추론으로 노력 수준을 지정할 수 있습니다: `low`(○), `medium`(◐), `high`(●), `xhigh`(Opus 4.7 전용, Opus 4.7 출시 이후 Claude Code의 기본값, 2026-04-16), `max`. Opus 4.6과 Sonnet 4.6도 `low`, `medium`, `high`, `max`를 지원합니다(`xhigh` 없음). Opus 4.7은 네이티브로 1M 토큰 컨텍스트 윈도우를 가집니다(1M 컨텍스트 지원은 v2.1.117에서 도입되었습니다. 그 이전에는 `/context`가 Opus 4.7을 200K 윈도우로 잘못 계산해 이른 자동 컴팩션을 일으켰습니다).
- Pro/Max 구독자의 Opus 4.6 / Sonnet 4.6: v2.1.117에서 기본 노력 수준이 `medium`에서 `high`로 상향되었습니다.
- 그 외 모델: 고정 예산(최대 31,999 토큰)

**설정 방법:**
- 전환: `Alt+T` / `Option+T`, 또는 `/config`에서
- 추론 내용 표시: `Ctrl+O`(verbose 모드)
- 노력 수준 설정: `/effort` 명령어 또는 `--effort` 플래그

**커스텀 예산:**
```bash
export MAX_THINKING_TOKENS=1024
```

**노력 수준**(Opus 4.7, Opus 4.6, Sonnet 4.6에서 지원):
```bash
export CLAUDE_CODE_EFFORT_LEVEL=xhigh   # low (○), medium (◐), high (●), xhigh (Opus 4.7 only, default), or max
```

**CLI 플래그:**
```bash
claude --effort high "complex architectural review"
```

**슬래시 명령어:**
```
/effort high
```

> **참고:** 프롬프트에 "ultrathink"라는 키워드를 포함하면 깊은 추론 모드가 시작됩니다. 노력 수준 `low`, `medium`, `high`, `max`는 Opus 4.7, Opus 4.6, Sonnet 4.6에서 지원됩니다. `xhigh`(Opus 4.7의 기본값)는 Opus 4.7 전용입니다.

### 확장 사고의 장점

- **깊은 추론**: 복잡한 문제에 대해 더 많은 시간을 들여 사고합니다
- **더 나은 아키텍처 판단**: 포괄적인 평가에 근거해 정보에 기반한 선택을 할 수 있습니다
- **엣지 케이스 고려**: 발생할 수 있는 문제와 시나리오를 꼼꼼히 검토합니다
- **철저한 분석**: 복잡한 문제 해결을 위한 구조화된 접근

### 예: 아키텍처 판단

```
User: /think Should we use microservices or a monolith for our e-commerce platform?

Claude: Let me think through this architectural decision carefully...

<extended_thinking>
## Context Analysis
- Team size: 5 developers
- Expected traffic: 10k daily users initially
- Need to scale to 100k+ users
- Limited DevOps resources
- 6-month timeline to MVP

## Approach 1: Microservices
Pros:
+ Independent scaling
+ Technology flexibility
+ Team independence
+ Fault isolation

Cons:
- Operational complexity
- Network overhead
- Distributed tracing needed
- Requires DevOps expertise
- Slower initial development

## Approach 2: Monolith
Pros:
+ Simpler deployment
+ Faster initial development
+ Easier debugging
+ Lower operational overhead
+ Single codebase

Cons:
- Scaling challenges later
- All-or-nothing deployments
- Technology lock-in
- Potential for tight coupling

## Decision Factors
1. Team size (5 devs) → Favors monolith
2. DevOps resources (limited) → Favors monolith
3. Timeline (6 months) → Favors monolith
4. Future scale (100k users) → Achievable with monolith + caching
5. Complexity budget → Limited

## Recommendation
Start with a **modular monolith**:
- Single deployment unit
- Clear module boundaries
- Clean interfaces between modules
- Prepare for future extraction to microservices if needed

This gives you:
✓ Fast initial development
✓ Low operational complexity
✓ Option to extract services later
✓ Clear architecture

Migration path: When you reach 50k+ users or specific modules need independent scaling, extract those modules into microservices.
</extended_thinking>

**Recommendation**: Implement a modular monolith with clean module boundaries.

This approach balances your current constraints (team size, timeline, DevOps resources) with future scalability needs. You can migrate specific modules to microservices later when there's a clear business need.
```

### 확장 사고 설정

확장 사고는 환경 변수, 키보드 단축키, CLI 플래그로 제어합니다:

```bash
# 사고 토큰 예산을 설정
export MAX_THINKING_TOKENS=16000

# 노력 수준을 설정 (Opus 4.7, Opus 4.6, Sonnet 4.6): low (○), medium (◐), high (●), xhigh (Opus 4.7 only, default), or max
export CLAUDE_CODE_EFFORT_LEVEL=xhigh
```

세션 중에 전환하려면 `Alt+T` / `Option+T`, 노력 수준 설정은 `/effort`, 그 외 설정은 `/config`를 사용합니다.

---

## 자동 모드

자동 모드는 백그라운드 안전 분류기가 각 작업을 실행 전에 검토하는 권한 모드입니다. Claude가 자율적으로 작업하면서도 위험한 작업은 차단할 수 있습니다. 모든 플랜에서 사용할 수 있지만, 대상 모델과 프로바이더 조건을 충족해야 합니다.

### 필요 요건

- **플랜:** Team, Enterprise 또는 API(Pro나 Max 플랜에서는 사용 불가)
- **모델:** Claude Sonnet 4.6 또는 Opus 4.7
- **프로바이더:** Anthropic API만 지원(Bedrock, Vertex, Foundry에서는 미지원)
- **분류기:** 추가 토큰 비용이 발생합니다. 다만 Enterprise 플랜과 Claude API 계정에서는 v2.1.278 이후 서버 측에서 검사가 실행되어 과금되지 않습니다

### 자동 모드 활성화

```bash
# Interactive sessions start in auto mode when no permission mode is configured (v2.1.284+)
# To pick it explicitly, for example when your settings default to another mode:
claude --permission-mode auto

# Or cycle to it with Shift+Tab in the REPL
```

> **v2.1.112 업데이트:** 자동 모드에 `--enable-auto-mode` 플래그가 더 이상 필요하지 않습니다. Max 구독자는 Opus 4.7에서 바로 사용할 수 있습니다.

또는 기본 권한 모드로 설정합니다:

```bash
claude --permission-mode auto
```

설정 파일에서 지정합니다:
```json
{
  "permissions": {
    "defaultMode": "auto"
  }
}
```

### 분류기의 동작

백그라운드 분류기는 다음 결정 순서로 각 작업을 평가합니다:

1. **허용/거부 규칙** — 명시적인 권한 규칙이 먼저 검사됩니다
2. **읽기 전용/편집 자동 승인** — 파일 읽기와 편집은 자동으로 통과합니다
3. **분류기** — 백그라운드 분류기가 작업을 검토합니다
4. **폴백** — 연속 3회 또는 합계 20회 차단 후 프롬프트 확인으로 전환됩니다

### 기본적으로 차단되는 작업

자동 모드는 기본적으로 다음을 차단합니다:

| 차단 대상 | 예 |
|----------------|---------|
| 파이프를 통한 셸 설치 | `curl \| bash` |
| 민감한 데이터의 외부 전송 | API 키나 인증 정보의 네트워크 전송 |
| 프로덕션 배포 | 프로덕션을 대상으로 하는 배포 명령어 |
| 일괄 삭제 | 대규모 디렉터리에서의 `rm -rf` |
| IAM 변경 | 권한과 역할 변경 |
| main으로 강제 푸시 | `git push --force origin main` |

### 기본적으로 허용되는 작업

| 허용 대상 | 예 |
|----------------|---------|
| 로컬 파일 작업 | 프로젝트 파일 읽기·쓰기와 편집 |
| 선언된 의존성 설치 | 매니페스트를 통한 `npm install`, `pip install` |
| 읽기 전용 HTTP | 문서 가져오기를 위한 `curl` |
| 현재 브랜치로 푸시 | `git push origin feature-branch` |

### 자동 모드 설정

**기본 규칙을 JSON으로 출력:**
```bash
claude auto-mode defaults
```

**신뢰 인프라 설정:** 엔터프라이즈 배포용으로 `autoMode.environment` 관리형 설정을 사용합니다. 이를 통해 관리자는 신뢰할 수 있는 CI/CD 환경, 배포 대상, 인프라 패턴을 정의할 수 있습니다.

#### `"$defaults"`로 기본값 확장하기(v2.1.118)

v2.1.118 이후 `autoMode.allow`, `autoMode.soft_deny`, `autoMode.environment`는 `"$defaults"` 토큰을 받아들입니다. 이를 통해 내장 목록을 대체하는 대신 규칙을 **추가**할 수 있습니다. v2.1.118 이전에는 사용자 정의 배열이 아무 알림 없이 내장 설정을 덮어썼습니다.

**변경 전(내장 설정을 대체 — v2.1.118 이전 동작):**

```json
{
  "autoMode": {
    "allow": ["Bash(gh pr list:*)"]
  }
}
```

**변경 후(내장 설정을 확장 — v2.1.118 이후):**

```json
{
  "autoMode": {
    "allow": ["$defaults", "Bash(gh pr list:*)"],
    "soft_deny": ["$defaults", "Bash(kubectl delete:*)"],
    "environment": ["$defaults", "trusted-ci.internal"]
  }
}
```

조직이나 프로젝트 고유의 추가 규칙을 얹으면서 출하 시 기본 규칙은 유지하고 싶을 때 `"$defaults"`를 사용합니다.

### 폴백 동작

분류기의 판단이 불확실한 경우 자동 모드는 사용자에게 묻는 프롬프트 확인으로 폴백합니다:
- **연속 3회** 분류기 차단 후
- 세션 안에서 **합계 20회** 분류기 차단 후

이를 통해 분류기가 확신을 갖고 승인할 수 없는 경우에도 사용자는 항상 제어권을 유지할 수 있습니다.

### 자동 모드 상당의 권한 넣기

백그라운드 분류기 없이 더 단순한 접근을 취하고 싶다면, `~/.claude/settings.json`에 보수적인 기준선의 안전한 권한 규칙을 넣을 수 있습니다. 스크립트는 먼저 읽기 전용과 로컬 검사 규칙부터 시작하며, 편집, 테스트, 로컬 Git 쓰기, 패키지 설치, GitHub 쓰기 작업 등은 옵트인으로 활성화합니다.

**파일:** `09-advanced-features/setup-auto-mode-permissions.py`

```bash
# Preview what would be added (no changes written)
python3 09-advanced-features/setup-auto-mode-permissions.py --dry-run

# Apply the conservative baseline
python3 09-advanced-features/setup-auto-mode-permissions.py

# Add more capability only when you need it
python3 09-advanced-features/setup-auto-mode-permissions.py --include-edits --include-tests
python3 09-advanced-features/setup-auto-mode-permissions.py --include-git-write --include-packages
```

이 스크립트는 다음 카테고리에 걸친 규칙을 추가합니다:

| 카테고리 | 예 |
|----------|---------|
| 핵심 읽기 전용 도구 | `Read(*)`, `Grep(*)`, `Agent(*)`, `WebSearch(*)`, `WebFetch(*)` |
| 로컬 검사 | `Bash(git status:*)`, `Bash(git log:*)`, `Bash(git diff:*)`, `Bash(cat:*)` |
| 선택적 편집 | `Edit(*)` |
| 선택적 테스트/빌드 | `Bash(pytest:*)`, `Bash(python3 -m pytest:*)`, `Bash(cargo test:*)` |
| 선택적 Git 쓰기 | `Bash(git add:*)`, `Bash(git commit:*)`, `Bash(git checkout:*)`, `Bash(git switch:*)`, `Bash(git stash:*)`, `Bash(git tag:*)` |
| 패키지 관리자 | `Bash(npm ci:*)`, `Bash(npm install:*)`, `Bash(pip install:*)`, `Bash(pip3 install:*)` |
| 빌드와 테스트 | `Bash(make:*)`, `Bash(pytest:*)`, `Bash(go test:*)` |
| 자주 쓰는 셸 | `Bash(ls:*)`, `Bash(cat:*)`, `Bash(find:*)` |
| GitHub CLI | `Bash(gh pr view:*)`, `Bash(gh pr create:*)`, `Bash(gh issue list:*)` |

위험한 작업(`rm -rf`, `sudo`, 강제 푸시, `DROP TABLE`, `terraform destroy` 등)은 의도적으로 제외되어 있습니다. 스크립트는 멱등하므로 두 번 실행해도 규칙이 중복되지 않습니다.

---

## 백그라운드 작업

백그라운드 작업을 통해 장시간 처리를 대화를 막지 않고 실행할 수 있습니다.

### 백그라운드 작업이란

백그라운드 작업은 작업을 계속하는 동안 비동기로 실행됩니다:
- 장시간 테스트 스위트
- 빌드 프로세스
- 데이터베이스 마이그레이션
- 배포 스크립트
- 분석 도구

**기본 사용법:**
```bash
User: Run tests in background

Claude: Started task bg-1234

/tasks    # View and manage background work (shells and subagents); stop a task from here
Ctrl+B    # Move a running Bash command or agent to the background
```

### 백그라운드 작업 시작하기

```
User: Run the full test suite in the background

Claude: Starting tests in background (task-id: bg-1234)
You can continue working while tests run.

[You can continue the conversation]

User: Meanwhile, let's refactor the auth module

Claude: [Works on auth module while tests run in background]

[Later, when tests complete]

Claude: 📢 Background task bg-1234 completed:
✅ 245 tests passed
❌ 3 tests failed
View results: /tasks
```

### 백그라운드 작업 관리

`/tasks`(별칭 `/bashes`)를 실행하면 실행 중인 셸과 서브에이전트를 목록으로 표시하고, 하나를 열어 출력을 확인하거나 중지할 수 있습니다. `/task`의 하위 명령어는 존재하지 않습니다.

```text
User: /tasks

[Opens the background-work view: running shells and subagents,
 including subagents that have finished. Select one to see its
 output, or stop it from here.]
```

### 예: 병렬 개발

```
User: Run the build in the background

Claude: Starting build... (task-id: bg-5001)

User: Also run the linter in background

Claude: Starting linter... (task-id: bg-5002)

User: While those run, let's implement the new API endpoint

Claude: [Implements API endpoint while build and linter run]

[10 minutes later]

Claude: 📢 Build completed successfully (bg-5001)
📢 Linter found 12 issues (bg-5002)

User: Show me the linter issues

Claude: [Shows linter output from bg-5002]
```

### 설정

`settings.json`에 백그라운드 작업용 블록은 존재하지 않습니다. 이 기능은 환경 변수로 제어합니다:

```bash
# 백그라운드 작업을 완전히 비활성화
export CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=true
```

동시 실행 수도 백그라운드 작업의 설정이 아닙니다. 동시에 실행되는 에이전트 수는 `CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`(기본값 `20`)로 결정됩니다.

---

## Monitor 도구(이벤트 기반 스트림)

> **v2.1.98에서 새로 등장:** Monitor 도구는 Claude가 백그라운드 명령어의 stdout을 감시하고, 일치하는 이벤트가 나타나는 순간 반응할 수 있게 합니다. 장시간 프로세스를 기다리기 위해 폴링 루프나 `sleep`을 사용할 필요가 없어집니다.

Monitor는 stdout에 쓰는 임의의 셸 명령어에 연결됩니다. 명령어의 stdout 줄마다 알림이 발생하고 세션이 깨어납니다. Claude가 명령어를 지정하고, 하네스가 출력을 스트리밍해 이벤트 발생 시 전달합니다. 기반 프로세스의 시작에 대해서는 관련 [백그라운드 작업](#백그라운드-작업) 섹션을 참고하세요.

### 왜 중요한가

`/loop`나 `sleep`으로 폴링하면 아무것도 바뀌지 않았더라도 주기마다 API 왕복을 1회 소비합니다. Monitor는 이벤트가 발생할 때까지 침묵을 지키며, 명령어가 조용한 동안에는 **토큰 소비 없이** 대기합니다. 이벤트가 발생하는 순간 Claude가 반응합니다 — 다음 폴링 틱을 기다리는 지연이 없습니다. 몇 분 이상 동작하는 처리에는 폴링 루프보다 저렴하고 빠릅니다.

### 자주 쓰는 두 가지 패턴

**스트림 필터**는 장시간 동작하는 소스의 연속 출력을 감시합니다. 명령어는 영구적으로 동작하며, 일치하는 줄마다 이벤트가 됩니다.

```bash
tail -f /var/log/app.log | grep --line-buffered "ERROR"
```

**폴링 앤드 이밋 필터**는 소스를 주기적으로 확인해 변화가 있을 때만 출력합니다. 네이티브 스트림이 없는 API, 데이터베이스 등에 사용합니다.

```bash
last=$(date -u +%Y-%m-%dT%H:%M:%SZ)
while true; do
  gh api "repos/owner/repo/issues/123/comments?since=$last" || true
  last=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  sleep 30
done
```

### 구체적인 예

"dev 서버를 시작하고 오류를 감시해 줘"라고 요청하면, Claude는 서버를 백그라운드 작업으로 시작하고 Monitor 필터(`tail -F server.log | grep --line-buffered -E "ERROR|FATAL"`)를 연결합니다. 세션은 조용해집니다. 로그에 오류 줄이 나타나는 순간 Claude가 깨어나 오류를 읽고 반응할 수 있습니다 — 서버 재시작, 버그 수정, 사용자 알림 중 무엇이든, 사용자가 상황을 확인하러 오지 않아도 가능합니다.

> **경고:** `grep`으로 파이프할 때는 **반드시** `grep --line-buffered`를 사용하세요. 이것이 없으면 grep은 stdout을 4KB 청크로 버퍼링하므로, 트래픽이 적은 스트림에서는 몇 분의 지연이 생길 수 있습니다. 이는 Monitor가 실제 운영에서 깨지는 가장 큰 원인입니다. 필터가 당연히 반응해야 하는데 침묵하고 있다면 먼저 `--line-buffered` 플래그를 확인하세요.

---

## 예약 작업

예약 작업을 사용하면 정기 일정으로 프롬프트를 자동 실행하거나 1회성 리마인더로 실행할 수 있습니다. 작업은 세션 범위입니다 — Claude Code가 동작하는 동안에만 실행되며 세션 종료 시 지워집니다. v2.1.72 이후에서 사용할 수 있습니다.

### `/loop` 명령어

```bash
# Explicit interval
/loop 5m check if the deployment finished

# Natural language
/loop check build status every 30 minutes
```

정확한 스케줄링을 위해 표준 5필드 cron 식도 지원됩니다.

### 1회성 리마인더

특정 시각에 한 번만 실행되는 리마인더를 설정할 수 있습니다:

```
remind me at 3pm to push the release branch
in 45 minutes, run the integration tests
```

### 예약 작업 관리

| 도구 | 설명 |
|------|-------------|
| `CronCreate` | 새 예약 작업을 만듭니다 |
| `CronList` | 활성 예약 작업을 목록으로 표시합니다 |
| `CronDelete` | 예약 작업을 삭제합니다 |

**제한과 동작:**
- 세션당 최대 **50개의 예약 작업**
- 세션 범위 — 세션 종료 시 지워집니다
- 정기 작업은 **3일 후** 자동 만료됩니다
- 작업은 Claude Code가 동작 중일 때만 실행됩니다 — 놓친 실행을 보충하지 않습니다

### 동작 상세

| 항목 | 상세 |
|--------|--------|
| **정기 실행 지터** | 간격의 최대 10%(최대 15분) |
| **1회성 지터** | :00/:30 경계에서 최대 90초 |
| **놓친 실행** | 캐치업 없음 — Claude Code가 동작하지 않으면 건너뜁니다 |
| **영속화** | 재시작 후에는 유지되지 않습니다 |

### 클라우드 예약 작업

`/schedule`을 사용하면 Anthropic 인프라에서 동작하는 클라우드 예약 작업을 만들 수 있습니다:

```
/schedule daily at 9am run the test suite and report failures
```

클라우드 예약 작업은 재시작 후에도 유지되며, Claude Code를 로컬에서 실행할 필요가 없습니다.

### 예약 작업 비활성화

```bash
export CLAUDE_CODE_DISABLE_CRON=1
```

### 예: 배포 감시

```
/loop 5m check the deployment status of the staging environment.
        If the deploy succeeded, notify me and stop looping.
        If it failed, show the error logs.
```

> **팁:** 예약 작업은 세션 범위입니다. 재시작 후에도 살아남는 영속적인 자동화에는 CI/CD 파이프라인, GitHub Actions, 데스크톱 앱의 예약 작업을 사용하세요.

---

## 권한 모드

권한 모드는 명시적인 승인 없이 Claude가 실행할 수 있는 작업을 제어합니다.

### 사용 가능한 권한 모드

| 모드 | 동작 |
|---|---|
| `default` | 파일 읽기만 가능. 그 외 작업은 확인을 요청합니다 |
| `acceptEdits` | 파일 읽기와 편집을 허용. 명령어는 확인을 요청합니다 |
| `plan` | 파일 읽기만 가능(리서치 모드, 편집 없음) |
| `auto` | 백그라운드 안전 분류기 검사와 함께 모든 작업을 허용 |
| `bypassPermissions` | 모든 작업, 권한 검사 없음(위험) |
| `dontAsk` | 사전 승인된 도구만 실행, 그 외는 모두 거부 |

CLI에서는 `Shift+Tab`으로 모드를 전환합니다. 기본값은 `--permission-mode` 플래그 또는 `permissions.defaultMode` 설정으로 지정합니다. 권한 모드가 설정되지 않은 경우, v2.1.284 이후에는 대화형 터미널 세션과 VS Code 세션이 모든 플랜과 프로바이더에서 auto 모드로 시작합니다(v2.1.283에서는 Bedrock, Google Cloud의 Agent Platform, Foundry 등 서드파티 프로바이더 위에서 또는 텔레메트리를 끈 경우로 한정되었습니다). `permissions.defaultMode`는 계속 이보다 우선하며, auto 모드를 사용할 수 없는 세션은 대신 `default`(Manual)로 시작합니다. v2.1.302 이후 권한 모드를 설정하지 않은 `claude -p`와 Agent SDK 세션은 서드파티 프로바이더 위에서, 텔레메트리를 끈 경우, 또는 새로 설치한 직후에는 `default` 모드로 시작합니다. auto 모드를 유지하려면 `--permission-mode auto`를 전달하세요.

### 시작 방법

**키보드 단축키:**
```bash
Shift + Tab  # Cycle default → acceptEdits → plan, then bypassPermissions/auto when available (dontAsk never appears in the cycle)
```

**슬래시 명령어:**
```bash
/plan                  # Enter plan mode
```

**CLI 플래그:**
```bash
claude --permission-mode plan
claude --permission-mode auto
```

**설정:**
```json
{
  "permissions": {
    "defaultMode": "auto"
  }
}
```

### 권한 모드의 예

#### Default 모드
Claude는 중요한 작업 전에 확인을 요청합니다:

```
User: Fix the bug in auth.ts

Claude: I need to modify src/auth.ts to fix the bug.
The change will update the password validation logic.

Approve this change? (yes/no/show)
```

#### Plan 모드
실행 전에 구현 계획을 검토합니다:

```
User: /plan Implement user authentication system

Claude: I'll create a plan for implementing authentication.

## Implementation Plan
[Detailed plan with phases and steps]

Ready to proceed? (yes/no/modify)
```

#### Accept Edits 모드
파일 변경을 자동 승인합니다:

```
User: acceptEdits
User: Fix the bug in auth.ts

Claude: [Makes changes without asking]
```

### 사용 사례

**코드 리뷰:**
```
User: claude --permission-mode plan
User: Review this PR and suggest improvements

Claude: [Reads code, provides feedback, but cannot modify]
```

**페어 프로그래밍:**
```
User: claude --permission-mode default
User: Let's implement the feature together

Claude: [Asks for approval before each change]
```

**자동화 작업:**
```
User: claude --permission-mode acceptEdits
User: Fix all linting issues in the codebase

Claude: [Auto-accepts file edits without asking]
```

---

## 헤드리스 모드

프린트 모드(`claude -p`)를 통해 Claude Code를 대화 입력 없이 실행할 수 있습니다. 자동화나 CI/CD에 최적입니다. 이것은 비대화 모드이며, 기존의 `--headless` 플래그를 대체합니다.

### 프린트 모드란

프린트 모드에서는 다음이 가능해집니다:
- 스크립트 자동 실행
- CI/CD 통합
- 배치 처리
- 예약 작업

### 프린트 모드로 실행(비대화)

```bash
# Run specific task
claude -p "Run all tests"

# Process piped content
cat error.log | claude -p "Analyze these errors"

# CI/CD integration (GitHub Actions)
- name: AI Code Review
  run: claude -p "Review PR"
```

### 프린트 모드의 기타 사용 예

```bash
# Run a specific task with output capture
claude -p "Run all tests and generate coverage report"

# With structured output
claude -p --output-format json "Analyze code quality"

# With input from stdin
echo "Analyze code quality" | claude -p "explain this"
```

### 예: CI/CD 통합

**GitHub Actions:**
```yaml
# .github/workflows/code-review.yml
name: AI Code Review

on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install Claude Code
        run: npm install -g @anthropic-ai/claude-code

      - name: Run Claude Code Review
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          claude -p --output-format json \
            --max-turns 3 \
            "Review this PR for:
            - Code quality issues
            - Security vulnerabilities
            - Performance concerns
            - Test coverage
            Output results as JSON" > review.json

      - name: Post Review Comment
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const review = JSON.parse(fs.readFileSync('review.json', 'utf8'));
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: JSON.stringify(review, null, 2)
            });
```

### 프린트 모드 설정

프린트 모드(`claude -p`)는 자동화를 위해 몇 가지 플래그를 지원합니다:

```bash
# Limit autonomous turns
claude -p --max-turns 5 "refactor this module"

# Structured JSON output
claude -p --output-format json "analyze this codebase"

# With schema validation
claude -p --json-schema '{"type":"object","properties":{"issues":{"type":"array"}}}' \
  "find bugs in this code"

# Disable session persistence
claude -p --no-session-persistence "one-off analysis"
```

---

## 세션 관리

여러 Claude Code 세션을 효과적으로 관리합니다.

### 세션 관리 명령어

| 명령어 | 설명 |
|---------|-------------|
| `/resume` | ID 또는 이름으로 대화를 재개합니다 |
| `/rename` | 현재 세션에 이름을 붙입니다 |
| `/fork` | 현재 세션을 새 브랜치로 포크합니다 |
| `claude -c` | 가장 최근 대화를 이어갑니다 |
| `claude -r "session"` | 이름 또는 ID로 세션을 재개합니다 |

### 세션 재개

**가장 최근 대화 이어가기:**
```bash
claude -c
```

**이름 있는 세션 재개:**
```bash
claude -r "auth-refactor" "finish this PR"
```

**현재 세션에 이름 붙이기**(REPL 안에서):
```
/rename auth-refactor
```

### 세션 포크

다른 접근을 시도하고 싶지만 원래 세션을 잃고 싶지 않을 때 세션을 포크합니다:

```
/fork
```

CLI에서도 실행할 수 있습니다:
```bash
claude --resume auth-refactor --fork-session "try OAuth instead"
```

### 세션 영속화

세션은 자동 저장되며 언제든 재개할 수 있습니다:

```bash
# Continue last conversation
claude -c

# Resume specific session by name or ID
claude -r "auth-refactor"

# Resume and fork for experimentation
claude --resume auth-refactor --fork-session "alternative approach"
```

### 세션 리캡(v2.1.108)

잠시 자리를 비운 뒤 세션으로 돌아오면, Claude는 무엇이 달성되었는지 간결하게 되짚어 줄 수 있습니다. 모든 플랜과 프로바이더에서 기본 활성화되어 있으며, `/config`의 **Session recap**에서 끌 수 있습니다.

**리캡 동작 제어:**

```bash
/recap                                 # manually trigger a recap
/config                                # toggle auto-recap on/off
```

또는 환경 변수로:
```bash
CLAUDE_CODE_ENABLE_AWAY_SUMMARY=0 claude   # disable recap
CLAUDE_CODE_ENABLE_AWAY_SUMMARY=1 claude   # force enable recap
```

---

## 대화 기능

### 키보드 단축키

Claude Code는 효율 향상을 위해 키보드 단축키를 지원합니다. 공식 문서의 전체 레퍼런스:

| 단축키 | 설명 |
|----------|-------------|
| `Ctrl+C` | 입력/생성 취소 |
| `Ctrl+D` | Claude Code 종료 |
| `Ctrl+G` | 계획을 외부 편집기에서 편집 |
| `Ctrl+L` | 화면 다시 그리기(repaint만 — 두 번 눌러서 `/clear`하는 기능은 v2.1.238에서 폐지) |
| `Ctrl+O` | 상세 출력 전환(추론 표시) |
| `Ctrl+R` | 히스토리 역방향 검색 |
| `Ctrl+T` | 태스크 리스트 뷰 전환 |
| `Ctrl+B` | 실행 중인 작업을 백그라운드로 전환 |
| `Esc+Esc` | 코드/대화 되감기 |
| `Shift+Tab` / `Alt+M` | 권한 모드 전환 |
| `Option+P` / `Alt+P` | 모델 전환 |
| `Option+T` / `Alt+T` | 확장 사고 전환 |

**행 편집(표준 readline 단축키):**

| 단축키 | 동작 |
|----------|--------|
| `Ctrl + A` | 행 처음으로 이동 |
| `Ctrl + E` | 행 끝으로 이동 |
| `Ctrl + K` | 행 끝까지 잘라내기 |
| `Ctrl + U` | 행 처음까지 잘라내기 |
| `Ctrl + W` | 앞 단어 삭제 |
| `Ctrl + Y` | 붙여넣기(yank) |
| `Tab` | 자동 완성 |
| `↑ / ↓` | 명령어 히스토리 |

### 키 바인딩 커스터마이즈

`/keybindings`를 실행하면 커스텀 키보드 단축키를 만들 수 있습니다. 이 명령어는 `~/.claude/keybindings.json`을 편집용으로 엽니다(v2.1.18 이후).

**설정 형식:**

```json
{
  "$schema": "https://www.schemastore.org/claude-code-keybindings.json",
  "bindings": [
    {
      "context": "Chat",
      "bindings": {
        "ctrl+e": "chat:externalEditor",
        "ctrl+u": null,
        "ctrl+k ctrl+s": "chat:stash"
      }
    },
    {
      "context": "Confirmation",
      "bindings": {
        "ctrl+a": "confirmation:yes"
      }
    }
  ]
}
```

바인딩을 `null`로 설정하면 기본 단축키를 해제할 수 있습니다.

### 사용 가능한 컨텍스트

키 바인딩은 특정 UI 컨텍스트에 범위가 한정됩니다:

| 컨텍스트 | 주요 동작 |
|---------|-------------|
| **Chat** | `submit`, `cancel`, `cycleMode`, `modelPicker`, `thinkingToggle`, `undo`, `externalEditor`, `stash`, `imagePaste` |
| **Confirmation** | `yes`, `no`, `previous`, `next`, `nextField`, `cycleMode`, `toggleExplanation` |
| **Global** | `interrupt`, `exit`, `toggleTodos`, `toggleTranscript` |
| **Autocomplete** | `accept`, `dismiss`, `next`, `previous` |
| **HistorySearch** | `search`, `previous`, `next` |
| **Settings** | 컨텍스트별 설정 탐색 |
| **Tabs** | 탭 전환과 관리 |
| **Help** | 도움말 패널 탐색 |

`Transcript`, `Task`, `ThemePicker`, `Attachments`, `Footer`, `MessageSelector`, `DiffDialog`, `ModelPicker`, `Select`를 포함해 총 18개의 컨텍스트가 있습니다.

### 코드 지원

키 바인딩은 코드(여러 키의 조합)를 지원합니다:

```
"ctrl+k ctrl+s"   → Two-key sequence: press ctrl+k, then ctrl+s
"ctrl+shift+p"    → Simultaneous modifier keys
```

**키 표기법:**
- **수정 키:** `ctrl`(또는 `control`), `alt`(또는 `opt`, `option`, `meta`), `shift`, `cmd`(또는 `command`, `super`, `win`). `cmd`는 `meta`의 별칭이 아니라 독립적인 수정 키이며, Super 키를 보고하는 터미널에서만 감지됩니다
- **대문자는 Shift를 함의:** `K`는 `shift+k`와 동일합니다
- **특수 키:** `escape`, `enter`, `return`, `tab`, `space`, `backspace`, `delete`, 화살표 키

### 예약 키와 충돌 키

| 키 | 상태 | 비고 |
|-----|--------|-------|
| `Ctrl+C` | 예약 | 재바인딩 불가(인터럽트) |
| `Ctrl+D` | 예약 | 재바인딩 불가(종료) |
| `Ctrl+B` | 터미널 충돌 | tmux의 프리픽스 키 |
| `Ctrl+A` | 터미널 충돌 | GNU Screen의 프리픽스 키 |
| `Ctrl+Z` | 터미널 충돌 | 프로세스 일시 중단 |

> **팁:** 단축키가 동작하지 않으면 터미널 에뮬레이터나 멀티플렉서와의 충돌을 확인하세요.

### 탭 완성

Claude Code는 지능형 탭 완성을 제공합니다:

```
User: /rew<TAB>
→ /rewind

User: /plu<TAB>
→ /plugin

User: /plugin <TAB>
→ /plugin install
→ /plugin enable
→ /plugin disable
```

### 명령어 히스토리

과거 명령어에 접근합니다:

```
User: <↑>  # Previous command
User: <↓>  # Next command
User: Ctrl+R  # Search history

(reverse-i-search)`test': run all tests
```

### 여러 줄 입력

복잡한 쿼리에서는 `\` + Enter, Option+Enter(macOS), Shift+Enter 또는 Ctrl+J로 줄을 바꿉니다. `\end` 같은 종료 기호는 없으며 Enter로 전송합니다:

```bash
User: Long complex prompt \
spanning multiple lines
```

**예:**

```
User: Implement a user authentication system \
with the following requirements: \
- JWT tokens \
- Email verification \
- Password reset \
- 2FA support

Claude: [Processes the multi-line request]
```

### 인라인 편집

전송 전에 명령어를 편집할 수 있습니다:

```
User: Deploy to prodcution<Backspace><Backspace>uction

[Edit in-place before sending]
```

### Vim 모드

텍스트 편집에 Vi/Vim 키 바인딩을 활성화합니다:

**시작:**
- `/config`에서 활성화("Editor / Vim mode"를 전환)하거나 `~/.claude/settings.json`에 `editorMode: "vim"`을 설정합니다. 독립적인 `/vim` 슬래시 명령어는 제거되었습니다([issue #43370](https://github.com/anthropics/claude-code/issues/43370) 참고). Vim 모드는 설정 기반이 되었습니다.
- 모드 전환: NORMAL은 `Esc`, INSERT는 `i/a/o`, VISUAL은 `v`, VISUAL-LINE은 `V`(v2.1.118 이후)

**탐색 키:**
- `h` / `l` — 왼쪽/오른쪽으로 이동
- `j` / `k` — 아래/위로 이동
- `w` / `b` / `e` — 단어 단위로 이동
- `0` / `$` — 행 처음/끝으로 이동
- `gg` / `G` — 텍스트의 처음/끝으로 점프

**텍스트 객체:**
- `iw` / `aw` — inner / around 단어
- `i"` / `a"` — inner / around 따옴표 문자열
- `i(` / `a(` — inner / around 괄호

**비주얼 모드(v2.1.118 이후):**

| 키 | 모드 | 동작 |
|-----|------|----------|
| `v` | Visual | 문자 단위 선택. 시각적 피드백 포함. 이동 키로 확장합니다 |
| `V` | Visual-line | 행 단위 선택. 항상 행 전체를 선택합니다 |
| `y` | Yank | 현재 비주얼 선택을 복사 |
| `d` / `x` | Delete | 현재 비주얼 선택을 삭제 |
| `c` | Change | 선택을 삭제하고 INSERT 모드로 |
| `Esc` | Exit | NORMAL 모드로 돌아가기 |

비주얼 선택은 입력 필드 안에서 강조 표시되어, 조작을 확정하기 전에 yank/삭제/변경 대상을 정확히 확인할 수 있습니다.

### Bash 모드

`!` 접두사로 셸 명령어를 직접 실행합니다:

```bash
! npm test
! git status
! cat src/index.js
```

컨텍스트를 전환하지 않고 빠르게 명령어를 실행하고 싶을 때 사용합니다.

---

## TUI 모드(전체 화면)

> **v2.1.110에서 새로 등장**

TUI(Text User Interface) 모드는 Claude Code를 깜빡임 없는 출력으로 전체 화면 표시합니다. tmux나 iTerm2의 분할 창 같은 터미널 멀티플렉서에 최적입니다.

### TUI 모드 활성화

`/tui` 명령어로 렌더러를 전환하거나, 시작 전에 `CLAUDE_CODE_NO_FLICKER=1`을 설정합니다:

```bash
/tui fullscreen               # switch to fullscreen from within a session
/tui default                  # switch back to the classic renderer
CLAUDE_CODE_NO_FLICKER=1 claude  # start directly in fullscreen
```

### 설정

| 설정 | 설명 | 기본값 |
|---------|-------------|---------|
| `autoScrollEnabled` | 최신 메시지로 자동 스크롤 | `true` |

`/config` 또는 `settings.json`에서 자동 스크롤을 비활성화합니다:

```json
{
  "autoScrollEnabled": false
}
```

### 포커스 뷰

`/focus` 명령어는 포커스 뷰를 전환합니다 — 가장 관련성 높은 출력만 표시하는 집중 모드입니다. `Ctrl+O`는 이제 일반 표시와 상세 트랜스크립트 표시 전환만 수행합니다(포커스 뷰는 `/focus`).

---

## 음성 입력

음성 입력은 Claude Code에서 푸시 투 토크 방식의 음성 입력을 제공하여, 타이핑 대신 프롬프트를 말로 입력할 수 있게 합니다.

### 음성 입력 시작

```
/voice
```

### 기능

| 기능 | 설명 |
|---------|-------------|
| **푸시 투 토크** | 키를 누르고 있는 동안 녹음하고, 떼면 전송합니다 |
| **20개 언어 지원** | 음성 텍스트 변환이 20개 언어를 지원합니다 |
| **커스텀 키 바인딩** | `/keybindings`로 푸시 투 토크 키를 설정 |
| **계정 요건** | STT 처리에 Claude.ai 계정이 필요합니다 |

### 설정

키 바인딩 설정 파일(`/keybindings`)에서 푸시 투 토크 키 바인딩을 커스터마이즈합니다. 음성 입력은 Claude.ai 계정을 사용해 음성 텍스트 변환을 수행합니다.

---

## 채널

채널은 Research Preview 기능으로, MCP 서버를 통해 외부 서비스의 이벤트를 실행 중인 Claude Code 세션에 푸시합니다. Telegram, Discord, iMessage, 임의의 Webhook을 소스로 사용할 수 있으며, 폴링 없이 Claude가 실시간 알림에 반응할 수 있습니다.

### 채널 구독

```bash
# Subscribe to a channel plugin at startup
claude --channels plugin:telegram@claude-plugins-official

# Subscribe to multiple sources (space-separated)
claude --channels plugin:discord@claude-plugins-official plugin:telegram@claude-plugins-official
```

### 지원되는 연동

| 연동 | 설명 |
|-------------|-------------|
| **Discord** | 세션 안에서 Discord 메시지를 수신하고 응답합니다 |
| **Telegram** | 세션 안에서 Telegram 메시지를 수신하고 응답합니다 |
| **iMessage** | 세션 안에서 iMessage 알림을 수신합니다 |
| **Webhooks** | 임의의 Webhook 소스에서 이벤트를 수신합니다 |

### 설정

시작 시 `--channels` 플래그로 채널을 설정합니다. 엔터프라이즈 배포에서는 허용할 채널 플러그인을 제어하는 관리형 설정을 사용합니다:

```json
{
  "channelsEnabled": true,
  "allowedChannelPlugins": [
    { "marketplace": "claude-plugins-official", "plugin": "discord" },
    { "marketplace": "claude-plugins-official", "plugin": "telegram" }
  ]
}
```

`allowedChannelPlugins` 관리형 설정은 조직 전체에서 허용되는 채널 플러그인을 제어합니다. Anthropic이 관리하는 허용 목록을 대체하며, `channelsEnabled: true`가 필요합니다.

### 동작 원리

1. MCP 서버가 외부 서비스에 연결하는 채널 플러그인으로 동작합니다
2. 수신된 메시지와 이벤트가 활성 Claude Code 세션으로 푸시됩니다
3. Claude는 세션의 컨텍스트 안에서 메시지를 읽고 응답할 수 있습니다
4. 채널 플러그인은 Anthropic이 관리하는 허용 목록, 또는 관리자가 설정한 경우 조직의 `allowedChannelPlugins` 목록에 포함되어 있어야 합니다
5. 폴링 불필요 — 이벤트는 실시간으로 푸시됩니다

---

## Chrome 연동

Chrome 연동은 Claude Code를 Chrome 또는 Microsoft Edge 브라우저에 연결해 실시간 Web 자동화와 디버깅을 수행하는 기능입니다. v2.0.73 이후에서 사용할 수 있는 베타 기능입니다(Claude in Chrome 확장 프로그램 v1.0.36 이상 필요).

### Chrome 연동 활성화

**시작 시:**

```bash
claude --chrome      # Enable Chrome connection
claude --no-chrome   # Disable Chrome connection
```

**세션 안에서:**

```
/chrome
```

"Enabled by default"를 선택하면 이후 모든 세션에서 Chrome 연동이 활성화됩니다. Claude Code는 브라우저의 로그인 상태를 공유하므로 인증된 Web 앱과 상호작용할 수 있습니다.

### 기능

| 기능 | 설명 |
|------------|-------------|
| **실시간 디버깅** | 콘솔 로그 읽기, DOM 요소 검사, JavaScript 실시간 디버깅 |
| **디자인 검증** | 렌더링된 페이지와 디자인 목업을 비교 |
| **폼 검증** | 폼 제출, 입력 검증, 오류 처리를 테스트 |
| **Web 앱 테스트** | 인증된 앱(Gmail, Google Docs, Notion 등)과 상호작용 |
| **데이터 추출** | Web 페이지 콘텐츠를 스크레이핑해 처리 |
| **세션 녹화** | 브라우저 조작을 GIF 파일로 녹화 |

### 사이트 단위 권한

Chrome 확장 프로그램은 사이트별 접근을 관리합니다. 확장 프로그램 팝업에서 특정 사이트에 대한 접근을 언제든 허용하거나 취소할 수 있습니다. Claude Code는 명시적으로 허용된 사이트와만 상호작용합니다.

### 동작 원리

Claude Code는 표시된 창 안에서 브라우저를 조작합니다 — 조작 과정을 실시간으로 관찰할 수 있습니다. 브라우저가 로그인 페이지나 CAPTCHA를 만나면 Claude는 일시 중지하고 수동 대응을 기다립니다.

### 알려진 제한

- **브라우저 지원:** Chrome과 Edge. Claude Code는 Brave, Arc, Vivaldi, Opera 등 다른 Chromium 기반 브라우저에도 연결할 수 있습니다
- **WSL:** Windows Subsystem for Linux에서는 사용할 수 없습니다
- **서드파티 프로바이더:** Bedrock, Vertex, Foundry API 프로바이더에서는 지원되지 않습니다
- **서비스 워커 유휴:** 장시간 세션 중에 Chrome 확장 프로그램의 서비스 워커가 유휴 상태가 될 수 있습니다

> **팁:** Chrome 연동은 베타 기능입니다. 향후 릴리스에서 브라우저 지원이 확대될 수 있습니다.

---

## 리모트 컨트롤

리모트 컨트롤을 통해 로컬에서 동작 중인 Claude Code 세션을 스마트폰, 태블릿, 임의의 브라우저에서 이어갈 수 있습니다. 로컬 세션은 머신에서 계속 동작합니다 — 클라우드로 이동하는 것은 아무것도 없습니다. Pro, Max, Team, Enterprise 플랜에서 사용할 수 있습니다(v2.1.51 이후).

### 리모트 컨트롤 시작

**CLI에서:**

```bash
# Start with default session name
claude remote-control

# Start with a custom name
claude remote-control --name "Auth Refactor"
```

**세션 안에서:**

```
/remote-control
/remote-control "Auth Refactor"
```

**사용 가능한 플래그:**

| 플래그 | 설명 |
|------|-------------|
| `--name "title"` | 식별하기 쉬운 세션 제목 |
| `--verbose` | 상세 연결 로그 표시 |

> **주의(v2.1.300):** `claude remote-control`은 `--sandbox`와 `--no-sandbox`를 더 이상 받지 않습니다(원래 효과가 없었으며, 둘 중 하나를 전달하면 오류로 종료됩니다). Remote Control 세션을 샌드박스화하려면 설정 파일에서 `sandbox.enabled`를 설정하세요.

### 세션에 연결

다른 기기에서 연결하는 3가지 방법:

1. **세션 URL** — 세션 시작 시 터미널에 출력됩니다. 임의의 브라우저에서 열 수 있습니다
2. **QR 코드** — 시작 후 `spacebar`를 누르면 스캔 가능한 QR 코드가 표시됩니다
3. **이름으로 검색** — claude.ai/code 또는 Claude 모바일 앱(iOS/Android)에서 세션을 찾아봅니다

### 보안

- 머신에 **인바운드 포트를 열지 않습니다**
- **아웃바운드 HTTPS만**(TLS 경유)
- **범위 지정 인증 정보** — 짧은 수명에 좁은 범위로 한정된 여러 토큰
- **세션 격리** — 각 리모트 세션은 독립적입니다

### 리모트 컨트롤 vs Claude Code on the web

| 관점 | 리모트 컨트롤 | Claude Code on Web |
|--------|---------------|-------------------|
| **실행 위치** | 머신에서 동작 | Anthropic 클라우드에서 동작 |
| **로컬 도구** | 로컬 MCP 서버, 파일, CLI에 전체 접근 | 로컬 의존성 없음 |
| **사용 사례** | 다른 기기에서 로컬 작업을 이어가기 | 임의의 브라우저에서 새로 시작 |

### 제한

- 대화형 Claude Code 프로세스당 리모트 세션은 1개 — 서버 모드(`claude remote-control`)는 여러 개를 동시에 다룰 수 있습니다(`--capacity`, 기본값 32)
- 호스트 머신의 터미널을 열어 둔 채로 유지해야 합니다
- 네트워크에 도달할 수 없을 때 서버 모드는 약 10분 후 종료됩니다. 대화형 세션은 재시도를 계속하며 네트워크가 복구되면 다시 연결합니다

### 사용 사례

- 책상에서 떨어진 곳에서 모바일 기기나 태블릿으로 Claude Code를 조작합니다
- 로컬 도구 실행을 유지하면서 더 풍부한 claude.ai UI를 사용합니다
- 완전한 로컬 개발 환경과 함께 이동 중에 빠르게 코드 리뷰

### 푸시 알림(v2.1.110)

리모트 컨트롤이 활성화되어 있고 `/config`에서 "Push when Claude decides"가 켜져 있으면, Claude는 모바일 푸시 알림을 보낼 수 있습니다 — 예를 들어 장시간 작업 완료 시나 입력이 필요할 때 등입니다.

활성화 방법:
1. 리모트 컨트롤을 시작: `/remote-control` 또는 `claude --rc`
2. `/config`를 열어 **Push when Claude decides**를 활성화

푸시 알림에는 Claude 구독과 Claude 모바일 앱이 필요합니다.

---

## Web 세션

Web 세션에서는 claude.ai/code의 브라우저에서 직접 Claude Code를 실행하거나, CLI에서 Web 세션을 만들 수 있습니다.

### Web 세션 만들기

```bash
# Create a new web session from the CLI
claude --remote "implement the new API endpoints"
```

이렇게 하면 claude.ai에서 Claude Code 세션이 시작되며, 임의의 브라우저에서 접근할 수 있습니다.

### Web 세션을 로컬에서 재개

Web에서 시작한 세션을 로컬에서 이어가고 싶은 경우:

```bash
# Resume a web session in the local terminal
claude --teleport
```

또는 대화형 REPL 안에서:
```
/teleport
```

### 사용 사례

- 한 머신에서 작업을 시작하고 다른 머신에서 이어갑니다
- 세션 URL을 팀 구성원과 공유합니다
- 시각적 diff 리뷰에는 Web UI를 사용하고, 실행은 터미널로 전환합니다

---

## 데스크톱 앱

Claude Code 데스크톱 앱은 시각적 diff 리뷰, 병렬 세션, 통합 커넥터를 갖춘 독립 실행형 애플리케이션입니다. macOS와 Windows에서 사용할 수 있습니다(Pro, Max, Team, Enterprise 플랜).

### 설치

[claude.ai](https://claude.ai)에서 플랫폼에 맞게 다운로드합니다:
- **macOS:** 유니버설 빌드(Apple Silicon과 Intel)
- **Windows:** x64와 ARM64 설치 프로그램 제공

설정 절차는 [Desktop Quickstart](https://code.claude.com/docs/en/desktop-quickstart)를 참고하세요.

### CLI에서 넘기기

현재 CLI 세션을 데스크톱 앱으로 전송합니다:

```
/desktop
```

### 핵심 기능

| 기능 | 설명 |
|---------|-------------|
| **Diff 뷰** | 파일별 시각적 리뷰와 인라인 코멘트. Claude는 코멘트를 읽고 수정합니다 |
| **앱 미리보기** | dev 서버를 자동 시작하고 내장 브라우저에서 실시간 검증 |
| **PR 감시** | GitHub CLI 연동. CI 실패 자동 수정, 체크 완료 시 자동 머지 |
| **병렬 세션** | 사이드바에서 여러 세션을 관리. Git 워크트리로 자동 격리 |
| **예약 작업** | 정기 작업(매시, 매일, 평일, 매주). 앱이 열려 있는 동안 실행 |
| **리치 렌더링** | 코드, Markdown, 다이어그램 렌더링과 구문 강조 |

### 앱 미리보기 설정

`.claude/launch.json`에서 dev 서버의 동작을 설정합니다:

```json
{
  "version": "0.0.1",
  "configurations": [
    {
      "name": "my-app",
      "runtimeExecutable": "npm",
      "runtimeArgs": ["run", "dev"],
      "port": 3000
    }
  ]
}
```

### 커넥터

외부 서비스를 연결해 더 풍부한 컨텍스트를 얻습니다:

| 커넥터 | 기능 |
|-----------|------------|
| **GitHub** | PR 감시, 이슈 트래킹, 코드 리뷰 |
| **Slack** | 알림, 채널 컨텍스트 |
| **Linear** | 이슈 트래킹, 스프린트 관리 |
| **Notion** | 문서, 지식 베이스 접근 |
| **Asana** | 작업 관리, 프로젝트 추적 |
| **Calendar** | 일정 인식, 미팅 컨텍스트 |

> **참고:** 커넥터는 리모트(클라우드) 세션에서는 사용할 수 없습니다.

### 리모트와 SSH 세션

- **리모트 세션:** Anthropic의 클라우드 인프라에서 동작합니다. 앱을 닫아도 계속됩니다. claude.ai/code 또는 Claude 모바일 앱에서 접근할 수 있습니다
- **SSH 세션:** SSH로 원격 머신에 연결해 원격 파일 시스템과 도구에 전체 접근 권한을 얻습니다. Claude Code를 원격 머신에 설치해야 합니다

### 데스크톱에서의 권한 모드

데스크톱 앱은 CLI와 같은 권한 모드를 지원합니다:

| 모드 | 동작 |
|------|----------|
| **Manual**(기본값) | 모든 편집과 명령어를 검토하고 승인 |
| **Accept edits** | 파일 편집은 자동 승인, 명령어는 수동 승인 |
| **Plan** | 변경 전에 접근 방식을 검토 |
| **Auto** | 일반적인 확인 없이 실행. 백그라운드 분류기가 사전에 작업을 검사합니다 |
| **Bypass permissions** | 자동 실행(샌드박스 한정, 관리자 제어) |

### 엔터프라이즈 기능

- **관리 콘솔:** 조직의 코드 탭 접근과 권한 설정을 제어
- **MDM 배포:** macOS는 MDM, Windows는 MSIX로 배포
- **SSO 통합:** 조직 구성원에게 싱글 사인온을 필수화
- **관리형 설정:** 팀 설정과 모델 가용성을 일원 관리

---

## 태스크 리스트

태스크 리스트 기능은 컨텍스트 컴팩션(컨텍스트 윈도우에 맞추기 위해 대화 기록이 잘려 나가는 것)을 견뎌 내는 영속적인 작업 추적을 제공합니다.

### 태스크 리스트 전환

세션 중에 `Ctrl+T`를 누르면 태스크 리스트 뷰를 전환할 수 있습니다.

### 영속적인 작업

작업은 컨텍스트 컴팩션을 넘어 영속화되므로, 장시간 작업 항목이 대화 컨텍스트가 잘릴 때 사라지지 않습니다. 복잡한 다단계 구현에 특히 유용합니다.

### 이름 있는 작업 디렉터리

`CLAUDE_CODE_TASK_LIST_ID` 환경 변수를 사용하면 여러 세션에서 공유되는 이름 있는 작업 디렉터리를 만들 수 있습니다:

```bash
export CLAUDE_CODE_TASK_LIST_ID=my-project-sprint-3
```

이를 통해 여러 세션이 같은 태스크 리스트를 공유할 수 있으며, 팀 워크플로나 다중 세션 프로젝트에 유용합니다.

---

## 프롬프트 추천

프롬프트 추천은 Git 기록과 현재 대화 컨텍스트에 기반해 회색으로 흐리게 표시된 예시 명령어를 보여 줍니다.

### 동작 원리

- 추천은 입력 프롬프트 아래에 회색 텍스트로 표시됩니다
- `Tab`을 누르면 추천을 수락합니다
- `Enter`를 누르면 수락하고 즉시 전송합니다
- 추천은 컨텍스트를 인식하며, Git 기록과 대화 상태에서 도출됩니다

### 프롬프트 추천 비활성화

```bash
export CLAUDE_CODE_ENABLE_PROMPT_SUGGESTION=false
```

---

## Git 워크트리

Git 워크트리를 통해 격리된 워크트리에서 Claude Code를 시작할 수 있습니다. 스태시나 브랜치 전환 없이 서로 다른 브랜치에서 병렬 작업이 가능해집니다.

### 워크트리에서 시작

```bash
# Start Claude Code in an isolated worktree
claude --worktree
# or
claude -w
```

### 워크트리 저장 위치

워크트리는 다음 위치에 만들어집니다:
```
<repo>/.claude/worktrees/<name>
```

### 모노레포용 스파스 체크아웃

`worktree.sparsePaths` 설정으로 모노레포에 스파스 체크아웃을 수행해 디스크 사용량과 클론 시간을 줄일 수 있습니다:

```json
{
  "worktree": {
    "sparsePaths": ["packages/my-package", "shared/"]
  }
}
```

### 워크트리 도구와 훅

| 항목 | 설명 |
|------|-------------|
| `ExitWorktree` | 현재 워크트리를 종료하고 정리하는 도구 |
| `WorktreeCreate` | 워크트리 생성 시 발생하는 훅 이벤트 |
| `WorktreeRemove` | 워크트리 삭제 시 발생하는 훅 이벤트 |

### 자동 정리

워크트리에서 변경이 이루어지지 않은 경우, 세션 종료 시 자동으로 정리됩니다.

### 사용 사례

- 메인 브랜치를 건드리지 않고 기능 브랜치에서 작업합니다
- 작업 디렉터리에 영향을 주지 않고 테스트를 격리 실행합니다
- 일회용 환경에서 실험적인 변경을 시도합니다
- 모노레포에서 특정 패키지를 스파스 체크아웃해 시작을 빠르게 합니다

---

## 샌드박스

샌드박스는 Claude Code가 실행하는 Bash 명령어에 OS 수준의 파일 시스템과 네트워크 격리를 제공합니다. 권한 규칙을 보완하여 추가적인 보안 계층을 제공합니다.

### 샌드박스 활성화

**슬래시 명령어**(이 프로젝트의 `.claude/settings.local.json`에 선택을 저장)**:**
```text
/sandbox
```

**설정 파일**(모든 프로젝트)**:** `~/.claude/settings.json`에 `"sandbox": { "enabled": true }`를 설정합니다.

**세션 단위**(설정 파일에 쓰지 않음)**:**
```bash
claude --settings '{"sandbox": {"enabled": true}}'
```

> `claude --sandbox` / `--no-sandbox` 플래그는 존재하지 않습니다. v2.1.300 이후 이것들을 `claude remote-control`에 전달하면 오류로 종료됩니다.

### 설정 항목

| 설정 | 설명 |
|---------|-------------|
| `sandbox.enabled` | 샌드박스를 활성화/비활성화 |
| `sandbox.failIfUnavailable` | 샌드박스를 시작할 수 없을 때 실패시킴 |
| `sandbox.filesystem.allowWrite` | 쓰기를 허용하는 경로 |
| `sandbox.filesystem.allowRead` | 읽기를 허용하는 경로 |
| `sandbox.filesystem.denyRead` | 읽기를 거부하는 경로 |
| `sandbox.network.allowedDomains` | Bash에서 시작한 프로세스의 접근을 허용하는 도메인(`*.` 와일드카드 지원) |
| `sandbox.network.deniedDomains` | `allowedDomains`의 와일드카드로 허용되더라도 차단하는 도메인(v2.1.113 이후) |
| `sandbox.enableWeakerNetworkIsolation` | macOS에서 약한 네트워크 격리를 활성화 |

`deniedDomains`가 넓은 와일드카드를 덮어쓰는 예(v2.1.113 이후):

```json
{
  "sandbox": {
    "network": {
      "allowedDomains": ["*.example.com"],
      "deniedDomains": ["evil.example.com"]
    }
  }
}
```

와일드카드에 의해 `example.com` 위의 모든 것이 통과하지만, `deniedDomains`로 개별 지정한 호스트는 차단됩니다.

### 설정 예

```json
{
  "sandbox": {
    "enabled": true,
    "failIfUnavailable": true,
    "filesystem": {
      "allowWrite": ["/Users/me/project"],
      "allowRead": ["/Users/me/project", "/usr/local/lib"],
      "denyRead": ["/Users/me/.ssh", "/Users/me/.aws"]
    }
  }
}
```

### 동작 원리

- Bash 명령어는 파일 시스템 접근을 제한한 샌드박스 환경에서 동작합니다
- 네트워크 접근을 격리해 의도치 않은 외부 연결을 막을 수 있습니다
- 다층 방어를 위해 권한 규칙과 함께 사용할 수 있습니다
- macOS에서는 Seatbelt가 샌드박스 프록시로의 연결 외의 모든 네트워크 연결을 차단합니다. `sandbox.enableWeakerNetworkIsolation`은 그 격리를 **약화하는** 설정으로, MITM `httpProxyPort` 프록시 아래의 Go 제작 CLI 등에 한해 사용합니다

### 사용 사례

- 신뢰할 수 없는 코드나 생성된 코드를 안전하게 실행합니다
- 프로젝트 외부 파일에 대한 잘못된 변경을 막습니다
- 자동화 작업 중 네트워크 접근을 제한합니다

---

## 관리형 설정(엔터프라이즈)

관리형 설정을 통해 엔터프라이즈 관리자가 플랫폼 네이티브 관리 도구를 사용해 조직 전체에 Claude Code 설정을 배포할 수 있습니다.

### 배포 방법

| 플랫폼 | 방법 | 지원 버전 |
|----------|--------|-------|
| macOS | 관리형 plist 파일(MDM) | v2.1.51 이후 |
| Windows | Windows 레지스트리 | v2.1.51 이후 |
| 크로스 플랫폼 | 관리형 설정 파일 | v2.1.51 이후 |
| 크로스 플랫폼 | 관리형 드롭인(`managed-settings.d/` 디렉터리) | v2.1.83 이후 |

### 관리형 드롭인

v2.1.83 이후 관리자는 여러 관리형 설정 파일을 `managed-settings.d/` 디렉터리에 배치할 수 있습니다. 파일은 알파벳순으로 병합되어 팀을 가로지르는 모듈식 설정이 가능해집니다. 이 디렉터리는 시스템 디렉터리 안의 `managed-settings.json` 옆에 둡니다(macOS는 `/Library/Application Support/ClaudeCode/`, Linux는 `/etc/claude-code/`, Windows는 `C:\Program Files\ClaudeCode\`):

```
/etc/claude-code/managed-settings.d/
  00-org-defaults.json
  10-team-policies.json
  20-project-overrides.json
```

### 사용 가능한 관리형 설정

| 설정 | 설명 |
|---------|-------------|
| `permissions.disableBypassPermissionsMode` | `"disable"`로 설정하면 사용자가 bypass permissions를 활성화하지 못하게 막습니다 |
| `availableModels` | 사용자가 선택할 수 있는 모델을 제한합니다 |
| `allowedChannelPlugins` | 허용할 채널 플러그인을 제어합니다 |
| `autoMode.environment` | 자동 모드의 신뢰 인프라를 설정합니다 |
| `wslInheritsWindowsSettings` | Windows/WSL 한정(v2.1.118 이후): `true`인 경우 WSL 안에서 동작하는 Claude Code가 Windows 호스트의 관리형 설정을 상속하여, Registry/MDM으로 배포된 기업 정책이 Windows 셸과 WSL 셸에 균일하게 적용됩니다 |
| 커스텀 정책 | 조직 고유의 권한과 도구 정책 |

### 예: macOS Plist

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>permissions</key>
  <dict>
    <key>disableBypassPermissionsMode</key>
    <string>disable</string>
  </dict>
  <key>availableModels</key>
  <array>
    <string>claude-sonnet-4-6</string>
    <string>claude-haiku-4-5</string>
  </array>
</dict>
</plist>
```

---

## 설정과 구성

### 설정 파일 위치

1. **사용자 설정:** `~/.claude/settings.json`
2. **프로젝트 설정:** `.claude/settings.json`(체크인함)
3. **로컬 프로젝트 설정:** `.claude/settings.local.json`(체크인하지 않음)
4. **관리형 설정:** 시스템 디렉터리 안의 `managed-settings.json`([관리형 설정](#관리형-설정엔터프라이즈) 참고)

### 완전한 설정 예

**핵심 고급 기능 설정**(`.claude/settings.json`):

```json
{
  "permissions": {
    "defaultMode": "default"
  },
  "hooks": {
    "PreToolUse": [
      { "matcher": "Edit", "hooks": [{ "type": "command", "command": "~/.claude/hooks/eslint-fix.sh" }] }
    ],
    "PostToolUse": [
      { "matcher": "Write", "hooks": [{ "type": "command", "command": "~/.claude/hooks/security-scan.sh" }] }
    ]
  }
}
```

훅 스크립트는 도구 입력을 stdin의 JSON으로 받습니다(예: `tool_input.file_path`). `${file_path}` 치환은 존재하지 않습니다. MCP 서버는 설정 키가 아니므로 프로젝트 루트의 `.mcp.json`에 정의합니다:

```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": { "Authorization": "Bearer ${GITHUB_PERSONAL_ACCESS_TOKEN}" }
    }
  }
}
```

**확장 설정 예:**

```json
{
  "permissions": {
    "defaultMode": "default",
    "allow": ["Bash(git log:*)", "Read"],
    "deny": ["Bash(rm -rf:*)"]
  },

  "hooks": {
    "PreToolUse": [{ "matcher": "Edit", "hooks": [{ "type": "command", "command": "~/.claude/hooks/eslint-fix.sh" }] }],
    "PostToolUse": [{ "matcher": "Write", "hooks": [{ "type": "command", "command": "~/.claude/hooks/security-scan.sh" }] }],
    "Stop": [{ "hooks": [{ "type": "command", "command": "~/.claude/hooks/notify.sh" }] }]
  }
}
```

이 구성의 GitHub MCP 서버는 위와 같이 `.mcp.json`에 둡니다.

### 환경 변수

설정을 환경 변수로 덮어씁니다:

```bash
# Model selection
export ANTHROPIC_MODEL=claude-opus-4-7
export ANTHROPIC_DEFAULT_OPUS_MODEL=claude-opus-4-7
export ANTHROPIC_DEFAULT_SONNET_MODEL=claude-sonnet-4-6
export ANTHROPIC_DEFAULT_HAIKU_MODEL=claude-haiku-4-5

# API configuration
export ANTHROPIC_API_KEY=sk-ant-...

# Thinking configuration
export MAX_THINKING_TOKENS=16000
export CLAUDE_CODE_EFFORT_LEVEL=xhigh   # low, medium, high, xhigh (Opus 4.7 only, default), or max (supported on Opus 4.7, Opus 4.6, Sonnet 4.6)

# Feature toggles
export CLAUDE_CODE_DISABLE_AUTO_MEMORY=1    # Disable auto memory (no auto memory files are created or loaded)
export CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=true
export CLAUDE_CODE_DISABLE_CRON=1
export CLAUDE_CODE_DISABLE_GIT_INSTRUCTIONS=true
export CLAUDE_CODE_DISABLE_TERMINAL_TITLE=true
export CLAUDE_CODE_DISABLE_1M_CONTEXT=true
export CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK=true
export CLAUDE_CODE_ENABLE_PROMPT_SUGGESTION=false
export CLAUDE_CODE_ENABLE_TASKS=0          # Task tools are the default; 0 reverts to the legacy TodoWrite tool
export CLAUDE_CODE_SIMPLE=true              # Set by --bare flag

# MCP configuration
export MAX_MCP_OUTPUT_TOKENS=50000
export ENABLE_TOOL_SEARCH=true

# Prompt caching
export ENABLE_PROMPT_CACHING_1H=1      # Request 1-hour cache TTL for all requests (default: 1h for the main conversation on a subscription, 5 min on API key / cloud providers)

# Task management
export CLAUDE_CODE_TASK_LIST_ID=my-project-tasks

# Agent teams (experimental)
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1

# Subagent and plugin configuration
export CLAUDE_CODE_SUBAGENT_MODEL=sonnet
export CLAUDE_CODE_PLUGIN_SEED_DIR=./my-plugins
export CLAUDE_CODE_NEW_INIT=1

# Subprocess and streaming
export CLAUDE_CODE_SUBPROCESS_ENV_SCRUB="SECRET_KEY,DB_PASSWORD"
export CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=80
export CLAUDE_STREAM_IDLE_TIMEOUT_MS=30000
export ANTHROPIC_CUSTOM_MODEL_OPTION=my-custom-model
export SLASH_COMMAND_TOOL_CHAR_BUDGET=50000
```

> **v2.1.108:** `ENABLE_PROMPT_CACHING_1H=1` — 메인 대화와 기타 요청에 1시간 프롬프트 캐시 TTL을 요청합니다. 설정하지 않으면 메인 대화는 플랜 사용량 범위 내의 Claude 구독에서는 1시간, API 키·사용량 크레딧·클라우드 프로바이더에서는 5분이 됩니다. `FORCE_PROMPT_CACHING_5M=1`은 5분을 강제합니다. 안정적인 장시간 세션에서 캐시 미스를 줄입니다.

### 설정 관리 명령어

```
User: /config
[Opens interactive configuration menu]
```

`/config` 명령어는 다음과 같은 설정을 토글하는 대화형 메뉴를 제공합니다:
- 확장 사고 켜기/끄기
- 상세 출력
- 권한 모드
- 모델 선택

### 프로젝트 단위 설정

프로젝트에 `.claude/settings.json`을 만듭니다:

```json
{
  "hooks": {
    "PreToolUse": [{ "matcher": "Bash", "hooks": [{ "type": "command", "command": "npm test && npm run lint" }] }]
  },
  "permissions": {
    "defaultMode": "default"
  }
}
```

프로젝트의 MCP 서버는 프로젝트 루트의 `.mcp.json`에 둡니다:

```json
{
  "mcpServers": {
    "project-db": {
      "command": "mcp-postgres",
      "env": {
        "DATABASE_URL": "${PROJECT_DB_URL}"
      }
    }
  }
}
```

---

## 에이전트 팀

에이전트 팀은 여러 Claude Code 인스턴스가 작업에서 협업할 수 있는 실험적 기능입니다. 기본적으로 비활성화되어 있습니다.

### 에이전트 팀 활성화

환경 변수 또는 설정으로 활성화합니다:

```bash
# Environment variable
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
```

또는 설정 JSON에 추가합니다:

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

### 에이전트 팀의 동작 원리

- **팀 리드**가 전체 작업을 조율하고 하위 작업을 팀원에게 위임합니다
- **팀원**은 각각 독자적인 컨텍스트 윈도우를 가지고 독립적으로 작업합니다
- **공유 태스크 리스트**로 팀 구성원 간의 자기 조율이 가능해집니다
- 서브에이전트 정의(`.claude/agents/` 또는 `--agents` 플래그)로 팀원의 역할과 전문성을 정의합니다

### 표시 모드

에이전트 팀은 `--teammate-mode` 플래그로 설정하는 2가지 표시 모드를 지원합니다:

| 모드 | 설명 |
|------|-------------|
| `in-process`(기본값) | 팀원이 같은 터미널 프로세스 안에서 동작합니다 |
| `tmux` | 각 팀원이 전용 분할 창을 가집니다(tmux 또는 iTerm2 필요) |
| `auto` | 최적의 표시 모드를 자동 선택합니다 |

```bash
# Use tmux split panes for teammate display
claude --teammate-mode tmux

# Explicitly use in-process mode
claude --teammate-mode in-process
```

### 사용 사례

- 서로 다른 팀원이 서로 다른 모듈을 담당하는 대규모 리팩터링
- 병렬 코드 리뷰와 구현
- 코드베이스 전반에 걸친 여러 파일 변경 조율

> **참고:** 에이전트 팀은 실험적 기능이며 향후 릴리스에서 변경될 수 있습니다. 전체 레퍼런스는 [code.claude.com/docs/en/agent-teams](https://code.claude.com/docs/en/agent-teams)를 참고하세요.

---

## 모범 사례

### 플랜 모드
- ✅ 복잡한 다단계 작업에 사용합니다
- ✅ 승인 전에 계획을 검토합니다
- ✅ 필요에 따라 계획을 수정합니다
- ❌ 단순한 작업에는 사용하지 않습니다

### 확장 사고
- ✅ 아키텍처 판단에 사용합니다
- ✅ 복잡한 문제 해결에 사용합니다
- ✅ 사고 과정을 검토합니다
- ❌ 단순한 쿼리에는 사용하지 않습니다

### 백그라운드 작업
- ✅ 장시간 실행되는 작업에 사용합니다
- ✅ 작업 진행 상황을 감시합니다
- ✅ 작업 실패를 적절히 처리합니다
- ❌ 동시 작업을 지나치게 많이 시작하지 않습니다

### 권한
- ✅ 코드 리뷰에는 `plan`(읽기 전용)을 사용합니다
- ✅ 대화형 개발에는 `default`를 사용합니다
- ✅ 자동화 워크플로에는 `acceptEdits`를 사용합니다
- ✅ 안전 가드레일이 있는 자율 작업에는 `auto`를 사용합니다
- ✅ 꼭 필요한 경우가 아니면 `bypassPermissions`를 사용하지 않습니다

### 세션
- ✅ 서로 다른 작업에는 별도의 세션을 사용합니다
- ✅ 중요한 세션 상태를 저장합니다
- ✅ 오래된 세션을 정리합니다
- ❌ 한 세션에 무관한 작업을 섞지 않습니다

---

## 추가 자료

Claude Code와 관련 기능의 상세 정보:

- [Official Interactive Mode Documentation](https://code.claude.com/docs/en/interactive-mode)
- [Official Headless Mode Documentation](https://code.claude.com/docs/en/headless)
- [CLI Reference](https://code.claude.com/docs/en/cli-reference)
- [Checkpoints Guide](../08-checkpoints/) — 세션 관리와 되감기
- [Slash Commands](../01-slash-commands/) — 명령어 레퍼런스
- [Memory Guide](../02-memory/) — 영속 컨텍스트
- [Skills Guide](../03-skills/) — 자율 기능
- [Subagents Guide](../04-subagents/) — 작업 위임 실행
- [MCP Guide](../05-mcp/) — 외부 데이터 접근
- [Hooks Guide](../06-hooks/) — 이벤트 기반 자동화
- [Plugins Guide](../07-plugins/) — 번들 확장
- [Official Scheduled Tasks Documentation](https://code.claude.com/docs/en/scheduled-tasks)
- [Official Chrome Integration Documentation](https://code.claude.com/docs/en/chrome)
- [Official Remote Control Documentation](https://code.claude.com/docs/en/remote-control)
- [Official Keybindings Documentation](https://code.claude.com/docs/en/keybindings)
- [Official Desktop App Documentation](https://code.claude.com/docs/en/desktop)
- [Official Agent Teams Documentation](https://code.claude.com/docs/en/agent-teams)

---

**최종 업데이트:** 2026년 10월 18일
**Claude Code 버전:** 2.1.302
**정보 출처:**
- https://code.claude.com/docs/en/permissions
- https://code.claude.com/docs/en/auto-mode-classifier-billing
- https://code.claude.com/docs/en/permission-modes
- https://code.claude.com/docs/en/commands
- https://code.claude.com/docs/en/interactive-mode
- https://code.claude.com/docs/en/settings
- https://www.anthropic.com/news/claude-opus-4-7
- https://github.com/anthropics/claude-code/releases/tag/v2.1.117
- https://github.com/anthropics/claude-code/releases/tag/v2.1.118
- https://code.claude.com/docs/en/keybindings#modifiers
- https://code.claude.com/docs/en/permission-modes
- https://github.com/anthropics/claude-code/releases/tag/v2.1.283
- https://code.claude.com/docs/en/permission-modes#which-mode-a-session-starts-in
- https://github.com/anthropics/claude-code/releases/tag/v2.1.284
- https://github.com/anthropics/claude-code/releases/tag/v2.1.285
- https://code.claude.com/docs/en/remote-control
- https://code.claude.com/docs/en/changelog#2-1-300
- https://code.claude.com/docs/en/sandboxing
- https://code.claude.com/docs/en/settings-reference#sandbox-enabled
- https://code.claude.com/docs/en/prompt-caching
- https://code.claude.com/docs/en/agent-teams
- https://code.claude.com/docs/en/hooks
- https://code.claude.com/docs/en/managed-settings
- https://code.claude.com/docs/en/channels
- https://code.claude.com/docs/en/desktop
- https://code.claude.com/docs/en/fullscreen
- https://code.claude.com/docs/en/chrome
- https://code.claude.com/docs/en/env-vars
- https://code.claude.com/docs/en/changelog#2-1-302

**호환 모델:** Claude Sonnet 4.6, Claude Opus 4.7, Claude Haiku 4.5
