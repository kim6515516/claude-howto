<!-- i18n-source: 03-skills/doc-generator/SKILL.md -->
<!-- i18n-source-sha: a6380d8 -->
<!-- i18n-date: 2026-10-26 -->

---
name: doc-generator
description: 소스 코드에서 포괄적이고 정확한 API 문서를 생성합니다. API 문서 작성·갱신, OpenAPI 명세 생성 시, 또는 API 문서, 엔드포인트, 문서화에 대한 언급이 있을 때 사용합니다.
---

# API 문서 생성 스킬

## 생성하는 것

- OpenAPI/Swagger 명세
- API 엔드포인트 문서
- SDK 사용 예시
- 통합 가이드
- 오류 코드 레퍼런스
- 인증 가이드

## 문서 구조

### 각 엔드포인트별

````markdown
## GET /api/v1/users/:id

### Description
이 엔드포인트의 동작을 간결하게 설명

### Parameters

| Name | Type | Required | Description |
|------|------|----------|-------------|
| id | string | Yes | User ID |

### Response

**200 Success**
```json
{
  "id": "usr_123",
  "name": "John Doe",
  "email": "john@example.com",
  "created_at": "2025-01-15T10:30:00Z"
}
```

**404 Not Found**
```json
{
  "error": "USER_NOT_FOUND",
  "message": "User does not exist"
}
```

### Examples

**cURL**
```bash
curl -X GET "https://api.example.com/api/v1/users/usr_123" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**JavaScript**
```javascript
const user = await fetch('/api/v1/users/usr_123', {
  headers: { 'Authorization': 'Bearer token' }
}).then(r => r.json());
```

**Python**
```python
response = requests.get(
    'https://api.example.com/api/v1/users/usr_123',
    headers={'Authorization': 'Bearer token'}
)
user = response.json()
```
````
