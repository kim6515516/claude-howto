<!-- i18n-source: CONTRIBUTING.md -->
<!-- i18n-source-sha: 7f2e773 -->
<!-- i18n-date: 2026-10-26 -->

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

# Claude How To에 기여하기

이 프로젝트에 기여하는 데 관심을 가져 주셔서 감사합니다! 이 가이드는 효과적으로 기여하는 방법을 이해하는 데 도움이 됩니다.

## 이 프로젝트에 대하여

Claude How To는 Claude Code에 대한 시각적이고 예제 중심의 가이드입니다. 제공하는 내용:
- 기능의 동작을 설명하는 **Mermaid 다이어그램**
- 바로 사용할 수 있는 **프로덕션 품질의 템플릿**
- 맥락과 모범 사례를 곁들인 **실제 사례**
- 초보자부터 고급 사용자까지의 **단계별 학습 경로**

## 기여의 종류

### 1. 새 예제나 템플릿
기존 기능(슬래시 명령어, 스킬, 훅 등)의 예제를 추가합니다:
- 복사해 붙여 넣을 수 있는 코드
- 동작에 대한 명확한 설명
- 사용 사례와 이점
- 문제 해결 팁

### 2. 문서 개선
- 이해하기 어려운 부분의 명확화
- 오타와 문법 수정
- 누락된 정보 추가
- 코드 예제 개선

### 3. 기능 가이드
새로운 Claude Code 기능의 가이드를 작성합니다:
- 단계별 튜토리얼
- 아키텍처 다이어그램
- 일반적인 패턴과 안티패턴
- 실제 워크플로

### 4. 버그 보고
겪은 문제를 보고합니다:
- 기대한 동작 기술
- 실제 동작 기술
- 재현 절차 포함
- 관련 Claude Code 버전과 OS 추가

### 5. 피드백과 제안
가이드 개선을 돕습니다:
- 더 나은 설명 제안
- 누락된 부분 지적
- 새 섹션이나 재구성 권장

## 시작하기

### 1. 포크와 클론
```bash
git clone https://github.com/luongnv89/claude-howto.git
cd claude-howto
```

### 2. 브랜치 만들기
알기 쉬운 브랜치 이름을 사용합니다:
```bash
git checkout -b add/feature-name
git checkout -b fix/issue-description
git checkout -b docs/improvement-area
```

### 3. 환경 설정

pre-commit 훅은 각 커밋 전에 CI와 같은 검사를 로컬에서 실행합니다. 5가지 검사가 모두 통과해야 PR이 수락됩니다.

**필수 의존성:**

```bash
# Python 도구(이 프로젝트의 패키지 매니저는 uv)
pip install uv
uv venv
source .venv/bin/activate
uv pip install -r scripts/requirements-dev.txt

# Markdown 린터(Node.js)
npm install -g markdownlint-cli

# Mermaid 다이어그램은 Pele로 렌더링합니다. Node.js >= 20이 필요합니다(전역으로
# 설치할 것은 없습니다). 버전을 확인합니다:
node --version

# pre-commit을 설치하고 훅을 활성화
uv pip install pre-commit
pre-commit install
```

**설정 확인:**

```bash
pre-commit run --all-files
```

첫 실행에서는 Mermaid 훅용 Node.js 22(pre-commit이 준비하므로 시스템에 Node.js가 없어도 동작합니다)와 고정 버전의 Pele 번들이 `scripts/.vendor-cache/pele/`에 다운로드됩니다. 이후 실행은 오프라인으로 동작합니다. Mermaid 훅은 엄격 모드로 실행되며 Pele를 실행할 수 없으면 실패합니다. 첫 다운로드 전에 오프라인으로 커밋하려면 `SKIP=mermaid,vietnamese-mermaid,japanese-mermaid`로 건너뜁니다.

각 커밋에서 실행되는 훅은 다음과 같습니다:

