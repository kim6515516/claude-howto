<!-- i18n-source: 03-skills/blog-draft/SKILL.md -->
<!-- i18n-source-sha: f396788 -->
<!-- i18n-date: 2026-10-26 -->

---
name: blog-draft
description: 아이디어와 자료로부터 블로그 글 초안을 작성합니다. 블로그 글 작성, 리서치 기반 콘텐츠 제작, 글 초안 작성 시 사용합니다. 리서치, 브레인스토밍, 아웃라인 작성, 버전 관리가 있는 반복적 초안 작성을 안내합니다.
---

## 사용자 입력

```text
$ARGUMENTS
```

진행하기 전에 사용자 입력을 **반드시** 고려합니다. 사용자는 다음을 제공해야 합니다.
- **Idea/Topic**: 블로그 글의 핵심 콘셉트나 주제
- **Resources**: URL, 파일, 리서치용 참고 자료(선택이지만 권장)
- **Target audience**: 블로그 글의 대상 독자(선택)
- **Tone/Style**: 격식체, 캐주얼, 기술적 등(선택)

**중요**: 사용자가 **기존 블로그 글**의 업데이트를 요청한 경우, 0~8단계를 건너뛰고 곧바로 **9단계**부터 시작합니다. 먼저 기존 초안 파일을 읽은 뒤 반복 프로세스를 진행합니다.

## 실행 흐름

다음 단계를 순서대로 실행합니다. **단계를 건너뛰거나, 지시된 지점에서 사용자 승인 없이 진행해서는 안 됩니다.**

### Step 0: 프로젝트 폴더 생성

1. 다음 형식으로 폴더 이름을 생성합니다: `YYYY-MM-DD-short-topic-name`
   - 오늘 날짜를 사용
   - 주제에서 짧고 URL 친화적인 슬러그를 생성(소문자, 하이픈, 최대 5단어)

2. 폴더 구조를 생성합니다:
   ```
   blog-posts/
   └── YYYY-MM-DD-short-topic-name/
       └── resources/
   ```

3. 진행하기 전에 폴더 생성을 사용자에게 확인합니다.

### Step 1: 리서치와 자료 수집

1. 블로그 글 디렉터리 안에 `resources/` 하위 폴더를 생성합니다

2. 제공된 각 자료에 대해:
   - **URLs**: 가져와서 핵심 정보를 `resources/`에 마크다운 파일로 저장
   - **Files**: 읽어서 `resources/`에 요약
   - **Topics**: 웹 검색으로 최신 정보를 수집

3. 각 자료에 대해 `resources/`에 요약 파일을 생성합니다:
   - `resources/source-1-[short-name].md`
   - `resources/source-2-[short-name].md`
   - 등

4. 각 요약에는 다음을 포함합니다:
   ```markdown
   # Source: [Title/URL]

   ## Key Points
   - Point 1
   - Point 2

   ## Relevant Quotes/Data
   - Quote or statistic 1
   - Quote or statistic 2

   ## How This Relates to Topic
   관련성에 대한 간결한 설명
   ```

5. 리서치 요약을 사용자에게 제시합니다.

### Step 2: 브레인스토밍과 명확화

1. 아이디어와 리서치한 자료를 바탕으로 다음을 제시합니다:
   - 리서치에서 파악된 **주요 주제**
   - 블로그 글이 취할 수 있는 **관점**
   - 다뤄야 할 **핵심 포인트**
   - 명확히 해야 할 정보의 **공백**

2. 명확화를 위한 질문:
   - 독자가 얻어 가길 바라는 핵심 메시지는 무엇인가요?
   - 리서치 중 특히 강조하고 싶은 점이 있나요?
   - 목표 길이는요? (short: 500-800 words, medium: 1000-1500, long: 2000+)
   - 제외하고 싶은 내용이 있나요?

3. **진행하기 전에 사용자 응답을 기다립니다.**

### Step 3: 아웃라인 제안

1. 다음을 포함하는 구조화된 아웃라인을 작성합니다:

   ```markdown
   # Blog Post Outline: [Title]

   ## Meta Information
   - **Target Audience**: [who]
   - **Tone**: [style]
   - **Target Length**: [word count]
   - **Main Takeaway**: [key message]

   ## Proposed Structure

   ### Hook/Introduction
   - Opening hook idea
   - Context setting
   - Thesis statement

   ### Section 1: [Title]
   - Key point A
   - Key point B
   - Supporting evidence from [source]

   ### Section 2: [Title]
   - Key point A
   - Key point B

   [모든 섹션에 대해 계속...]

   ### Conclusion
   - Summary of key points
   - Call to action or final thought

   ## Sources to Cite
   - Source 1
   - Source 2
   ```

2. 아웃라인을 사용자에게 제시하고 **승인 또는 수정을 요청합니다**.

### Step 4: 승인된 아웃라인 저장

1. 사용자가 아웃라인을 승인하면 블로그 글 폴더 안의 `OUTLINE.md`에 저장합니다.

2. 아웃라인이 저장되었음을 확인합니다.

### Step 5: 아웃라인 커밋(git 저장소인 경우)

1. 현재 디렉터리가 git 저장소인지 확인합니다.

2. 그렇다면:
   - 새 파일(블로그 글 폴더, resources, OUTLINE.md)을 스테이징
   - 다음 메시지로 커밋을 생성: `docs: Add outline for blog post - [topic-name]`
   - 원격으로 푸시

3. git 저장소가 아니면 이 단계를 건너뛰고 사용자에게 알립니다.

