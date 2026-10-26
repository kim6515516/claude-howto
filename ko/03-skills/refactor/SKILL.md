<!-- i18n-source: 03-skills/refactor/SKILL.md -->
<!-- i18n-source-sha: 245272f -->
<!-- i18n-date: 2026-10-26 -->
---
name: refactor
description: Martin Fowler의 방법론에 기반한 체계적인 코드 리팩터링. 사용자가 코드 리팩터링, 코드 구조 개선, 기술 부채 감소, 레거시 코드 정리, 코드 스멜 해소, 코드 유지보수성 향상을 요청할 때 사용합니다. 이 스킬은 리서치·계획·안전한 점진적 구현으로 이루어진 단계적 접근법을 안내합니다.
---

# 코드 리팩터링 스킬

Martin Fowler의 『Refactoring: Improving the Design of Existing Code』(2판)에 기반한 체계적인 코드 리팩터링 접근법입니다. 이 스킬은 테스트가 뒷받침하는 안전하고 점진적인 변경을 중시합니다.

> "Refactoring is the process of changing a software system in such a way that it does not alter the external behavior of the code yet improves its internal structure." — Martin Fowler

## 핵심 원칙

1. **동작 보존**: 외부에서 보이는 동작은 바꾸지 않습니다
2. **작은 단계**: 테스트 가능한 미세한 변경을 쌓아 올립니다
3. **테스트 주도**: 테스트는 안전망입니다
4. **지속성**: 리팩터링은 일회성 작업이 아니라 지속적으로 수행합니다
5. **협업**: 각 단계에서 사용자의 승인이 필요합니다

## 워크플로 개요

```
Phase 1: Research & Analysis
    ↓
Phase 2: Test Coverage Assessment
    ↓
Phase 3: Code Smell Identification
    ↓
Phase 4: Refactoring Plan Creation
    ↓
Phase 5: Incremental Implementation
    ↓
Phase 6: Review & Iteration
```

---

## 1단계: 리서치와 분석

### 목적
- 코드베이스의 구조와 목적을 파악합니다
- 리팩터링 범위를 정합니다
- 비즈니스 요구사항에 관한 컨텍스트를 수집합니다

### 사용자에게 확인할 사항
시작하기 전에 다음을 명확히 합니다.

1. **범위**: 어떤 파일/모듈/함수를 리팩터링하나요?
2. **목표**: 무엇을 해결하고 싶나요? (가독성, 성능, 유지보수성)
3. **제약**: 변경하면 안 되는 영역이 있나요?
4. **시간 압박**: 다른 작업의 블로커가 되고 있나요?
5. **테스트 상황**: 테스트가 존재하나요? 통과하나요?

### 액션
- [ ] 대상 코드를 읽고 이해합니다
- [ ] 의존성과 통합 지점을 파악합니다
- [ ] 현재 아키텍처를 문서화합니다
- [ ] 기존 기술 부채 마커(TODO, FIXME)를 기록합니다

### 출력
사용자에게 제시할 내용:
- 코드 구조 요약
- 발견된 문제 지점
- 초기 권장 사항
- **착수 승인을 요청합니다**

---

## 2단계: 테스트 커버리지 평가

### 테스트가 중요한 이유
> "Refactoring without tests is like driving without a seatbelt." — Martin Fowler

테스트는 안전한 리팩터링을 가능하게 하는 **핵심 요소**입니다. 테스트가 없으면 버그를 유입시킬 위험이 있습니다.

### 평가 단계

1. **기존 테스트 확인**
   ```bash
   # 테스트 파일 찾기
   find . -name "*test*" -o -name "*spec*" | head -20
   ```

2. **기존 테스트 실행**
   ```bash
   # JavaScript/TypeScript
   npm test

   # Python
   pytest -v

   # Java
   mvn test
   ```

3. **커버리지 확인(가능한 경우)**
   ```bash
   # JavaScript
   npm run test:coverage

   # Python
   pytest --cov=.
   ```

### 판단 지점: 사용자에게 확인

**테스트가 존재하고 통과하는 경우:**
- 3단계로 진행합니다

