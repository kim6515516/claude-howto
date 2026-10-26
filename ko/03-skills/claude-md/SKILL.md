<!-- i18n-source: 03-skills/claude-md/SKILL.md -->
<!-- i18n-source-sha: f78c094 -->
<!-- i18n-date: 2026-10-26 -->
---
name: claude-md
description: Create or update CLAUDE.md files following best practices for optimal AI agent onboarding
---

## 사용자 입력

```text
$ARGUMENTS
```

사용자 입력이 비어 있지 않다면, 진행하기 전에 **반드시** 그 내용을 고려해야 합니다. 사용자는 다음을 지정할 수 있습니다:
- `create` - 새 CLAUDE.md를 처음부터 작성
- `update` - 기존 CLAUDE.md를 개선
- `audit` - 현재 CLAUDE.md의 품질을 분석하고 보고
- 작성·갱신할 구체적인 경로(예: 디렉터리별 지시를 위한 `src/api/CLAUDE.md`)

## 기본 원칙

**LLM은 상태를 유지하지 않습니다**: CLAUDE.md는 모든 대화에 로드되는 주요 프로젝트 파일입니다(자동 메모리, 범위 없는 규칙과 함께 로드됩니다). 코드베이스에 대한 AI 에이전트의 주요 온보딩 문서 역할을 합니다.

### 황금률

1. **적을수록 좋습니다**: 프런티어 LLM은 약 150~200개의 지시를 따를 수 있습니다. Claude Code의 시스템 프롬프트가 이미 약 50개를 사용합니다. CLAUDE.md는 초점을 좁히고 간결하게 유지해야 합니다.

2. **보편적 적용성**: 모든 세션에 관련된 정보만 포함합니다. 작업별 지시는 별도 파일에 둡니다.

3. **Claude를 린터로 쓰지 않습니다**: 스타일 가이드라인은 컨텍스트를 부풀리고 지시 준수율을 떨어뜨립니다. 대신 결정론적인 도구(prettier, eslint 등)를 사용합니다.

4. **절대 자동 생성하지 않습니다**: CLAUDE.md는 AI 하네스에서 가장 영향력이 큰 지점입니다. 신중하게 손으로 다듬어야 합니다.

## 실행 흐름

### 1. 프로젝트 분석

먼저 현재 프로젝트 상태를 분석합니다:

1. 기존 CLAUDE.md 파일 확인:
   - 루트 수준: `./CLAUDE.md` 또는 `.claude/CLAUDE.md`
   - 디렉터리별: `**/CLAUDE.md`
   - 전역 사용자 설정: `~/.claude/CLAUDE.md`

2. 프로젝트 구조 파악:
   - 기술 스택(언어, 프레임워크)
   - 프로젝트 유형(모노레포, 단일 앱, 라이브러리)
   - 개발 도구(패키지 매니저, 빌드 시스템, 테스트 러너)

3. 기존 문서 검토:
   - README.md
   - CONTRIBUTING.md
   - package.json, pyproject.toml, Cargo.toml 등

### 2. 콘텐츠 전략(WHAT, WHY, HOW)

CLAUDE.md를 세 가지 관점으로 구성합니다:

#### WHAT - 기술과 구조
- 기술 스택 개요
- 프로젝트 구성(모노레포에서 특히 중요)
- 주요 디렉터리와 그 목적

#### WHY - 목적과 배경
- 프로젝트가 하는 일
- 특정 설계 결정을 내린 이유
- 각 주요 컴포넌트가 담당하는 것

#### HOW - 워크플로와 규약
- 개발 워크플로(bun과 node, pip과 uv 등)
- 테스트 절차와 명령어
- 검증 및 빌드 수단
- 중요한 "함정"이나 명시되지 않은 요구 사항

### 3. 점진적 공개 전략

대규모 프로젝트에서는 `agent_docs/` 폴더 생성을 권장합니다:

```
agent_docs/
  |- building_the_project.md
  |- running_tests.md
  |- code_conventions.md
  |- architecture_decisions.md
```

CLAUDE.md에서는 다음과 같은 지시로 이 파일들을 참조합니다:
```markdown
For detailed build instructions, refer to `agent_docs/building_the_project.md`
```

**중요**: 오래되어 낡은 컨텍스트를 피하려면 코드 스니펫 대신 `file:line` 참조를 사용합니다.

### 4. 품질 제약

CLAUDE.md를 작성·갱신할 때:

1. **목표 길이**: 200줄 미만
2. **스타일 규칙 없음**: lint나 포맷 지시는 제외
3. **작업별 지시 없음**: 별도 파일로 옮김
4. **코드 스니펫 없음**: 파일 참조를 사용
5. **중복 정보 없음**: package.json이나 README에 있는 내용을 반복하지 않음

### 5. 필수 섹션

잘 구성된 CLAUDE.md에는 다음이 포함되어야 합니다:

