<!-- i18n-source: resources/DESIGN-SYSTEM.md -->
<!-- i18n-source-sha: 20779db -->
<!-- i18n-date: 2026-10-26 -->
# Claude How To — 디자인 시스템

## 비주얼 아이덴티티

### 아이콘 디자인 콘셉트: 코드 브래킷이 있는 나침반

Claude How To의 아이콘은 **`>` 코드 브래킷이 있는 나침반**으로, 코드 속을 안내받으며 나아가는 내비게이션을 표현합니다:

```
     N (green)
     ▲
     │
W ───>─── E     Compass = Guidance/Direction
     │          > Bracket = Code/Terminal/CLI
     ▼
     S (black)
```

이를 통해 다음을 얻습니다:
- **시각적 명료함**: "코드 내비게이션 가이드"를 즉시 전달합니다
- **상징적 의미**: 나침반 = 진로 찾기, `>` = 코드/터미널
- **확장성**: 16px부터 512px까지 어떤 크기에서도 동작합니다
- **브랜드 일관성**: 최소한의 팔레트로 개발자 도구의 미학에 부합합니다

---

## 컬러 시스템

### 팔레트

| 색 | Hex | RGB | 용도 |
|-------|-----|-----|-------|
| 블랙(프라이머리) | `#000000` | 0, 0, 0 | 주요 스트로크, 텍스트, 남쪽 바늘 |
| 화이트(배경) | `#FFFFFF` | 255, 255, 255 | 밝은 배경 |
| 그레이(세컨더리) | `#6B7280` | 107, 114, 128 | 보조 눈금, 보조 텍스트 |
| 브라이트 그린(액센트) | `#22C55E` | 34, 197, 94 | 북쪽 바늘, 중앙 점, 액센트 선 |
| 니어 블랙(다크 배경) | `#0A0A0A` | 10, 10, 10 | 다크 모드 배경 |

### 명암비(WCAG)

- 흰 바탕에 검정: **21:1** AAA
- 흰 바탕에 그레이: **4.6:1** AA
- 흰 바탕에 그린: **3.2:1**(장식용으로만 사용. 텍스트에는 사용하지 않음)
- 다크 바탕에 흰색: **19.5:1** AAA

### 액센트 컬러 규칙