| 훅 | 검사 내용 |
|------|---------------|
| `markdown-lint` | Markdown 형식과 구조 |
| `cross-references` | 상대 링크, 앵커, 코드 펜스 |
| `mermaid-syntax` | 모든 ` ```mermaid ` 블록이 올바르게 파싱되는지 |
| `link-check` | 외부 URL에 도달 가능한지 |
| `build-epub` | EPUB이 오류 없이 생성되는지(`.md` 변경 시) |

## 디렉터리 구조

```
├── 01-slash-commands/      # 사용자가 실행하는 단축 명령
├── 02-memory/              # 영속 컨텍스트 예제
├── 03-skills/              # 재사용 가능한 능력
├── 04-subagents/           # 전문 AI 어시스턴트
├── 05-mcp/                 # Model Context Protocol 예제
├── 06-hooks/               # 이벤트 기반 자동화
├── 07-plugins/             # 번들 기능
├── 08-checkpoints/         # 세션 스냅샷
├── 09-advanced-features/   # 플래닝, 싱킹, 백그라운드
├── 10-cli/                 # CLI 레퍼런스
├── scripts/                # 빌드 및 유틸리티 스크립트
└── README.md               # 메인 가이드
```

## 예제를 기여하는 방법

### 슬래시 명령어 추가
1. `01-slash-commands/`에 `.md` 파일 생성
2. 다음을 포함:
   - 무엇을 하는지에 대한 명확한 설명
   - 사용 사례
   - 설치 절차
   - 사용 예시
   - 커스터마이즈 팁
3. `01-slash-commands/README.md` 갱신

### 스킬 추가
1. `03-skills/`에 디렉터리 생성
2. 다음을 포함:
   - `SKILL.md` — 메인 문서
   - `scripts/` — 필요에 따라 헬퍼 스크립트
   - `templates/` — 프롬프트 템플릿
   - README에 사용 예시
3. `03-skills/README.md` 갱신

### 서브에이전트 추가
1. `04-subagents/`에 `.md` 파일 생성
2. 다음을 포함:
   - 에이전트의 목적과 능력
   - 시스템 프롬프트 구조
   - 사용 사례 예시
   - 통합 예시
3. `04-subagents/README.md` 갱신

### MCP 설정 추가
1. `05-mcp/`에 `.json` 파일 생성
2. 다음을 포함:
   - 설정 설명
   - 필요한 환경 변수
   - 설정 절차
   - 사용 예시
3. `05-mcp/README.md` 갱신

### 훅 추가
1. `06-hooks/`에 `.sh` 파일 생성
2. 다음을 포함:
   - 셔뱅과 설명
   - 로직을 설명하는 명확한 주석
   - 오류 처리
   - 보안 고려 사항
3. `06-hooks/README.md` 갱신

## 작성 가이드라인

### Markdown 스타일
- 명확한 제목(섹션은 H2, 하위 섹션은 H3)
- 문단은 짧고 초점을 좁혀 유지
- 목록에는 글머리 기호 사용
- 코드 블록에는 언어 지정 포함
- 섹션 사이에 빈 줄 삽입

### 코드 예제
- 예제는 복사해 붙여 넣으면 동작하게 작성
- 자명하지 않은 로직에는 주석 추가
- 단순 버전과 고급 버전을 모두 포함
- 실제 사용 사례 제시
- 잠재적인 문제점 강조

### 문서
- "무엇을"뿐 아니라 "왜"를 설명
- 사전 요구 사항 포함
- 문제 해결 추가
- 관련 주제로 링크
- 초보자 친화적으로 유지

### JSON/YAML
- 적절한 들여쓰기 사용(2칸 또는 4칸으로 일관되게)
- 설정을 설명하는 주석 추가
- 검증 예시 포함

### 다이어그램
- 가능하면 Mermaid 사용
- 다이어그램은 단순하고 읽기 쉽게 유지
- 다이어그램 아래에 설명 포함
- 관련 섹션으로 링크

## 커밋 가이드라인

Conventional Commits 형식을 따릅니다:
```
type(scope): description

[optional body]
```

유형:
- `feat`: 새 기능이나 새 예제
- `fix`: 버그 수정이나 정정
- `docs`: 문서 변경
- `refactor`: 코드 재구성
- `style`: 형식 변경
- `test`: 테스트 추가·변경
- `chore`: 빌드, 의존성 등

예시:
```
feat(slash-commands): Add API documentation generator
docs(memory): Improve personal preferences example
fix(README): Correct table of contents link
docs(skills): Add comprehensive code review skill
```

## 제출 전

### 체크리스트
- [ ] 코드가 프로젝트의 스타일과 규약을 따른다
- [ ] 새 예제에 명확한 문서가 포함되어 있다
- [ ] README 파일(로컬과 루트)이 갱신되어 있다
- [ ] 민감한 정보(API 키, 자격 증명)가 포함되어 있지 않다
- [ ] 예제가 테스트되었고 동작한다
- [ ] 링크가 검증되었고 올바르다
- [ ] 파일 권한이 적절하다(스크립트는 실행 가능)
- [ ] 커밋 메시지가 명확하고 설명적이다

### 로컬 테스트
```bash
# 모든 pre-commit 검사 실행(CI와 같은 검사)
pre-commit run --all-files