**테스트가 부족하거나 불완전한 경우:**
다음 선택지를 제시합니다.
1. 먼저 테스트를 작성합니다(권장)
2. 리팩터링 중에 점진적으로 테스트를 추가합니다
3. 테스트 없이 진행합니다(위험함, 사용자의 명시적 동의 필요)

**테스트가 실패하는 경우:**
- 중지합니다. 리팩터링 전에 실패하는 테스트를 고칩니다
- 사용자에게 확인: 먼저 테스트를 고쳐야 할까요?

### 테스트 작성 가이드라인(필요 시)

리팩터링 대상 함수마다 다음을 테스트로 커버합니다.
- 해피 패스(정상 동작)
- 엣지 케이스(빈 입력, null, 경계값)
- 오류 시나리오(잘못된 입력, 예외)

"red-green-refactor" 사이클을 사용합니다.
1. 실패하는 테스트를 작성합니다(red)
2. 통과시킵니다(green)
3. 리팩터링합니다

---

## 3단계: 코드 스멜 식별

### 코드 스멜이란?
코드에 숨어 있는 더 깊은 문제의 증상입니다. 버그 자체는 아니지만 코드 개선 여지를 보여 주는 지표입니다.

### 자주 확인해야 할 코드 스멜

전체 카탈로그는 [references/code-smells.md](references/code-smells.md)를 참고하세요.

#### 빠른 참조

| 스멜 | 징후 | 영향 |
|-------|-------|--------|
| **Long Method(긴 메서드)** | 메서드가 30~50줄을 넘음 | 이해, 테스트, 유지보수가 어려움 |
| **Duplicated Code(중복 코드)** | 같은 로직이 여러 곳에 존재 | 버그 수정을 여러 곳에서 해야 함 |
| **Large Class(거대한 클래스)** | 책임이 너무 많은 클래스 | 단일 책임 원칙 위반 |
| **Feature Envy(기능 편애)** | 다른 클래스의 데이터를 많이 사용하는 메서드 | 캡슐화 부족 |
| **Primitive Obsession(기본형 집착)** | 객체로 만들어야 할 곳에 기본형을 남용 | 도메인 개념 누락 |
| **Long Parameter List(긴 매개변수 목록)** | 매개변수가 4개 이상 | 올바르게 호출하기 어려움 |
| **Data Clumps(데이터 뭉치)** | 같은 데이터 항목이 항상 함께 나타남 | 추상화 누락 |
| **Switch Statements(스위치 문)** | 복잡한 switch / if-else 연쇄 | 확장이 어려움 |
| **Speculative Generality(추측성 일반화)** | "혹시 몰라서" 넣은 코드 | 불필요한 복잡성 |
| **Dead Code(죽은 코드)** | 사용되지 않는 코드 | 혼란과 유지보수 부담 |

### 분석 단계

1. **자동 분석**(스크립트를 사용할 수 있는 경우)
   ```bash
   python scripts/detect-smells.py <file>
   ```

2. **수동 리뷰**
   - 코드를 체계적으로 읽어 나갑니다
   - 각 스멜을 위치와 심각도와 함께 기록합니다
   - 영향도별로 분류합니다(Critical / High / Medium / Low)

3. **우선순위 지정**
   다음과 같은 스멜에 집중합니다.
   - 현재 개발을 막고 있는 것
   - 버그나 혼란을 일으키는 것
   - 변경 빈도가 높은 코드 경로에 영향을 주는 것

### 출력: 스멜 보고서

사용자에게 제시할 내용:
- 발견된 스멜 목록과 위치
- 각 스멜의 심각도 평가
- 권장 우선순위
- **우선순위 승인을 요청합니다**

---

## 4단계: 리팩터링 계획 작성

### 리팩터링 기법 선정

각 스멜에 대해 카탈로그에서 적절한 리팩터링 기법을 고릅니다.

전체 목록은 [references/refactoring-catalog.md](references/refactoring-catalog.md)를 참고하세요.

#### 스멜별 권장 리팩터링

