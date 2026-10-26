<!-- i18n-source: INDEX.md -->
<!-- i18n-source-sha: d17d515 -->
<!-- i18n-date: 2026-10-26 -->

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

# Claude Code 예제 — 전체 색인

이 문서는 기능 종류별로 정리한 모든 예제 파일의 전체 색인입니다.

## 요약 통계

- **총 파일 수**: 100개 이상
- **카테고리**: 10개 기능 카테고리
- **플러그인**: 완전한 플러그인 3개
- **스킬**: 완전한 스킬 6개
- **훅**: 예제 훅 8개
- **바로 사용 가능**: 모든 예제

---

## 01. 슬래시 명령어 (10개 파일)

일상 워크플로를 위해 사용자가 실행하는 단축 명령입니다.

| 파일 | 설명 | 사용 사례 |
|------|-------------|----------|
| `optimize.md` | 코드 최적화 분석기 | 성능 문제 탐지 |
| `pr.md` | 풀 리퀘스트 준비 | PR 워크플로 자동화 |
| `generate-api-docs.md` | API 문서 생성 | API 문서 생성 |
| `commit.md` | 커밋 메시지 보조 | 표준화된 커밋 |
| `setup-ci-cd.md` | CI/CD 파이프라인 설정 | DevOps 자동화 |
| `push-all.md` | 모든 변경 사항 push | 빠른 push 워크플로 |
| `unit-test-expand.md` | 단위 테스트 커버리지 확장 | 테스트 자동화 |
| `doc-refactor.md` | 문서 리팩터링 | 문서 개선 |
| `pr-slash-command.png` | 스크린샷 예시 | 시각적 참고 자료 |
| `README.md` | 문서 | 설치와 사용 가이드 |

**설치 위치**: `.claude/commands/`

**사용법**: `/optimize`, `/pr`, `/generate-api-docs`, `/commit`, `/setup-ci-cd`, `/push-all`, `/unit-test-expand`, `/doc-refactor`

---

## 02. 메모리 (6개 파일)

영속적인 컨텍스트와 프로젝트 규약입니다.

| 파일 | 설명 | 범위 | 배치 위치 |
|------|-------------|-------|----------|
| `project-CLAUDE.md` | 팀 프로젝트 규약 | 프로젝트 전체 | `./CLAUDE.md` |
| `directory-api-CLAUDE.md` | API 전용 규칙 | 디렉터리 | `./src/api/CLAUDE.md` |
| `personal-CLAUDE.md` | 개인 선호 설정 | 사용자 | `~/.claude/CLAUDE.md` |
| `memory-saved.png` | 스크린샷: 저장된 메모리 | - | 시각적 참고 자료 |
| `memory-ask-claude.png` | 스크린샷: Claude에게 질문 | - | 시각적 참고 자료 |
| `README.md` | 문서 | - | 레퍼런스 |

**설치**: 적절한 위치에 복사

**사용법**: Claude가 자동으로 읽어 들입니다

---

## 03. 스킬 (28개 파일)

스크립트와 템플릿을 포함한 자동 호출 기능입니다.

### 코드 리뷰 스킬 (5개 파일)
```
code-review/
├── SKILL.md                          # 스킬 정의
├── scripts/
│   ├── analyze-metrics.py            # 코드 메트릭 분석
│   └── compare-complexity.py         # 복잡도 비교
└── templates/
    ├── review-checklist.md           # 리뷰 체크리스트
    └── finding-template.md           # 지적 사항 문서
```

**목적**: 보안, 성능, 품질 분석을 포함한 포괄적인 코드 리뷰

**자동 호출**: 코드 리뷰 시

---

### 브랜드 보이스 스킬 (4개 파일)
```
brand-voice/
├── SKILL.md                          # 스킬 정의
├── templates/
│   ├── email-template.txt            # 이메일 형식
│   └── social-post-template.txt      # SNS 형식
└── tone-examples.md                  # 메시지 예시
```

**목적**: 커뮤니케이션에서 브랜드 보이스의 일관성 유지

**자동 호출**: 마케팅 문구 작성 시

---

### 문서 생성 스킬 (2개 파일)
```
doc-generator/
├── SKILL.md                          # 스킬 정의
└── generate-docs.py                  # Python 문서 추출
```

**목적**: 소스 코드에서 포괄적인 API 문서 생성

**자동 호출**: API 문서 작성·업데이트 시

---