### Step 6: 초안 작성

1. 승인된 아웃라인을 바탕으로 블로그 글 초안 전문을 작성합니다.

2. OUTLINE.md의 구조를 엄격히 따릅니다.

3. 포함할 내용:
   - 훅이 있는 매력적인 도입부
   - 명확한 섹션 제목
   - 리서치에서 가져온 뒷받침 근거와 예시
   - 섹션 간의 매끄러운 전환
   - 핵심 메시지가 담긴 힘 있는 결론
   - **Citations**: 모든 비교, 통계, 데이터 포인트, 사실 주장은 반드시 원본 출처를 인용할 것

4. 초안을 블로그 글 폴더 안에 `draft-v0.1.md`로 저장합니다.

5. 형식:
   ```markdown
   # [Blog Post Title]

   *[Optional: subtitle or tagline]*

   [인라인 인용이 포함된 본문...]

   ---

   ## References
   - [1] Source 1 Title - URL or Citation
   - [2] Source 2 Title - URL or Citation
   - [3] Source 3 Title - URL or Citation
   ```

6. **인용 요건**:
   - 모든 데이터 포인트, 통계, 비교에는 반드시 인라인 인용을 붙입니다
   - [1], [2] 같은 번호 인용 또는 [Source Name] 같은 이름 인용을 사용합니다
   - 인용을 끝부분의 References 섹션으로 연결합니다
   - 예: "Studies show that 65% of developers prefer TypeScript [1]"
   - 예: "React outperforms Vue in rendering speed by 20% [React Benchmarks 2024]"

### Step 7: 초안 커밋(git 저장소인 경우)

1. git 저장소인지 확인합니다.

2. 그렇다면:
   - 초안 파일을 스테이징
   - 다음 메시지로 커밋을 생성: `docs: Add draft v0.1 for blog post - [topic-name]`
   - 원격으로 푸시

3. git 저장소가 아니면 건너뛰고 사용자에게 알립니다.

### Step 8: 리뷰를 위해 초안 제시

1. 초안 내용을 사용자에게 제시합니다.

2. 피드백을 요청합니다:
   - 전체적인 인상은 어떤가요?
   - 확장하거나 줄여야 할 섹션이 있나요?
   - 톤 조정이 필요한가요?
   - 빠진 정보가 있나요?
   - 구체적인 편집이나 다시 쓰기가 필요한가요?

3. **사용자 응답을 기다립니다.**

### Step 9: 반복 또는 마무리

**사용자가 변경을 요청한 경우:**
1. 모든 요청 사항을 기록합니다
2. 다음 조정을 더해 6단계로 돌아갑니다:
   - 버전 번호 증가(v0.2, v0.3 등)
   - 모든 피드백 반영
   - `draft-v[X.Y].md`로 저장
   - 7~8단계 반복

**사용자가 승인한 경우:**
1. 최종 초안의 버전을 확인합니다
2. 사용자가 요청하면 선택적으로 `final.md`로 이름을 변경합니다
3. 블로그 글 작성 프로세스를 요약합니다:
   - 작성한 버전의 총 개수
   - 버전 간 주요 변경 사항
   - 최종 단어 수
   - 생성한 파일

## 버전 추적

모든 초안은 단계적인 버전 번호를 붙여 보관합니다:
- `draft-v0.1.md` - 첫 초안
- `draft-v0.2.md` - 1차 피드백 반영 후
- `draft-v0.3.md` - 2차 피드백 반영 후
- 등

이렇게 하면 블로그 글의 변화를 추적하고 필요할 때 되돌릴 수 있습니다.

## 출력 파일 구조

```
blog-posts/
└── YYYY-MM-DD-topic-name/
    ├── resources/
    │   ├── source-1-name.md
    │   ├── source-2-name.md
    │   └── ...
    ├── OUTLINE.md
    ├── draft-v0.1.md
    ├── draft-v0.2.md (반복한 경우)
    └── draft-v0.3.md (추가로 반복한 경우)
```

## 품질을 위한 팁

- **Hook**: 질문, 의외의 사실, 공감할 수 있는 시나리오로 시작합니다
- **Flow**: 각 단락이 다음 단락과 이어지게 합니다
- **Evidence**: 리서치 데이터로 주장을 뒷받침합니다
- **Citations**: 다음에 대해서는 반드시 출처를 인용합니다:
  - 모든 통계와 데이터 포인트(예: "According to [Source], 75% of...")
  - 제품, 서비스, 접근 방식 간의 비교(예: "X performs 2x faster than Y [Source]")
  - 시장 동향, 리서치 결과, 벤치마크에 대한 사실 주장
  - 형식: [Source Name] 또는 [Author, Year] 형태의 인라인 인용을 사용
- **Voice**: 전체적으로 일관된 톤을 유지합니다
- **Length**: 목표 단어 수를 지킵니다
- **Readability**: 짧은 단락을 쓰고, 적절한 곳에 글머리 기호를 사용합니다
- **CTA**: 명확한 CTA 또는 생각할 거리를 주는 질문으로 마무리합니다

## 주의 사항

- 지정된 체크포인트에서는 반드시 사용자 승인을 기다립니다
- 이력을 위해 모든 초안 버전을 보관합니다
- URL이 제공된 경우 최신 정보를 위해 웹 검색을 사용합니다
- 자료가 부족하면 사용자에게 추가를 요청하거나 추가 리서치를 제안합니다
- 대상 독자(기술계, 일반, 비즈니스 등)에 맞춰 톤을 조정합니다