# 변경 내용 검토
git diff
```

## 풀 리퀘스트 프로세스

1. **명확한 설명과 함께 PR 생성:**
   - 무엇을 추가/수정하는가?
   - 왜 필요한가?
   - 관련 이슈(있다면)

2. **관련 세부 사항 포함:**
   - 새 기능의 경우: 사용 사례 포함
   - 문서의 경우: 개선점 설명
   - 예제의 경우: 변경 전/후 제시

3. **이슈에 링크:**
   - `Closes #123`을 사용하면 관련 이슈가 자동으로 닫힙니다

4. **리뷰를 인내심 있게 기다리기:**
   - 메인테이너가 개선을 제안할 수 있습니다
   - 피드백에 따라 반복합니다
   - 최종 판단은 메인테이너가 내립니다

## 코드 리뷰 프로세스

리뷰어는 다음을 확인합니다:
- **정확성:** 설명대로 동작하는가?
- **품질:** 프로덕션 품질인가?
- **일관성:** 프로젝트의 패턴을 따르는가?
- **문서:** 명확하고 완전한가?
- **보안:** 취약점은 없는가?

## 이슈 보고

### 버그 보고
다음을 포함합니다:
- Claude Code 버전
- 운영 체제
- 재현 절차
- 기대 동작
- 실제 동작
- 해당하는 경우 스크린샷

### 기능 요청
다음을 포함합니다:
- 사용 사례 또는 해결하려는 문제
- 제안하는 해결책
- 검토한 대안
- 추가 컨텍스트

### 문서 문제
다음을 포함합니다:
- 이해하기 어렵거나 누락된 부분
- 개선안
- 예시 또는 참고 자료

## 프로젝트 정책

### 민감한 정보
- API 키, 토큰, 자격 증명을 절대 커밋하지 않습니다
- 예제에서는 플레이스홀더 값을 사용합니다
- 설정 파일에는 `.env.example`을 포함합니다
- 필요한 환경 변수를 문서화합니다

### 코드 품질
- 예제는 초점을 좁히고 읽기 쉽게 유지합니다
- 과잉 설계를 피합니다
- 자명하지 않은 로직에는 주석을 포함합니다
- 제출 전에 충분히 테스트합니다

### 지적 재산
- 오리지널 콘텐츠의 소유권은 저자에게 있습니다
- 프로젝트는 교육용 라이선스를 사용합니다
- 기존 저작권을 존중합니다
- 필요에 따라 출처를 표기합니다

## 도움 받기

- **질문:** GitHub Issues에서 토론을 엽니다
- **일반적인 도움:** 기존 문서를 확인합니다
- **개발 도움:** 유사한 예제를 검토합니다
- **코드 리뷰:** PR에서 메인테이너를 태그합니다

## 감사의 말

기여자는 다음에서 인정받습니다:
- README.md의 기여자 섹션
- GitHub의 기여자 페이지
- 커밋 이력

## 보안

예제나 문서를 기여할 때는 안전한 코딩 관행을 따라 주세요:

- **시크릿이나 API 키를 하드코딩하지 않기** — 환경 변수를 사용합니다
- **보안 영향 경고하기** — 잠재적 위험을 강조합니다
- **안전한 기본값 사용하기** — 보안 기능을 기본으로 활성화합니다
- **입력 검증하기** — 적절한 입력 검증과 정제를 보여 줍니다
- **보안 관련 주의 사항 포함하기** — 보안 고려 사항을 문서화합니다

보안 문제에 대해서는 취약점 보고 절차를 다룬 [SECURITY.md](SECURITY.md)를 참고하세요.

## 행동 강령

우리는 따뜻하고 포용적인 커뮤니티를 제공하는 데 전념합니다. 커뮤니티 기준의 자세한 내용은 [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)를 읽어 주세요.

요점:
- 존중하고 포용적일 것
- 피드백을 기꺼이 받아들일 것
- 다른 사람의 배움과 성장을 도울 것
- 괴롭힘과 차별을 피할 것
- 문제는 메인테이너에게 보고할 것

모든 기여자는 이 강령을 준수하고 서로를 친절과 존중으로 대해야 합니다.

## 라이선스

이 프로젝트에 기여하면 기여 내용이 MIT License에 따라 라이선스되는 데 동의하는 것으로 간주합니다. 자세한 내용은 [LICENSE](../LICENSE)를 참고하세요.

## 질문이 있나요?

- [README](README.md) 확인
- [LEARNING-ROADMAP.md](LEARNING-ROADMAP.md) 검토
- 기존 예제 참고
- 토론을 위해 이슈 열기

기여해 주셔서 감사합니다! 🙏

---
**Last Updated**: April 9, 2026