### 리팩터링 스킬 (5개 파일)
```
refactor/
├── SKILL.md                          # 스킬 정의
├── scripts/
│   ├── analyze-complexity.py         # 복잡도 분석
│   └── detect-smells.py              # 코드 스멜 탐지
├── references/
│   ├── code-smells.md                # 코드 스멜 카탈로그
│   └── refactoring-catalog.md        # 리팩터링 패턴
└── templates/
    └── refactoring-plan.md           # 리팩터링 계획 템플릿
```

**목적**: 복잡도 분석을 동반한 체계적인 리팩터링

**자동 호출**: 코드 리팩터링 시

---

### Claude MD 스킬 (1개 파일)
```
claude-md/
└── SKILL.md                          # 스킬 정의
```

**목적**: CLAUDE.md 파일 관리와 최적화

---

### 블로그 초안 스킬 (3개 파일)
```
blog-draft/
├── SKILL.md                          # 스킬 정의
└── templates/
    ├── draft-template.md             # 블로그 초안 템플릿
    └── outline-template.md           # 블로그 개요 템플릿
```

**목적**: 일관된 구조로 블로그 글 초안 작성

**추가**: `README.md` — 스킬 개요와 사용 가이드

**설치 위치**: `~/.claude/skills/` 또는 `.claude/skills/`

---

## 04. 서브에이전트 (10개 파일)

맞춤형 능력을 갖춘 전문 특화 AI 어시스턴트입니다.

| 파일 | 설명 | 도구 | 사용 사례 |
|------|-------------|-------|----------|
| `code-reviewer.md` | 코드 품질 분석 | Read, Grep, Glob, Bash | 포괄적인 리뷰 |
| `test-engineer.md` | 테스트 커버리지 분석 | Read, Write, Bash, Grep | 테스트 자동화 |
| `documentation-writer.md` | 문서 작성 | Read, Write, Grep | 문서 생성 |
| `secure-reviewer.md` | 보안 리뷰(읽기 전용) | Read, Grep | 보안 감사 |
| `implementation-agent.md` | 전체 구현 | Read, Write, Edit, Bash, Grep, Glob | 기능 개발 |
| `debugger.md` | 디버깅 전문가 | Read, Edit, Bash, Grep, Glob | 버그 조사 |
| `data-scientist.md` | 데이터 분석 전문가 | Bash, Read, Write | 데이터 워크플로 |
| `clean-code-reviewer.md` | 클린 코드 기준 | Read, Grep, Glob, Bash | 코드 품질 |
| `performance-optimizer.md` | 성능 병목 분석 | Read, Edit, Bash, Grep, Glob | 최적화 작업 |
| `README.md` | 문서 | - | 설치와 사용 가이드 |

**설치 위치**: `.claude/agents/`

**사용법**: 메인 에이전트가 자동으로 위임합니다

---

## 05. MCP 프로토콜 (5개 파일)

외부 도구와 API 통합입니다.

| 파일 | 설명 | 연동 대상 | 사용 사례 |
|------|-------------|-----------------|----------|
| `github-mcp.json` | GitHub 연동 | GitHub API | PR / 이슈 관리 |
| `database-mcp.json` | 데이터베이스 쿼리 | PostgreSQL/MySQL | 실시간 데이터 쿼리 |
| `filesystem-mcp.json` | 파일 작업 | 로컬 파일 시스템 | 파일 관리 |
| `multi-mcp.json` | 여러 서버 | GitHub + DB + Slack | 완전 통합 |
| `README.md` | 문서 | - | 설치와 사용 가이드 |

**설치 위치**: `.mcp.json`(프로젝트 범위) 또는 `~/.claude.json`(사용자 범위)

**사용법**: `/mcp__github__list_prs` 등

---

## 06. 훅 (10개 파일)

자동으로 실행되는 이벤트 기반 자동화 스크립트입니다.

