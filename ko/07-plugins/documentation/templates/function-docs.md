<!-- i18n-source: 07-plugins/documentation/templates/function-docs.md -->
<!-- i18n-source-sha: 5caeff2 -->
<!-- i18n-date: 2026-10-26 -->

# 함수: `functionName`

## 설명
함수 동작에 대한 간단한 설명.

## 시그니처
```typescript
function functionName(param1: Type1, param2: Type2): ReturnType
```

## 매개변수

| Parameter | Type | Required | 설명 |
|-----------|------|----------|-----|
| param1 | Type1 | Yes | param1 설명 |
| param2 | Type2 | No | param2 설명 |

## 반환값
**Type**: `ReturnType`

반환되는 값에 대한 설명.

## 예외
- `Error`: 잘못된 입력이 주어졌을 때
- `TypeError`: 잘못된 타입이 전달되었을 때

## 예시

### 기본 사용법
```typescript
const result = functionName('value1', 'value2');
console.log(result);
```

### 고급 사용법
```typescript
const result = functionName(
  complexParam1,
  { option: true }
);
```

## 참고
- 추가 주의 사항이나 경고
- 성능 관련 고려 사항
- 모범 사례

## 관련 항목
- [관련 함수](#)
- [API 문서](#)