**브라이트 그린(#22C55E)은 하이라이트 전용입니다:**
- 나침반의 북쪽 바늘
- 중앙 점
- 액센트 밑줄·테두리
- 배경색에는 사용하지 않음
- 본문 텍스트에는 사용하지 않음

---

## 타이포그래피

### 로고 폰트
- **패밀리**: Inter, SF Pro Display, -apple-system, Segoe UI, sans-serif
- **"Claude"**: 42px, weight 700(bold), 블랙
- **"How-To"**: 32px, weight 500(medium), 그레이(#6B7280)
- **서브타이틀**: 10px, weight 500, 그레이, letter-spacing 1.5px, 대문자

### 인터페이스 폰트
- **패밀리**: Inter, SF Pro, system fonts (sans-serif)
- **웨이트**: 400~600
- **스타일**: 깔끔하고 읽기 쉽게

---

## 아이콘 상세

### 나침반 사양

나침반 마크는 다음 기하 요소로 구성됩니다:

```
Element             | Stroke/Fill    | Color
--------------------|----------------|------------------
Outer ring          | 3px stroke     | Black / White (dark mode)
North tick          | 2.5px stroke   | Black / White (dark mode)
Other cardinal ticks| 2px stroke     | Gray / White 50% (dark mode)
Intercardinal ticks | 1.5px stroke   | Gray / White 40% (dark mode)
North needle        | filled polygon | #22C55E (always green)
South needle        | filled polygon | Black / White (dark mode)
> bracket           | 3px stroke     | Black / White (dark mode)
Center dot          | filled circle  | #22C55E (always green)
```

### 크기별 변화

```
16px  → Ring + needles + chevron only (minimal)
32px  → Adds cardinal tick marks
64px  → Adds intercardinal tick marks
128px → Full detail, all elements crisp
256px → Maximum detail, thick strokes
```

---

## 크기 지침

### 로고 크기

- **최소**: 너비 200px(웹용)
- **권장**: 520px(네이티브 크기)
- **최대**: 무제한(벡터 형식)
- **가로세로 비율**: 약 4.3:1(너비:높이)

### 아이콘 크기

- **최소**: 16px(favicon)
- **권장**: 64~256px(앱, 아바타)
- **최대**: 무제한(벡터 형식)
- **가로세로 비율**: 1:1(정사각형)

---

## 여백과 배치

### 로고 여백

```
┌─────────────────────────────────────┐
│                                     │
│        Clear Space Minimum          │
│         (logo height / 2)           │
│                                     │
│    [COMPASS]  Claude                │
│               How-To                │
│                                     │
└─────────────────────────────────────┘
```

### 아이콘 중심점

모든 아이콘은 캔버스 중앙에 맞춥니다:
- 256px 캔버스에서는 128×128
- 128px 캔버스에서는 64×64
- 다른 UI 요소와의 정렬을 유지합니다

---

## 접근성

### 색상 대비
- 모든 텍스트는 WCAG AA(최소 4.5:1)를 충족합니다
- 그린 액센트는 장식용이며 정보 전달에는 사용하지 않습니다
- 적녹 색상에 의존하지 않습니다

### 확장성
- 벡터 형식으로 어떤 크기에서도 선명합니다
- 16px에서도 형태를 알아볼 수 있습니다
- 사용 가능한 크기에 따라 단계적으로 세부 묘사를 더합니다

---

## 사용 예

### 웹 헤더
- 크기: 520×120px 로고
- 파일: `logos/claude-howto-logo.svg`
- 배경: 화이트 또는 다크(#0A0A0A)
- 패딩: 최소 20px

### 앱 아이콘
- 크기: 256×256px
- 파일: `icons/claude-howto-icon.svg`
- 배경: 화이트 또는 다크
- 용도: 앱 바로가기, 아바타

### 브라우저 Favicon
- 크기: 32px(메인), 16px(폴백)
- 파일: `favicons/favicon-32.svg`
- 형식: 선명한 표시를 위해 SVG

### 소셜 미디어
- 프로필: 256×256px 아이콘
- 배너: 520×120px 로고(중앙 배치)

### 문서
- 장 헤더: 로고를 적절한 크기로 조정
- 섹션 아이콘: 64×64px favicon
- 인라인: 32×32px favicon

---

## 파일 형식 상세

### SVG 구조

모든 SVG 파일은 플랫 디자인입니다:
- 그라데이션 없음(단색만)
- 필터 효과 없음(블러, 글로우, 섀도 없음)
- 깔끔한 스트로크와 채우기 기하
- 반응형 스케일링을 위한 ViewBox
- 읽기 쉽고 주석이 달린 코드

### 크로스 브라우저 호환성

- Chrome/Edge: 완전 지원
- Firefox: 완전 지원
- Safari: 완전 지원
- iOS Safari: 완전 지원
- 모든 최신 브라우저: 완전 지원

---

## 커스터마이징

### 액센트 컬러 변경

다른 액센트를 사용하는 변형을 만들려면:

1. 모든 `#22C55E`를 원하는 액센트 컬러로 치환합니다
2. 장식 요소의 명암비를 3:1 이상으로 유지합니다
3. 검정·흰색·그레이 구조는 바꾸지 않습니다

### 스케일링

```css
svg {
  width: 256px;
  height: 256px;
}
```

SVG는 viewBox로 자동 스케일됩니다 — transform은 필요 없습니다.

---

## 버전 관리

디자인 변경을 git으로 추적합니다:
- SVG 파일은 평소처럼 버전 관리합니다(텍스트 형식)
- 디자인 변경이 포함된 릴리스에 태그를 붙입니다
- DESIGN-SYSTEM.md를 커밋에 포함합니다

---

**최종 업데이트**: 2026년 2월
**디자인 시스템 버전**: 3.0