| 파일 | 설명 | 이벤트 | 사용 사례 |
|------|-------------|-------|----------|
| `format-code.sh` | 코드 자동 포매팅 | PostToolUse (matcher: Write) | 코드 포매팅 |
| `pre-commit.sh` | 커밋 전 테스트 실행 | PreToolUse (matcher: Bash) | 테스트 자동화 |
| `pre-tool-check.sh` | 실행 전 명령어 검증과 감사 | PreToolUse (matcher: Bash) | 가드레일, 감사 로그 |
| `security-scan.sh` | 보안 스캔 | PostToolUse (matcher: Write) | 보안 점검 |
| `dependency-check.sh` | 의존성 매니페스트 취약점 스캔 | PostToolUse (matcher: Write) | 공급망 검사 |
| `log-bash.sh` | bash 명령어 기록 | PostToolUse (matcher: Bash) | 명령어 로그 |
| `notify-team.sh` | 알림 전송 | PostToolUse (matcher: Bash) | 팀 알림 |
| `validate-prompt.sh` | 프롬프트 검증 | UserPromptSubmit | 입력 검증 |
| `session-end.sh` | 세션 종료 시 진행 상황 기록 | SessionEnd | 진행 상황 추적 |
| `README.md` | 문서 | - | 설치와 사용 가이드 |

**설치 위치**: `~/.claude/settings.json`에서 설정

**사용법**: 설정에서 구성하면 자동으로 실행됩니다

**훅 종류**(5종): `command`, `http`, `prompt`, `mcp_tool`, `agent` — 훅의 실행 방식입니다.

**훅 이벤트**(33개, 4개 카테고리) — 실행 시점:
- 도구 계열 훅: PreToolUse, PostToolUse, PostToolUseFailure, PostToolBatch, PermissionRequest, PermissionDenied
- 세션 계열 훅: SessionStart, Setup, SessionEnd, Stop, StopFailure, SubagentStart, SubagentStop
- 작업 계열 훅: UserPromptSubmit, UserPromptExpansion, MessageDisplay, TaskCompleted, TaskCreated, TeammateIdle(TaskCompleted와 TaskCreated는 todo 도구가 활성화된 경우에만 실행 — Claude 3.x, Opus 4~4.7, Sonnet 4~4.6, Haiku 4.5에서만 기본 활성화. `CLAUDE_CODE_ENABLE_TODO_TOOLS=1`로 다시 켤 수 있음)
- 라이프사이클 계열 훅: ConfigChange, CwdChanged, DirectoryAdded, FileChanged, PreCompact, PostCompact, PreModelSwitch, PostModelSwitch, WorktreeCreate, WorktreeRemove, Notification, InstructionsLoaded, Elicitation, ElicitationResult

---

## 07. 플러그인 (완전한 플러그인 3개, 40개 파일)

기능을 묶은 번들 모음입니다.

### PR 리뷰 플러그인 (10개 파일)
```
pr-review/
├── .claude-plugin/
│   └── plugin.json                   # 플러그인 매니페스트
├── commands/
│   ├── review-pr.md                  # 포괄적인 리뷰
│   ├── check-security.md             # 보안 점검
│   └── check-tests.md                # 테스트 커버리지 점검
├── agents/
│   ├── security-reviewer.md          # 보안 전문가
│   ├── test-checker.md               # 테스트 전문가
│   └── performance-analyzer.md       # 성능 전문가
├── mcp/
│   └── github-config.json            # GitHub 연동
├── hooks/
│   └── pre-review.js                 # 리뷰 전 검증
└── README.md                         # 플러그인 문서
```

**기능**: 보안 분석, 테스트 커버리지, 성능 영향

**명령어**: `/review-pr`, `/check-security`, `/check-tests`

**설치**: `claude --plugin-dir ./07-plugins/pr-review` (저장소 루트에서)

---

### DevOps 자동화 플러그인 (15개 파일)
```
devops-automation/
├── .claude-plugin/
│   └── plugin.json                   # 플러그인 매니페스트
├── commands/
│   ├── deploy.md                     # 배포
│   ├── rollback.md                   # 롤백
│   ├── status.md                     # 시스템 상태
│   └── incident.md                   # 인시던트 대응
├── agents/
│   ├── deployment-specialist.md      # 배포 전문가
│   ├── incident-commander.md         # 인시던트 지휘
│   └── alert-analyzer.md             # 알림 분석
├── mcp/
│   └── kubernetes-config.json        # Kubernetes 연동
├── hooks/
│   ├── pre-deploy.js                 # 배포 전 점검
│   └── post-deploy.js                # 배포 후 작업
├── scripts/
│   ├── deploy.sh                     # 배포 자동화
│   ├── rollback.sh                   # 롤백 자동화
│   └── health-check.sh               # 헬스 체크
└── README.md                         # 플러그인 문서
```

**기능**: Kubernetes 배포, 롤백, 모니터링, 인시던트 대응

