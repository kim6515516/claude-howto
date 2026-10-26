<!-- i18n-source: CLAUDE.md -->
<!-- i18n-source-sha: a70777e -->
<!-- i18n-date: 2026-10-26 -->

# CLAUDE.md

이 파일은 이 저장소의 코드를 다룰 때 Claude Code(claude.ai/code)가 참고하는 가이드입니다.

## 프로젝트 개요

Claude How To는 Claude Code 기능을 다루는 튜토리얼 저장소입니다. 이 프로젝트는 **문서 애즈 코드(Documentation as Code)**이며, 주요 산출물은 실행 가능한 애플리케이션이 아니라 번호가 붙은 학습 모듈로 정리된 Markdown 파일입니다.

**아키텍처:** 각 모듈(01~10)은 Claude Code의 특정 기능을 복사 & 붙여넣기 가능한 템플릿, Mermaid 다이어그램, 예시와 함께 설명합니다. 빌드 시스템은 문서 품질을 검증하고 EPUB 전자책을 생성합니다.

## 자주 쓰는 명령어

### pre-commit 품질 검사

모든 문서는 커밋 전에 5가지 품질 검사를 통과해야 합니다(pre-commit 훅으로 자동 실행됩니다):

```bash
# pre-commit 훅 설치(매 커밋마다 실행)
pre-commit install

# 모든 검사를 수동으로 실행
pre-commit run --all-files
```

5가지 검사는 다음과 같습니다:
1. **markdown-lint** — `markdownlint`를 이용한 Markdown 구조와 서식 검사
2. **cross-references** — 내부 링크, 앵커, 코드 펜스 문법(Python 스크립트)
3. **mermaid-syntax** — 모든 Mermaid 다이어그램이 올바르게 파싱되는지 검증(Python 스크립트)
4. **link-check** — 외부 URL 도달 가능 여부(Python 스크립트)
5. **markdown-rendering** — Markdown이 깨지지 않고 렌더링되는지(Python 스크립트)

EPUB 빌드는 pre-commit 훅이 **아닙니다** — CI에서만 실행됩니다(`.github/workflows/test.yml`의 `build-epub` 잡). 책 전체를 빌드하기 때문에 시간이 오래 걸리기 때문입니다. mermaid-syntax 훅이 같은 Pele 번들로 모든 다이어그램을 이미 렌더링합니다.

### 개발 환경 설정

```bash
# uv(Python 패키지 관리자) 설치
pip install uv

# 가상 환경을 만들고 Python 의존성 설치
uv venv
source .venv/bin/activate
uv pip install -r scripts/requirements-dev.txt

# Node.js 도구(Markdown 린터) 설치
npm install -g markdownlint-cli

# Mermaid 다이어그램은 Pele로 렌더링합니다(Node.js >= 20 필요. 전역 설치는 불필요)
node --version

# pre-commit 훅 설치
uv pip install pre-commit
pre-commit install
```

### 테스트

`scripts/` 안의 Python 스크립트에는 단위 테스트가 있습니다:

```bash
# 모든 테스트 실행
pytest scripts/tests/ -v

# 커버리지와 함께 실행
pytest scripts/tests/ -v --cov=scripts --cov-report=html

# 특정 테스트 실행
pytest scripts/tests/test_build_epub.py -v
```

### 코드 품질

```bash
# Python 코드 린트·포맷
ruff check scripts/
ruff format scripts/

# 보안 스캔
bandit -c scripts/pyproject.toml -r scripts/ --exclude scripts/tests/

# 타입 검사
mypy scripts/ --ignore-missing-imports
```

### EPUB 빌드

```bash
# 전자책 생성(Mermaid 다이어그램은 Pele로 렌더링/Node.js >= 20 필요. 고정 번들은 최초 1회만 다운로드)
uv run scripts/build_epub.py

# 옵션 지정
uv run scripts/build_epub.py --verbose --output custom-name.epub --lang ko
```

## 디렉터리 구조

