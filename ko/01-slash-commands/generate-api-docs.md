<!-- i18n-source: 01-slash-commands/generate-api-docs.md -->
<!-- i18n-source-sha: 7f2e773 -->
<!-- i18n-date: 2026-10-26 -->

---
description: 소스 코드에서 포괄적인 API 문서를 생성합니다
---

# API 문서 생성

다음 절차로 API 문서를 생성합니다:

1. `/src/api/` 아래의 모든 파일을 스캔합니다
2. 함수 시그니처와 JSDoc 주석을 추출합니다
3. 엔드포인트/모듈 단위로 정리합니다
4. 예제가 포함된 Markdown을 작성합니다
5. 요청/응답 스키마를 포함합니다
6. 오류에 관한 문서를 추가합니다

출력 형식:
- `/docs/api.md`에 Markdown 파일로 출력
- 모든 엔드포인트에 curl 예제를 포함
- TypeScript 타입 정의를 추가

---
**Last Updated**: April 9, 2026