**명령어**: `/deploy`, `/rollback`, `/status`, `/incident`

**설치**: `claude --plugin-dir ./07-plugins/devops-automation` (저장소 루트에서)

---

### 문서 플러그인 (14개 파일)
```
documentation/
├── .claude-plugin/
│   └── plugin.json                   # 플러그인 매니페스트
├── commands/
│   ├── generate-api-docs.md          # API 문서 생성
│   ├── generate-readme.md            # README 작성
│   ├── sync-docs.md                  # 문서 동기화
│   └── validate-docs.md              # 문서 검증
├── agents/
│   ├── api-documenter.md             # API 문서 전문가
│   ├── code-commentator.md           # 코드 주석 전문가
│   └── example-generator.md          # 예제 작성
├── mcp/
│   └── github-docs-config.json       # GitHub 연동
├── templates/
│   ├── api-endpoint.md               # API 엔드포인트 템플릿
│   ├── function-docs.md              # 함수 문서 템플릿
│   └── adr-template.md               # ADR 템플릿
└── README.md                         # 플러그인 문서
```

**기능**: API 문서, README 생성, 문서 동기화, 검증

**명령어**: `/generate-api-docs`, `/generate-readme`, `/sync-docs`, `/validate-docs`

**설치**: `claude --plugin-dir ./07-plugins/documentation` (저장소 루트에서)

**추가**: `README.md` — 플러그인 개요와 사용 가이드

---

## 08. 체크포인트와 되감기 (2개 파일)

대화 상태를 저장하고 다른 접근 방식을 탐색합니다.

| 파일 | 설명 | 내용 |
|------|-------------|---------|
| `README.md` | 문서 | 포괄적인 체크포인트 가이드 |
| `checkpoint-examples.md` | 실용 예제 | DB 마이그레이션, 성능 최적화, UI 반복, 디버깅 |
| | | |

**주요 개념**:
- **체크포인트**: 대화 상태의 스냅샷
- **되감기**: 이전 체크포인트로 돌아가기
- **분기점**: 여러 접근 방식 탐색하기

**사용법**:
```
# 체크포인트는 사용자 프롬프트마다 자동으로 생성됩니다
# 되감기는 Esc를 두 번 누르거나 다음을 실행합니다:
/rewind
# 선택지: 코드와 대화 복원, 대화 복원,
# 코드 복원, 여기부터 요약, 여기까지 요약, 취소
```

**사용 사례**:
- 다른 구현 시도하기
- 실수로부터 복구하기
- 안전한 실험
- 해결책 비교
- A/B 테스트

---

## 09. 고급 기능 (3개 파일)

복잡한 워크플로를 위한 고급 기능입니다.

| 파일 | 설명 | 기능 |
|------|-------------|----------|
| `README.md` | 완전 가이드 | 모든 고급 기능 문서 |
| `config-examples.json` | 설정 예시 | 사용 사례별 10종 이상의 설정 |
| `planning-mode-examples.md` | 플래닝 예시 | REST API, DB 마이그레이션, 리팩터링 |
| 예약 작업 | `/loop`와 cron 도구를 이용한 반복 작업 | 자동화된 반복 워크플로 |
| Chrome 연동 | Claude in Chrome 확장 프로그램으로 자신의 Chrome에서 브라우저 자동화 | 웹 테스트와 스크래핑 |
| 리모트 컨트롤(확장) | 연결 방식, 보안, 비교표 | 원격 세션 관리 |
| 키 바인딩 사용자 지정 | 사용자 지정 키 바인딩, 코드 대응, 컨텍스트 | 개인화된 단축키 |
| 데스크톱 앱(확장) | 커넥터, launch.json, 엔터프라이즈 기능 | 데스크톱 통합 |
| | | |

**다루는 고급 기능**:

### 플랜 모드
- 상세한 구현 계획 작성
- 시간 추정과 위험 평가
- 체계적인 작업 분해

### 확장 사고
- 복잡한 문제에 대한 깊은 추론
- 아키텍처 의사결정 분석
- 트레이드오프 평가

### 백그라운드 작업
- 차단 없는 장시간 처리
- 병렬 개발 워크플로
- 작업 관리와 모니터링