```
├── 01-slash-commands/      # 사용자가 실행하는 단축 명령
├── 02-memory/              # 영속 컨텍스트 예시
├── 03-skills/              # 재사용 가능한 능력
├── 04-subagents/           # 전문 AI 어시스턴트
├── 05-mcp/                 # Model Context Protocol 예시
├── 06-hooks/               # 이벤트 기반 자동화
├── 07-plugins/             # 번들 기능
├── 08-checkpoints/         # 세션 스냅샷
├── 09-advanced-features/   # 플래닝, 싱킹, 백그라운드
├── 10-cli/                 # CLI 레퍼런스
├── scripts/
│   ├── build_epub.py           # EPUB 생성기(Mermaid를 Pele로 렌더링)
│   ├── check_cross_references.py   # 내부 링크 검증
│   ├── check_links.py          # 외부 URL 검증
│   ├── check_mermaid.py        # Mermaid 문법 검증
│   └── tests/                  # 스크립트 단위 테스트
├── .pre-commit-config.yaml    # 품질 검사 정의
└── README.md               # 메인 가이드(모듈 색인 겸용)
```

## 콘텐츠 작성 가이드

### 모듈 구조
번호가 붙은 폴더는 모두 다음 패턴을 따릅니다:
- **README.md** — 기능 개요와 예시
- **예시 파일** — 복사 & 붙여넣기 가능한 템플릿(명령어는 `.md`, 설정은 `.json`, 훅은 `.sh`)
- 파일은 기능의 복잡도와 의존 관계에 따라 정리되어 있습니다

### Mermaid 다이어그램
- 모든 다이어그램은 정상적으로 파싱되어야 합니다(pre-commit 훅으로 검사)
- EPUB 빌드는 Pele로 다이어그램을 렌더링합니다(Node.js >= 20 필요. 고정 번들은 최초 1회만 다운로드되고 이후에는 오프라인으로 동작합니다)
- 플로차트, 시퀀스 다이어그램, 아키텍처 시각화에 Mermaid를 사용합니다

### 상호 참조
- 내부 링크는 상대 경로를 사용합니다(예: `(01-slash-commands/README.md)`)
- 코드 펜스는 언어 지정이 필수입니다(예: ` ```bash `, ` ```python `)
- 앵커 링크는 `#heading-name` 형식

### 링크 검증
- 외부 URL은 도달 가능해야 합니다(pre-commit 훅으로 검사)
- 일시적인 콘텐츠로의 링크는 피합니다
- 가능한 한 퍼머링크를 사용합니다

## 핵심 아키텍처 포인트

1. **번호가 붙은 폴더는 학습 순서를 나타냅니다** — 01~10 접두사는 Claude Code 기능의 권장 학습 순서를 뜻합니다. 이 번호 체계는 의도적인 것이므로 알파벳순으로 재배열해서는 안 됩니다.

2. **스크립트는 유틸리티이지 제품이 아닙니다** — `scripts/`의 Python 스크립트는 문서 품질과 EPUB 생성을 돕는 도구입니다. 실제 콘텐츠는 번호가 붙은 모듈 폴더에 있습니다.

3. **pre-commit이 게이트키퍼입니다** — PR이 승인되기 전에 5가지 품질 검사를 모두 통과해야 합니다. CI 파이프라인은 같은 검사를 두 번째 패스로 실행합니다.

4. **Mermaid 렌더링에는 Node.js >= 20이 필요합니다** — EPUB 빌드는 고정 버전의 Pele 번들을 Node.js로 실행해 다이어그램을 렌더링합니다(번들은 최초 1회만 다운로드되며 sha256으로 검증한 뒤 캐시됩니다). 여기서 빌드가 실패한다면 Node.js >= 20 미설치, 번들 다운로드 실패, Mermaid 문법 오류가 전형적인 원인입니다. pre-commit의 mermaid 훅은 pre-commit이 준비하는 Node.js 22로 엄격 모드에서 실행되며, 건너뛰지 않고 실패합니다. EPUB 빌드 자체는 pre-commit에서 실행되지 않고 CI에서만 실행됩니다.

5. **이것은 튜토리얼이지 라이브러리가 아닙니다** — 콘텐츠를 추가할 때는 명쾌한 설명, 복사 & 붙여넣기 가능한 예시, 시각적인 다이어그램을 중시합니다. 가치는 개념을 가르치는 데 있지 재사용 가능한 코드를 제공하는 데 있지 않습니다.

## 커밋 규약

Conventional Commits 형식을 따릅니다:
- `feat(slash-commands): Add API documentation generator`
- `docs(memory): Improve personal preferences example`
- `fix(README): Correct table of contents link`
- `refactor(hooks): Simplify hook configuration examples`

스코프는 해당 폴더명에 맞춥니다.
