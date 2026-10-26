<!-- i18n-source: 02-memory/directory-api-CLAUDE.md -->
<!-- i18n-source-sha: 7f2e773 -->
<!-- i18n-date: 2026-10-26 -->

# API 모듈 표준

이 파일은 /src/api/ 아래의 모든 항목에 대해 루트 CLAUDE.md를 보완합니다. 메모리 파일은
덮어쓰이는 것이 아니라 연결(concatenate)됩니다. 루트 CLAUDE.md는 계속 적용되며,
Claude Code는 이 서브트리 안의 파일을 읽거나 쓰거나 편집할 때 이 파일을 온디맨드로 읽어 들입니다.

## API 고유 표준

### 요청 검증
- 스키마 검증에는 Zod를 사용합니다
- 입력은 반드시 검증합니다
- 검증 오류 시 400을 반환합니다
- 필드 단위의 오류 상세를 포함합니다

### 인증
- 모든 엔드포인트에서 JWT 토큰을 필수로 합니다
- 토큰은 Authorization 헤더에 넣습니다
- 토큰 유효 기간은 24시간입니다
- 리프레시 토큰 메커니즘을 구현합니다

### 응답 형식

모든 응답은 다음 구조를 따릅니다:

```json
{
  "success": true,
  "data": { /* actual data */ },
  "timestamp": "2025-11-06T10:30:00Z",
  "version": "1.0"
}
```

오류 응답:
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "User message",
    "details": { /* field errors */ }
  },
  "timestamp": "2025-11-06T10:30:00Z"
}
```

### 페이지네이션
- 커서 기반 페이지네이션을 사용합니다(오프셋 방식은 사용하지 않음)
- `hasMore` 불리언 값을 포함합니다
- 한 페이지의 최대 크기는 100까지입니다
- 기본 페이지 크기: 20

### 속도 제한
- 인증된 사용자: 시간당 1000 요청
- 공개 엔드포인트: 시간당 100 요청
- 상한 초과 시 429를 반환합니다
- retry-after 헤더를 붙입니다

### 캐시
- 세션 캐시에는 Redis를 사용합니다
- 캐시 기간: 기본 5분
- 쓰기 작업 시 무효화합니다
- 캐시 키에 리소스 종류 태그를 붙입니다

---
**최종 업데이트**: 2026년 10월 10일
**Claude Code 버전**: 2.1.296
**Sources**:
- https://code.claude.com/docs/en/memory
- https://github.com/anthropics/claude-code/releases/tag/v2.1.288
- https://github.com/anthropics/claude-code/releases/tag/v2.1.293