### 권한 모드
- **default**: 위험한 작업에서 승인을 요청합니다
- **acceptEdits**: 파일 편집은 자동 승인, 그 외에는 확인합니다
- **plan**: 읽기 전용 분석, 변경 없음
- **auto**: 백그라운드 안전 점검과 함께 모든 작업을 실행합니다 — 분류기가 명령어와 보호 디렉터리 쓰기를 심사합니다(`autoMode` 설정 객체로 구성)
- **dontAsk**: 사전 승인된 도구만 — 원래 프롬프트가 뜰 호출은 모두 자동으로 거부됩니다. Claude가 실행할 수 있는 것은 `permissions.allow`에 일치하는 것, 읽기 전용 Bash 명령어, `PreToolUse` 훅이 승인한 호출뿐입니다
- **bypassPermissions**: 모두 승인(`--permission-mode bypassPermissions` 또는 동등한 `--dangerously-skip-permissions`로 활성화)

### 헤드리스 모드(`claude -p`)
- CI/CD 통합
- 자동화된 작업 실행
- 배치 처리

### 세션 관리
- 여러 작업 세션
- 세션 전환과 저장
- 세션 영속화

### 대화형 기능
- 키보드 단축키
- 명령어 이력
- 탭 자동 완성
- 여러 줄 입력

### 설정
- 포괄적인 설정 관리
- 환경별 설정
- 프로젝트별 사용자 지정

### 예약 작업
- `/loop` 명령어를 이용한 반복 작업
- cron 도구: CronCreate, CronList, CronDelete
- 자동화된 반복 워크플로

### Chrome 연동
- Claude in Chrome 확장 프로그램으로 자신의 Chrome에서 브라우저 자동화
- 웹 테스트와 스크래핑 능력
- 페이지 조작과 데이터 추출

### 리모트 컨트롤(확장)
- 연결 방식과 프로토콜
- 보안 유의 사항과 모범 사례
- 원격 접근 옵션 비교표

### 키 바인딩 사용자 지정
- 사용자 지정 키 바인딩 설정
- 여러 키 단축키의 코드 대응
- 컨텍스트에 따른 키 바인딩 활성화

### 데스크톱 앱(확장)
- IDE 통합을 위한 커넥터
- launch.json 설정
- 엔터프라이즈 기능과 배포

---

## 10. CLI 사용 (1개 파일)

명령줄 인터페이스의 사용 패턴과 레퍼런스입니다.

| 파일 | 설명 | 내용 |
|------|-------------|---------|
| `README.md` | CLI 문서 | 플래그, 옵션, 사용 패턴 |

**주요 CLI 기능**:
- `claude` — 대화형 세션 시작
- `claude -p "prompt"` — 헤드리스 / 비대화형 모드
- `claude --cloud "task"` — 클라우드(웹) 세션 시작
- `claude --model` — 모델 선택(Sonnet 4.6, Opus 4.7, Haiku 4.5)
- `claude --permission-mode` — 권한 모드 설정
- `claude --remote-control` — claude.ai나 Claude 앱에서도 조작할 수 있는 세션 시작

---

## 문서 파일 (13개 파일)

| 파일 | 위치 | 설명 |
|------|----------|-------------|
| `README.md` | `/` | 메인 예제 개요 |
| `INDEX.md` | `/` | 이 전체 색인 |
| `QUICK_REFERENCE.md` | `/` | 빠른 참조 카드 |
| `README.md` | `/01-slash-commands/` | 슬래시 명령어 가이드 |
| `README.md` | `/02-memory/` | 메모리 가이드 |
| `README.md` | `/03-skills/` | 스킬 가이드 |
| `README.md` | `/04-subagents/` | 서브에이전트 가이드 |
| `README.md` | `/05-mcp/` | MCP 가이드 |
| `README.md` | `/06-hooks/` | 훅 가이드 |
| `README.md` | `/07-plugins/` | 플러그인 가이드 |
| `README.md` | `/08-checkpoints/` | 체크포인트 가이드 |
| `README.md` | `/09-advanced-features/` | 고급 기능 가이드 |
| `README.md` | `/10-cli/` | CLI 가이드 |

---

## 전체 파일 트리

