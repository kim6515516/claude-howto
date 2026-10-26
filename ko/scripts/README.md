<!-- i18n-source: scripts/README.md -->
<!-- i18n-source-sha: 58e586f -->
<!-- i18n-date: 2026-10-26 -->
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../../resources/logos/claude-howto-logo.svg">
</picture>

# EPUB 빌더 스크립트

Claude How-To의 Markdown 파일들로 EPUB 형식의 전자책을 빌드하는 스크립트입니다.

## 특징

- 폴더 구조(01-slash-commands, 02-memory 등)에 따라 장을 정리합니다
- Mermaid 다이어그램을 [Pele](https://github.com/obsidianmd/pele) (Node.js로 실행하는 고정 버전 번들)로 SVG 이미지로 렌더링합니다. CSS 변수는 흰 배경 위의 일반 색상으로 치환하므로 어떤 EPUB 리더에서도 표시됩니다
- 동일한 다이어그램은 캐시하고, 고유한 다이어그램은 한 번만 렌더링합니다
- 프로젝트 로고로 표지 이미지를 생성합니다
- 내부 Markdown 링크를 EPUB 장 참조로 변환합니다
- 엄격 모드 — 렌더링할 수 없는 다이어그램이 있으면 빌드를 실패시킵니다

## 필요 환경

- Python 3.10+
- [uv](https://github.com/astral-sh/uv)
- Mermaid 다이어그램 렌더링용으로 `PATH`에 있는 Node.js >= 20. 고정 버전 Pele 번들은 첫 실행 시 다운로드되며(네트워크가 필요한 것은 한 번뿐), sha256으로 검증해 `scripts/.vendor-cache/pele/`에 캐시됩니다

## 빠른 시작

```bash
# 가장 간단한 방법 — uv가 모든 것을 처리합니다
uv run scripts/build_epub.py
```

## 개발 환경 설정

```bash
# 가상 환경 생성
uv venv

# 활성화하고 의존성 설치
source .venv/bin/activate
uv pip install -r requirements-dev.txt

# 테스트 실행
pytest scripts/tests/ -v

# 스크립트 실행
python scripts/build_epub.py
```

## 명령줄 옵션

```
usage: build_epub.py [-h] [--root ROOT] [--output OUTPUT] [--verbose]
                     [--lang {en,vi,zh,ja}]

options:
  -h, --help            show this help message and exit
  --root, -r ROOT       Root directory (default: repo root)
  --output, -o OUTPUT   Output path (default: claude-howto-guide.epub)
  --verbose, -v         Enable verbose logging
  --lang {en,vi,zh,ja}  Language to build (default: en)
```

## 사용 예

```bash
# 상세 로그와 함께 빌드
uv run scripts/build_epub.py --verbose

# 출력 경로 지정
uv run scripts/build_epub.py --output ~/Desktop/claude-guide.epub

# 한국어판 빌드
uv run scripts/build_epub.py --lang ko
```

## 출력

저장소 루트 디렉터리에 `claude-howto-guide.epub`을 생성합니다.

EPUB에는 다음이 포함됩니다:
- 프로젝트 로고가 들어간 표지 이미지
- 중첩된 목차
- 모든 Markdown 콘텐츠를 EPUB 호환 HTML로 변환한 것
- SVG 이미지로 렌더링된 Mermaid 다이어그램

## 테스트 실행

```bash
# 가상 환경을 사용하는 경우
source .venv/bin/activate
pytest scripts/tests/ -v

# 또는 uv로 직접 실행
uv run --with pytest --with pytest-asyncio \
    --with ebooklib --with markdown --with beautifulsoup4 \
    --with pillow \
    pytest scripts/tests/ -v
```

## 의존성

PEP 723 인라인 스크립트 메타데이터로 관리합니다:

| 패키지 | 용도 |
|---------|---------|
| `ebooklib` | EPUB 생성 |
| `markdown` | Markdown에서 HTML로 변환 |
| `beautifulsoup4` | HTML 파싱 |
| `pillow` | 표지 이미지 생성 |

## 문제 해결

**`Pele is unavailable`로 빌드가 실패함**: Node.js >= 20을 설치하고 `node`가 `PATH`에 있는지 확인합니다(`node --version`).

**Pele 번들 다운로드 또는 체크섬 실패**: 첫 빌드는 고정 버전 Pele 번들을 cdn.jsdelivr.net에서 다운로드하고 각 파일의 sha256을 검증합니다. 오프라인이나 프록시 환경에서는 네트워크에 연결된 상태로 한 번 빌드하면 이후에는 `scripts/.vendor-cache/pele/<version>/`의 캐시를 사용합니다. 체크섬 불일치는 다운로드가 변조되었거나 중간에 끊겼다는 뜻이므로, 해당 폴더를 삭제하고 다시 빌드합니다.

**로고를 찾을 수 없음**: `claude-howto-logo.png`를 찾을 수 없으면 스크립트는 텍스트만 있는 표지를 생성합니다.