```markdown
# Project Name

Brief one-line description.

## Tech Stack
- Primary language and version
- Key frameworks/libraries
- Database/storage (if any)

## Project Structure
[Only for monorepos or complex structures]
- `apps/` - Application entry points
- `packages/` - Shared libraries

## Development Commands
- Install: `command`
- Test: `command`
- Build: `command`

## Critical Conventions
[Only non-obvious, high-impact conventions]
- Convention 1 with brief explanation
- Convention 2 with brief explanation

## Known Issues / Gotchas
[Things that consistently trip up developers]
- Issue 1
- Issue 2
```

### 6. 피해야 할 안티패턴

**포함하면 안 되는 것:**
- 코드 스타일 가이드라인(린터를 사용)
- Claude 사용법에 관한 문서
- 자명한 패턴에 대한 긴 설명
- 복사해 붙여 넣은 코드 예시
- 일반적인 모범 사례("write clean code")
- 특정 작업을 위한 지시
- 자동 생성된 내용
- 대량의 TODO 목록

### 7. 검증 체크리스트

최종 확정 전에 확인:

- [ ] 200줄 미만
- [ ] 모든 줄이 모든 세션에 적용된다
- [ ] 스타일이나 포맷 규칙이 없다
- [ ] 코드 스니펫이 없다(파일 참조를 사용)
- [ ] 명령어가 동작함을 검증했다
- [ ] 복잡한 프로젝트에서 점진적 공개를 활용한다
- [ ] 중요한 함정이 문서화되어 있다
- [ ] README.md와 내용이 중복되지 않는다

## 출력 형식

### `create` 또는 기본값인 경우:

1. 프로젝트를 분석합니다
2. 위 구조에 따라 CLAUDE.md 초안을 작성합니다
3. 초안을 검토용으로 제시합니다
4. 승인 후 적절한 위치에 기록합니다

### `update`인 경우:

1. 기존 CLAUDE.md를 읽습니다
2. 모범 사례에 비추어 감사합니다
3. 다음을 식별합니다:
   - 삭제할 내용(스타일 규칙, 코드 스니펫, 작업별 지시)
   - 압축할 내용
   - 누락된 필수 정보
4. 변경 내용을 검토용으로 제시합니다
5. 승인 후 변경을 적용합니다

### `audit`인 경우:

1. 기존 CLAUDE.md를 읽습니다
2. 다음을 포함한 보고서를 생성합니다:
   - 현재 줄 수와 목표값
   - 보편적으로 적용 가능한 콘텐츠의 비율
   - 감지된 안티패턴 목록
   - 개선을 위한 권장 사항
3. 파일을 변경하지 않고 보고만 합니다

## AGENTS.md 취급

사용자가 AGENTS.md 작성·갱신을 요청한 경우:

**v2.1.277부터 Claude Code는 `AGENTS.md`를 프로젝트 지시로 직접 읽어 들입니다.** 단, 작업 디렉터리와 그 상위 모든 디렉터리에 `CLAUDE.md`, `.claude/CLAUDE.md`, `CLAUDE.local.md` 중 어느 것도 존재하지 않는 경우에 한합니다. `~/.claude/CLAUDE.md`, 관리형 CLAUDE.md, `.claude/rules/`는 이 판정 대상이 아니며 계속 함께 로드됩니다. 이 동작은 `/config`의 **Project instructions**에서 제어합니다: `claude-md-or-agents-md`(기본값), `claude-md-and-agents-md`, `claude-md`, `managed-only`. 직접 로드를 사용할 수 없는 환경 — v2.1.277 이전 버전(Bedrock/Vertex/Foundry, LLM 게이트웨이, 텔레메트리 비활성화 시에는 v2.1.281 이전), 또는 업그레이드 후 첫 세션 — 에서는 CLAUDE.md에서 `@AGENTS.md`로 임포트하거나 `CLAUDE.md`를 이 파일로의 심볼릭 링크로 만드는 폴백을 사용합니다.

AGENTS.md는 도구를 가로지르는 프로젝트 컨텍스트 파일로, CLAUDE.md와 같은 *종류*의 문서입니다. 에이전트 정의 형식이 아닙니다. 여러 코딩 에이전트가 하나의 프로젝트 규약을 공유할 수 있도록 존재합니다:
- 빌드, 테스트, 린트 명령어
- 코드 스타일과 아키텍처 규약
- 저장소 구성과 각 요소의 위치

서브에이전트는 AGENTS.md가 아니라 `.claude/agents/*.md`에서 별도로 정의합니다.

같은 원칙을 적용합니다:
- 초점을 좁히고 간결하게 유지
- 점진적 공개를 활용
- 내용을 삽입하는 대신 외부 문서를 참조

## 주의 사항

- 명령어를 포함하기 전에 반드시 동작을 확인합니다
- 망설여지면 생략합니다. 적을수록 좋습니다
- 시스템 리마인더는 Claude에게 CLAUDE.md가 "관련이 있을 수도, 없을 수도 있다"고 알립니다. 노이즈가 많을수록 무시되기 쉽습니다
- 모노레포는 명확한 WHAT/WHY/HOW 구조의 이점이 가장 큽니다
- 디렉터리별 CLAUDE.md 파일은 초점을 더욱 좁혀야 합니다

---

**최종 업데이트**: 2026년 10월 18일
**Claude Code 버전**: 2.1.302
**Sources**:
- https://code.claude.com/docs/en/memory