| 코드 스멜 | 권장 리팩터링 |
|------------|---------------------------|
| Long Method(긴 메서드) | 메서드 추출, Replace Temp with Query |
| Duplicated Code(중복 코드) | 메서드 추출, Pull Up Method, Form Template Method |
| Large Class(거대한 클래스) | 클래스 추출, Extract Subclass |
| Feature Envy(기능 편애) | Move Method, Move Field |
| Primitive Obsession(기본형 집착) | Replace Primitive with Object, Replace Type Code with Class |
| Long Parameter List(긴 매개변수 목록) | 매개변수 객체 도입, Preserve Whole Object |
| Data Clumps(데이터 뭉치) | 클래스 추출, 매개변수 객체 도입 |
| Switch Statements(스위치 문) | 다형성으로 조건문 치환 |
| Speculative Generality(추측성 일반화) | Collapse Hierarchy, Inline Class, 죽은 코드 제거 |
| Dead Code(죽은 코드) | 죽은 코드 제거 |

### 계획 구성

[templates/refactoring-plan.md](templates/refactoring-plan.md) 템플릿을 사용합니다.

각 리팩터링마다 다음 항목을 채웁니다.
1. **대상**: 무엇을 변경하는가
2. **스멜**: 어떤 문제를 해결하는가
3. **리팩터링**: 어떤 기법을 적용하는가
4. **절차**: 세부 마이크로 스텝
5. **위험**: 무엇이 잘못될 수 있는가
6. **롤백**: 되돌리는 방법

### 단계적 접근

**중요**: 리팩터링은 단계로 나누어 점진적으로 도입합니다.

**A단계: 빠른 성과**(낮은 위험, 높은 가치)
- 명확성을 위한 변수 이름 변경
- 명백한 중복 코드 추출
- 죽은 코드 제거

**B단계: 구조 개선**(중간 위험)
- 긴 함수에서 메서드 추출
- 매개변수 객체 도입
- 메서드를 적절한 클래스로 이동

**C단계: 아키텍처 변경**(높은 위험)
- 조건 분기를 다형성으로 치환
- 클래스 추출
- 디자인 패턴 도입

### 판단 지점: 사용자에게 계획 제시

구현 전에:
- 완전한 리팩터링 계획을 제시합니다
- 각 단계의 내용과 위험을 설명합니다
- 각 단계에 대해 명시적인 승인을 받습니다
- **질문**: "A단계를 진행해도 될까요?"

---

## 5단계: 점진적 구현

### 황금률
> "Change → Test → Green? → Commit → Next step"

### 구현 리듬

각 리팩터링 단계에서:

1. **사전 점검**
   - 테스트가 통과하고 있음(green)
   - 코드가 컴파일됨

2. **작은 변경을 하나만 수행**
   - 카탈로그의 메커니즘을 따릅니다
   - 변경은 최소한으로 유지합니다

3. **검증**
   - 즉시 테스트를 실행합니다
   - 컴파일 오류가 없는지 확인합니다

4. **테스트가 통과(green)한 경우**
   - 설명적인 커밋 메시지로 커밋합니다
   - 다음 단계로 진행합니다

5. **테스트가 실패(red)한 경우**
   - 즉시 중지합니다
   - 변경을 되돌립니다
   - 무슨 일이 일어났는지 분석합니다
   - 불확실하면 사용자에게 확인합니다

### 커밋 전략

각 커밋은 다음 성질을 만족해야 합니다.
- **원자적**: 논리적으로 하나의 변경
- **가역적**: 쉽게 revert할 수 있음
- **설명적**: 명확한 커밋 메시지

커밋 메시지 예:
```
refactor: Extract calculateTotal() from processOrder()
refactor: Rename 'x' to 'customerCount' for clarity
refactor: Remove unused validateOldFormat() method
```

### 진행 보고

하위 단계마다 사용자에게 다음을 보고합니다.
- 수행한 변경
- 테스트가 여전히 통과하는지
- 발생한 문제
- **질문**: "다음 배치로 진행해도 될까요?"

---

## 6단계: 리뷰와 반복

### 리팩터링 후 체크리스트