```
claude-howto/
├── README.md                                    # 메인 개요
├── INDEX.md                                     # 이 파일
├── QUICK_REFERENCE.md                           # 빠른 참조 카드
├── claude_concepts_guide.md                     # 원본 가이드
│
├── 01-slash-commands/                           # 슬래시 명령어
│   ├── optimize.md
│   ├── pr.md
│   ├── generate-api-docs.md
│   ├── commit.md
│   ├── setup-ci-cd.md
│   ├── push-all.md
│   ├── unit-test-expand.md
│   ├── doc-refactor.md
│   ├── pr-slash-command.png
│   └── README.md
│
├── 02-memory/                                   # 메모리
│   ├── project-CLAUDE.md
│   ├── directory-api-CLAUDE.md
│   ├── personal-CLAUDE.md
│   ├── memory-saved.png
│   ├── memory-ask-claude.png
│   └── README.md
│
├── 03-skills/                                   # 스킬
│   ├── code-review/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   │   ├── analyze-metrics.py
│   │   │   └── compare-complexity.py
│   │   └── templates/
│   │       ├── review-checklist.md
│   │       └── finding-template.md
│   ├── brand-voice/
│   │   ├── SKILL.md
│   │   ├── templates/
│   │   │   ├── email-template.txt
│   │   │   └── social-post-template.txt
│   │   └── tone-examples.md
│   ├── doc-generator/
│   │   ├── SKILL.md
│   │   └── generate-docs.py
│   ├── refactor/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   │   ├── analyze-complexity.py
│   │   │   └── detect-smells.py
│   │   ├── references/
│   │   │   ├── code-smells.md
│   │   │   └── refactoring-catalog.md
│   │   └── templates/
│   │       └── refactoring-plan.md
│   ├── claude-md/
│   │   └── SKILL.md
│   ├── blog-draft/
│   │   ├── SKILL.md
│   │   └── templates/
│   │       ├── draft-template.md
│   │       └── outline-template.md
│   └── README.md
│
├── 04-subagents/                                # 서브에이전트
│   ├── code-reviewer.md
│   ├── test-engineer.md
│   ├── documentation-writer.md
│   ├── secure-reviewer.md
│   ├── implementation-agent.md
│   ├── debugger.md
│   ├── data-scientist.md
│   ├── clean-code-reviewer.md
│   └── README.md
│
├── 05-mcp/                                      # MCP 프로토콜
│   ├── github-mcp.json
│   ├── database-mcp.json
│   ├── filesystem-mcp.json
│   ├── multi-mcp.json
│   └── README.md
│
├── 06-hooks/                                    # 훅
│   ├── format-code.sh
│   ├── pre-commit.sh
│   ├── security-scan.sh
│   ├── log-bash.sh
│   ├── validate-prompt.sh
│   ├── notify-team.sh
│   ├── context-tracker.py
│   ├── context-tracker-tiktoken.py
│   └── README.md
│
├── 07-plugins/                                  # 플러그인
│   ├── pr-review/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── review-pr.md
│   │   │   ├── check-security.md
│   │   │   └── check-tests.md
│   │   ├── agents/
│   │   │   ├── security-reviewer.md
│   │   │   ├── test-checker.md
│   │   │   └── performance-analyzer.md
│   │   ├── mcp/
│   │   │   └── github-config.json
│   │   ├── hooks/
│   │   │   └── pre-review.js
│   │   └── README.md
│   ├── devops-automation/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── deploy.md
│   │   │   ├── rollback.md
│   │   │   ├── status.md
│   │   │   └── incident.md
│   │   ├── agents/
│   │   │   ├── deployment-specialist.md
│   │   │   ├── incident-commander.md
│   │   │   └── alert-analyzer.md
│   │   ├── mcp/
│   │   │   └── kubernetes-config.json
│   │   ├── hooks/
│   │   │   ├── pre-deploy.js
│   │   │   └── post-deploy.js
│   │   ├── scripts/
│   │   │   ├── deploy.sh
│   │   │   ├── rollback.sh
│   │   │   └── health-check.sh
│   │   └── README.md
│   ├── documentation/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── generate-api-docs.md
│   │   │   ├── generate-readme.md
│   │   │   ├── sync-docs.md
│   │   │   └── validate-docs.md
│   │   ├── agents/
│   │   │   ├── api-documenter.md
│   │   │   ├── code-commentator.md
│   │   │   └── example-generator.md
│   │   ├── mcp/
│   │   │   └── github-docs-config.json
│   │   ├── templates/
│   │   │   ├── api-endpoint.md
│   │   │   ├── function-docs.md
│   │   │   └── adr-template.md
│   │   └── README.md
│   └── README.md
│
├── 08-checkpoints/                              # 체크포인트
│   ├── checkpoint-examples.md
│   └── README.md
│
├── 09-advanced-features/                        # 고급 기능
│   ├── config-examples.json
│   ├── planning-mode-examples.md
│   └── README.md
│
└── 10-cli/                                      # CLI 사용
    └── README.md
```

