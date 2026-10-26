<!-- i18n-source: 02-memory/project-CLAUDE.md -->
<!-- i18n-source-sha: 7f2e773 -->
<!-- i18n-date: 2026-10-26 -->

# 프로젝트 설정

## 프로젝트 개요
- **이름**: 이커머스 플랫폼
- **기술 스택**: Node.js, PostgreSQL, React 18, Docker
- **팀 규모**: 개발자 5명
- **마감**: 2025년 4분기

## 아키텍처
@docs/architecture.md
@docs/api-standards.md
@docs/database-schema.md

## 개발 표준

### 코드 스타일
- 포맷팅에는 Prettier를 사용합니다
- ESLint(airbnb config)를 사용합니다
- 한 줄 최대 길이: 100자
- 들여쓰기: 스페이스 2개

### 명명 규칙
- **파일**: kebab-case(user-controller.js)
- **클래스**: PascalCase(UserService)
- **함수/변수**: camelCase(getUserById)
- **상수**: UPPER_SNAKE_CASE(API_BASE_URL)
- **데이터베이스 테이블**: snake_case(user_accounts)

### Git 워크플로
- 브랜치 이름: `feature/description` 또는 `fix/description`
- 커밋 메시지: Conventional Commits를 따릅니다
- 머지 전에 PR이 필요합니다
- 모든 CI/CD 검사를 통과해야 합니다
- 최소 1명의 승인이 필요합니다

### 테스트 요구 사항
- 코드 커버리지 최소 80%
- 모든 주요 경로에 테스트가 필요합니다
- 단위 테스트에는 Jest를 사용합니다
- E2E 테스트에는 Cypress를 사용합니다
- 테스트 파일 이름: `*.test.ts` 또는 `*.spec.ts`

### API 표준
- RESTful 엔드포인트만 사용합니다
- 요청/응답은 JSON입니다
- HTTP 상태 코드를 올바르게 사용합니다
- API는 버전이 붙은 엔드포인트를 사용합니다: `/api/v1/`
- 모든 엔드포인트에 예제가 포함된 문서를 준비합니다

### 데이터베이스
- 스키마 변경에는 마이그레이션을 사용합니다
- 인증 정보를 하드코딩하지 않습니다
- 커넥션 풀링을 사용합니다
- 개발 환경에서는 쿼리 로깅을 활성화합니다
- 정기 백업을 필수로 합니다

### 배포
- Docker 기반 배포
- Kubernetes 오케스트레이션
- Blue-Green 배포 전략
- 실패 시 자동 롤백
- 데이터베이스 마이그레이션은 배포 전에 실행합니다

## 자주 쓰는 명령어

| 명령어 | 용도 |
|---------|------|
| `npm run dev` | 개발 서버 시작 |
| `npm test` | 테스트 스위트 실행 |
| `npm run lint` | 코드 스타일 확인 |
| `npm run build` | 프로덕션용 빌드 |
| `npm run migrate` | 데이터베이스 마이그레이션 실행 |

## 팀 연락처
- Tech Lead: Sarah Chen (@sarah.chen)
- Product Manager: Mike Johnson (@mike.j)
- DevOps: Alex Kim (@alex.k)

## 알려진 문제와 해결 방법
- 피크 시간대에 PostgreSQL 커넥션 풀이 20개로 제한됩니다
- 해결 방법: 쿼리 큐잉을 구현합니다
- Safari 14에서 async generator 호환성 문제가 있습니다
- 해결 방법: Babel 트랜스파일러를 사용합니다

## 관련 프로젝트
- Analytics Dashboard: `/projects/analytics`
- Mobile App: `/projects/mobile`
- Admin Panel: `/projects/admin`

---
**Last Updated**: April 9, 2026