- [ ] 모든 테스트가 통과합니다
- [ ] 새로운 경고/오류가 없습니다
- [ ] 코드가 정상적으로 컴파일됩니다
- [ ] 동작이 바뀌지 않았습니다(수동 검증)
- [ ] 필요에 따라 문서가 업데이트되었습니다
- [ ] 커밋 이력이 정리되어 있습니다

### 메트릭 비교

리팩터링 전후로 복잡도 분석을 수행합니다.
```bash
python scripts/analyze-complexity.py <file>
```

개선 사항을 제시합니다.
- 코드 줄 수 변화
- 순환 복잡도 변화
- 유지보수성 지수 변화

### 사용자 리뷰

최종 결과를 제시합니다.
- 모든 변경 요약
- Before / After 코드 비교
- 메트릭 개선
- 남은 기술 부채
- **질문**: "이 변경 내용으로 문제없을까요?"

### 다음 단계

사용자와 논의합니다.
- 추가로 처리해야 할 스멜이 있나요?
- 후속 리팩터링을 계획할까요?
- 같은 변경을 다른 곳에도 적용할까요?

---

## 중요 가이드라인

### 멈추고 사용자와 상의해야 할 때

다음의 경우 반드시 일단 멈추고 사용자와 상의합니다.
- 비즈니스 로직에 불확실성이 있음
- 외부 API에 영향을 줄 수 있는 변경
- 테스트 커버리지가 불충분함
- 중대한 아키텍처 판단이 필요함
- 위험 수준이 올라감
- 예상치 못한 복잡성을 만남

### 안전 규칙

1. **테스트 없이 리팩터링하지 않습니다**(사용자가 명시적으로 위험을 수용하지 않는 한)
2. **큰 변경을 한 번에 하지 않습니다** - 미세한 단계로 나눕니다
3. **각 변경 후 테스트 실행을 생략하지 않습니다**
4. **테스트 실패 시 계속 진행하지 않습니다** - 수정이나 롤백을 먼저 합니다
5. **추측으로 진행하지 않습니다** - 의문이 있으면 확인합니다

### 하지 말아야 할 것

- 리팩터링과 기능 추가를 동시에 하지 않습니다
- 프로덕션 장애 대응 중에 리팩터링하지 않습니다
- 이해하지 못한 코드를 리팩터링하지 않습니다
- 과잉 설계를 하지 않습니다 - 단순하게 유지합니다
- 모든 것을 한 번에 리팩터링하지 않습니다

---

## 빠른 시작 예제

### 시나리오: 중복이 있는 긴 함수

**Before:**
```javascript
function processOrder(order) {
  // 150줄의 코드에 다음이 뒤섞여 있음:
  // - 중복된 검증 로직
  // - 인라인 계산 처리
  // - 여러 책임
}
```

**리팩터링 절차:**

1. processOrder()에 대한 **테스트가 있는지 확인**
2. 검증을 validateOrder()로 **추출**
3. **테스트** - 통과해야 함
4. 계산을 calculateOrderTotal()로 **추출**
5. **테스트** - 통과해야 함
6. 알림을 notifyCustomer()로 **추출**
7. **테스트** - 통과해야 함
8. **리뷰** - processOrder()는 명확한 3개 함수의 조정자가 됨

**After:**
```javascript
function processOrder(order) {
  validateOrder(order);
  const total = calculateOrderTotal(order);
  notifyCustomer(order, total);
  return { order, total };
}
```

---

## 참고 자료

- [Code Smells Catalog](references/code-smells.md) - 코드 스멜 전체 목록
- [Refactoring Catalog](references/refactoring-catalog.md) - 리팩터링 기법
- [Refactoring Plan Template](templates/refactoring-plan.md) - 계획용 템플릿

## 스크립트

- `scripts/analyze-complexity.py` - 코드 복잡도 메트릭 분석
- `scripts/detect-smells.py` - 스멜 자동 감지

## 버전 이력

- v1.0.0 (2025-01-15): Fowler의 방법론, 단계적 접근, 사용자 상의 지점을 갖춘 첫 릴리스