---

## 사용 사례별 빠른 시작

### 코드 품질과 리뷰
```bash
# 슬래시 명령어 설치
cp 01-slash-commands/optimize.md .claude/commands/

# 서브에이전트 설치
cp 04-subagents/code-reviewer.md .claude/agents/

# 스킬 설치
cp -r 03-skills/code-review-specialist ~/.claude/skills/

# 또는 완전한 플러그인 설치
claude --plugin-dir ./07-plugins/pr-review
```

### DevOps와 배포
```bash
# 플러그인 설치 (모두 포함)
claude --plugin-dir ./07-plugins/devops-automation
```

### 문서
```bash
# 슬래시 명령어 설치
cp 01-slash-commands/generate-api-docs.md .claude/commands/

# 서브에이전트 설치
cp 04-subagents/documentation-writer.md .claude/agents/

# 스킬 설치
cp -r 03-skills/doc-generator ~/.claude/skills/

# 또는 완전한 플러그인 설치
claude --plugin-dir ./07-plugins/documentation
```

### 팀 표준
```bash
# 프로젝트 메모리 설정
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# 팀 표준에 맞게 편집
```

### 외부 통합
```bash
# 환경 변수 설정
export GITHUB_PERSONAL_ACCESS_TOKEN="your_token"
export DATABASE_URL="postgresql://..."
export SLACK_BOT_TOKEN="your-slack-bot-token"
export SLACK_TEAM_ID="T0000000000"

# MCP 설정 설치 (프로젝트 범위)
cp 05-mcp/multi-mcp.json .mcp.json
```

### 자동화와 검증
```bash
# 훅 설치
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# 설정에서 훅 구성 (~/.claude/settings.json)
# 06-hooks/README.md 참조
```

### 안전한 실험
```bash
# 체크포인트는 사용자 프롬프트마다 자동으로 생성됩니다
# 되감기: Esc+Esc를 누르거나 /rewind
# 되감기 메뉴에서 무엇을 복원할지 선택

# 예제는 08-checkpoints/README.md 참조
```

### 고급 워크플로
```bash
# 고급 기능 설정
# 09-advanced-features/config-examples.json 참조

# 플랜 모드 사용
/plan Implement feature X

# 권한 모드 사용
claude --permission-mode plan          # 코드 리뷰 (읽기 전용)
claude --permission-mode acceptEdits   # 편집 자동 승인
claude --permission-mode auto          # 안전한 작업 자동 승인

# CI/CD를 위한 헤드리스 모드로 실행
claude -p "Run tests and report results"

# 백그라운드 작업 실행
Run tests in background

# 완전 가이드는 09-advanced-features/README.md 참조
```

---

## 기능 커버리지 매트릭스

| 카테고리 | 명령어 | 에이전트 | MCP | 훅 | 스크립트 | 템플릿 | 문서 | 이미지 | 합계 |
|----------|----------|--------|-----|-------|---------|-----------|------|--------|-------|
| **01 슬래시 명령어** | 8 | - | - | - | - | - | 1 | 1 | **10** |
| **02 메모리** | - | - | - | - | - | 3 | 1 | 2 | **6** |
| **03 스킬** | - | - | - | - | 5 | 9 | 1 | - | **28** |
| **04 서브에이전트** | - | 9 | - | - | - | - | 1 | - | **10** |
| **05 MCP** | - | - | 4 | - | - | - | 1 | - | **5** |
| **06 훅** | - | - | - | 9 | - | - | 1 | - | **10** |
| **07 플러그인** | 11 | 9 | 3 | 3 | 3 | 3 | 4 | - | **40** |
| **08 체크포인트** | - | - | - | - | - | - | 1 | 1 | **2** |
| **09 고급 기능** | - | - | - | - | - | - | 1 | 2 | **3** |
| **10 CLI** | - | - | - | - | - | - | 1 | - | **1** |

---

## 학습 경로

### 초급 (1주 차)
1. ✅ `README.md` 읽기
2. ✅ 슬래시 명령어 1~2개 설치
3. ✅ 프로젝트 메모리 파일 작성
4. ✅ 기본 명령어 시도

### 중급 (2~3주 차)
1. ✅ GitHub MCP 설정
2. ✅ 서브에이전트 설치
3. ✅ 작업 위임 시도
4. ✅ 스킬 설치

