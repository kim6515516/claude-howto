<!-- i18n-source: resources/QUICK-START.md -->
<!-- i18n-source-sha: 20779db -->
<!-- i18n-date: 2026-10-26 -->
# 퀵 스타트 — 브랜드 에셋

## 에셋을 프로젝트에 복사하기

```bash
# 모든 리소스를 웹 프로젝트에 복사
cp -r resources/ /path/to/your/website/

# 웹용 favicon만 복사
cp resources/favicons/* /path/to/your/website/public/
```

## HTML에 추가(복사 & 붙여넣기)

```html
<!-- Favicons -->
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-32.svg" sizes="32x32">
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-16.svg" sizes="16x16">
<link rel="apple-touch-icon" href="/resources/favicons/favicon-128.svg">
<link rel="icon" type="image/svg+xml" href="/resources/favicons/favicon-256.svg" sizes="256x256">
<meta name="theme-color" content="#000000">
```

## Markdown/문서에서 사용하기

```markdown
# Claude How To

![Claude How To Logo](resources/logos/claude-howto-logo.svg)

![Icon](resources/icons/claude-howto-icon.svg)
```

## 권장 크기

| 용도 | 크기 | 파일 |
|---------|------|------|
| 웹사이트 헤더 | 520×120 | `logos/claude-howto-logo.svg` |
| 앱 아이콘 | 256×256 | `icons/claude-howto-icon.svg` |
| 브라우저 탭 | 32×32 | `favicons/favicon-32.svg` |
| 모바일 홈 화면 | 128×128 | `favicons/favicon-128.svg` |
| 데스크톱 앱 | 256×256 | `favicons/favicon-256.svg` |
| 작은 아바타 | 64×64 | `favicons/favicon-64.svg` |

## 색상 코드

```css
/* CSS에서 이 값들을 사용 */
--color-primary: #000000;
--color-secondary: #6B7280;
--color-accent: #22C55E;
--color-bg-light: #FFFFFF;
--color-bg-dark: #0A0A0A;
```

## 아이콘 디자인의 의미

**코드 브래킷이 붙은 나침반**:
- 나침반 링 = 내비게이션, 체계적인 학습 경로
- 녹색 북침 = 방향, 진척, 안내
- 검은색 남침 = 기반, 흔들리지 않는 토대
- `>` 브래킷 = 터미널 프롬프트, 코드, CLI 컨텍스트
- 눈금 = 정밀함, 체계적인 단계

"명확한 안내로 코드 속에서 길을 찾는다"를 상징합니다.

## 어디에 무엇을 쓸까

### 웹사이트
- **헤더**: 로고(`logos/claude-howto-logo.svg`)
- **Favicon**: 32px(`favicons/favicon-32.svg`)
- **소셜 미리보기**: 아이콘(`icons/claude-howto-icon.svg`)

### GitHub
- **README 배지**: 아이콘(`icons/claude-howto-icon.svg`) 64~128px
- **저장소 아바타**: 아이콘(`icons/claude-howto-icon.svg`)

### 소셜 미디어
- **프로필 이미지**: 아이콘(`icons/claude-howto-icon.svg`)
- **배너**: 로고(`logos/claude-howto-logo.svg`)
- **섬네일**: 256×256px 아이콘

### 문서
- **장 헤더**: 로고 또는 아이콘(적절히 크기 조정)
- **내비게이션 아이콘**: Favicon(32~64px)

---

전체 문서는 [README.md](README.md)를 참고하세요.