### 고급 (4주 차~)
1. ✅ 완전한 플러그인 설치
2. ✅ 사용자 지정 슬래시 명령어 작성
3. ✅ 사용자 지정 서브에이전트 작성
4. ✅ 사용자 지정 스킬 작성
5. ✅ 자신만의 플러그인 구축

### 전문가 (5주 차~)
1. ✅ 자동화를 위한 훅 설정
2. ✅ 실험을 위한 체크포인트 사용
3. ✅ 플랜 모드 설정
4. ✅ 권한 모드를 효과적으로 사용
5. ✅ CI/CD를 위한 헤드리스 모드 설정
6. ✅ 세션 관리 숙달

---

## 키워드 검색

### 성능
- `01-slash-commands/optimize.md` — 성능 분석
- `04-subagents/code-reviewer.md` — 성능 리뷰
- `03-skills/code-review-specialist/` — 성능 메트릭
- `07-plugins/pr-review/agents/performance-analyzer.md` — 성능 전문가

### 보안
- `04-subagents/secure-reviewer.md` — 보안 리뷰
- `03-skills/code-review-specialist/` — 보안 분석
- `07-plugins/pr-review/` — 보안 점검

### 테스트
- `04-subagents/test-engineer.md` — 테스트 엔지니어
- `07-plugins/pr-review/commands/check-tests.md` — 테스트 커버리지

### 문서
- `01-slash-commands/generate-api-docs.md` — API 문서 명령어
- `04-subagents/documentation-writer.md` — 문서 작성 에이전트
- `03-skills/doc-generator/` — 문서 생성 스킬
- `07-plugins/documentation/` — 완전한 문서 플러그인

### 배포
- `07-plugins/devops-automation/` — 완전한 DevOps 솔루션

### 자동화
- `06-hooks/` — 이벤트 기반 자동화
- `06-hooks/pre-commit.sh` — 커밋 전 자동화
- `06-hooks/format-code.sh` — 자동 포매팅
- `09-advanced-features/` — CI/CD를 위한 헤드리스 모드

### 검증
- `06-hooks/security-scan.sh` — 보안 검증
- `06-hooks/validate-prompt.sh` — 프롬프트 검증

### 실험
- `08-checkpoints/` — 되감기를 이용한 안전한 실험
- `08-checkpoints/checkpoint-examples.md` — 실용 예제

### 플래닝
- `09-advanced-features/planning-mode-examples.md` — 플랜 모드 예시
- `09-advanced-features/README.md` — 확장 사고

### 설정
- `09-advanced-features/config-examples.json` — 설정 예시

---

## 참고 사항

- 모든 예제는 그대로 사용할 수 있습니다
- 자신의 필요에 맞게 수정하세요
- 예제는 Claude Code 모범 사례를 따릅니다
- 각 카테고리에는 상세 절차가 담긴 자체 README가 있습니다
- 스크립트에는 적절한 오류 처리가 포함되어 있습니다
- 템플릿은 사용자 지정이 가능합니다

---

## 기여하기

예제를 추가하려면 다음 구조를 따르세요:
1. 적절한 하위 디렉터리 생성
2. 사용 방법이 담긴 README.md 포함
3. 명명 규칙 준수
4. 꼼꼼히 테스트
5. 이 색인 업데이트

---

**최종 업데이트**: 2026년 10월 18일
**Claude Code 버전**: 2.1.302
**호환 모델**: Claude Sonnet 4.6, Claude Opus 4.7, Claude Haiku 4.5
**예제 총수**: 100개 파일 이상
**카테고리**: 10개 기능
**훅**: 자동화 스크립트 8개
**설정 예시**: 10개 시나리오 이상
**바로 사용 가능**: 모든 예제
**정보 출처**:
- https://code.claude.com/docs/en/tools-reference#task-tool-availability
- https://code.claude.com/docs/en/overview
- https://code.claude.com/docs/en/hooks
- https://code.claude.com/docs/en/commands
- https://github.com/anthropics/claude-code/releases/tag/v2.1.119
- https://code.claude.com/docs/en/cli-reference
- https://code.claude.com/docs/en/remote-control
- https://code.claude.com/docs/en/chrome
- https://code.claude.com/docs/en/plugins/install
- https://code.claude.com/docs/en/checkpointing
- https://code.claude.com/docs/en/permission-modes
