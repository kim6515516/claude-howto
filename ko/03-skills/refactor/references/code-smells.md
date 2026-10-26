<!-- i18n-source: 03-skills/refactor/references/code-smells.md -->
<!-- i18n-source-sha: 245272f -->
<!-- i18n-date: 2026-10-26 -->
# 코드 스멜 카탈로그

Martin Fowler의 『Refactoring』(2판)에 기반한 코드 스멜의 포괄적인 레퍼런스입니다. 코드 스멜은 더 깊은 문제의 증상이며, 코드 설계에 무언가 문제가 있을 가능성을 나타내는 지표입니다.

> "A code smell is a surface indication that usually corresponds to a deeper problem in the system." — Martin Fowler

---

## Bloaters(비대한 코드)

효과적으로 다루기에는 너무 커진 것을 나타내는 코드 스멜 그룹입니다.

### Long Method(너무 긴 함수)

**징후:**
- 메서드가 30~50줄을 넘습니다
- 메서드 전체를 보려면 스크롤이 필요합니다
- 중첩이 여러 겹입니다
- 섹션마다 무엇을 하는지 설명하는 주석이 있습니다

**왜 나쁜가:**
- 이해하기 어렵습니다
- 단독으로 테스트하기 어렵습니다
- 변경이 예기치 않은 영향을 미칩니다
- 내부에 중복 로직이 숨어 있습니다

**리팩터링:**
- 메서드 추출
- Replace Temp with Query
- 매개변수 객체 도입
- Replace Method with Method Object
- 조건문 분해

**예시(Before):**
```javascript
function processOrder(order) {
  // 주문 검증 (20줄)
  if (!order.items) throw new Error('No items');
  if (order.items.length === 0) throw new Error('Empty order');
  // ... 추가 검증

  // 합계 금액 계산 (30줄)
  let subtotal = 0;
  for (const item of order.items) {
    subtotal += item.price * item.quantity;
  }
  // ... 세금, 배송비, 할인

  // 알림 전송 (20줄)
  // ... 이메일 전송 로직
}
```

**예시(After):**
```javascript
function processOrder(order) {
  validateOrder(order);
  const totals = calculateOrderTotals(order);
  sendOrderNotifications(order, totals);
  return { order, totals };
}
```

---

### Large Class(거대한 클래스)

**징후:**
- 클래스의 인스턴스 변수가 많습니다(7~10개 초과)
- 클래스의 메서드가 많습니다(15~20개 초과)
- 클래스 이름이 막연합니다(Manager, Handler, Processor)
- 모든 인스턴스 변수를 사용하지 않는 메서드가 있습니다

**왜 나쁜가:**
- 단일 책임 원칙을 위반합니다
- 테스트가 어렵습니다
- 변경이 무관한 기능에도 파급됩니다
- 부분적인 재사용이 어렵습니다

**리팩터링:**
- 클래스 추출
- Extract Subclass
- Extract Interface

**검출 기준:**
```
코드 줄 수 > 300
메서드 수 > 15
필드 수 > 10
```

---

### Primitive Obsession(기본 타입 집착)

**징후:**
- 도메인 개념에 기본 타입을 사용합니다(이메일에 string, 금액에 int)
- 객체 대신 기본 타입 배열을 사용합니다
- 타입 코드에 문자열 상수를 사용합니다
- 매직 넘버나 매직 스트링이 있습니다

**왜 나쁜가:**
- 타입 수준에서 검증할 수 없습니다
- 로직이 코드베이스 전체에 흩어집니다
- 잘못된 값을 넘기기 쉽습니다
- 도메인 개념이 빠집니다

**리팩터링:**
- Replace Primitive with Object
- Replace Type Code with Class
- Replace Type Code with Subclasses
- Replace Type Code with State/Strategy

**예시(Before):**
```javascript
const user = {
  email: 'john@example.com',     // 단순 문자열
  phone: '1234567890',           // 단순 문자열
  status: 'active',              // 매직 스트링
  balance: 10050                 // 센트 단위 정수
};
```

**예시(After):**
```javascript
const user = {
  email: new Email('john@example.com'),
  phone: new PhoneNumber('1234567890'),
  status: UserStatus.ACTIVE,
  balance: Money.cents(10050)
};
```

---

### Long Parameter List(너무 긴 매개변수 목록)

**징후:**
- 매개변수가 4개 이상인 메서드
- 항상 함께 등장하는 매개변수
- 메서드 동작을 전환하는 불리언 플래그
- null/undefined가 자주 전달됨

**왜 나쁜가:**
- 올바르게 호출하기 어렵습니다
- 인자 순서의 혼동을 부릅니다
- 메서드가 너무 많은 일을 떠안고 있다는 신호입니다
- 매개변수를 추가하기 어렵습니다

**리팩터링:**
- 매개변수 객체 도입
- Preserve Whole Object
- Replace Parameter with Method Call
- Remove Flag Argument

**예시(Before):**
```javascript
function createUser(firstName, lastName, email, phone,
                    street, city, state, zip,
                    isAdmin, isActive, createdBy) {
  // ...
}
```

**예시(After):**
```javascript
function createUser(personalInfo, address, options) {
  // personalInfo: { firstName, lastName, email, phone }
  // address: { street, city, state, zip }
  // options: { isAdmin, isActive, createdBy }
}
```

---

### Data Clumps(데이터 뭉치)

**징후:**
- 같은 3개 이상의 필드가 반복해서 함께 등장합니다
- 항상 함께 전달되는 매개변수 묶음이 있습니다
- 한 덩어리로 속해야 할 필드 집합을 가진 클래스가 있습니다

**왜 나쁜가:**
- 처리 로직이 중복됩니다
- 추상화가 빠져 있습니다
- 확장하기 어렵습니다
- 숨은 클래스의 존재를 나타냅니다

**리팩터링:**
- 클래스 추출
- 매개변수 객체 도입
- Preserve Whole Object

**예시:**
```javascript
// 데이터 뭉치: (x, y, z) 좌표
function movePoint(x, y, z, dx, dy, dz) { }
function scalePoint(x, y, z, factor) { }
function distanceBetween(x1, y1, z1, x2, y2, z2) { }

// Point3D 클래스를 추출
class Point3D {
  constructor(x, y, z) { }
  move(delta) { }
  scale(factor) { }
  distanceTo(other) { }
}
```

---

## Object-Orientation Abusers(객체 지향 남용)

객체 지향 원칙을 불완전하게 또는 잘못 사용하고 있음을 나타내는 스멜 그룹입니다.

### Switch Statements(스위치 문)

**징후:**
- 긴 switch/case나 if/else 연쇄
- 같은 switch가 여러 곳에 존재
- 타입 코드에 대한 switch
- 새 케이스를 추가하면 여러 곳을 수정해야 함

**왜 나쁜가:**
- 개방 폐쇄 원칙을 위반합니다
- 모든 switch 위치에 변경이 파급됩니다
- 확장이 어렵습니다
- 다형성 부재의 신호인 경우가 많습니다

**리팩터링:**
- 조건문을 다형성으로 대체
- Replace Type Code with Subclasses
- Replace Type Code with State/Strategy

**예시(Before):**
```javascript
function calculatePay(employee) {
  switch (employee.type) {
    case 'hourly':
      return employee.hours * employee.rate;
    case 'salaried':
      return employee.salary / 12;
    case 'commissioned':
      return employee.sales * employee.commission;
  }
}
```

**예시(After):**
```javascript
class HourlyEmployee {
  calculatePay() {
    return this.hours * this.rate;
  }
}

class SalariedEmployee {
  calculatePay() {
    return this.salary / 12;
  }
}
```

---

### Temporary Field(임시 필드)

**징후:**
- 일부 메서드에서만 사용되는 인스턴스 변수
- 조건부로 설정되는 필드
- 특정 케이스를 위해 복잡한 초기화가 필요함

**왜 나쁜가:**
- 혼란스럽습니다 - 필드가 존재하지만 null인 경우가 있습니다
- 객체 상태를 이해하기 어렵습니다
- 숨은 조건 분기 로직을 나타냅니다

**리팩터링:**
- 클래스 추출
- Introduce Null Object
- Replace Temp Field with Local

---

### Refused Bequest(상속 거부)

**징후:**
- 서브클래스가 상속한 메서드/데이터를 사용하지 않습니다
- 서브클래스가 오버라이드하고 아무것도 하지 않습니다
- IS-A 관계가 아니라 코드 재사용 목적의 상속입니다

**왜 나쁜가:**
- 추상화가 잘못되었습니다
- 리스코프 치환 원칙을 위반합니다
- 계층 구조가 오해를 부릅니다

**리팩터링:**
- Push Down Method/Field
- Replace Subclass with Delegate
- Replace Inheritance with Delegation

---

### Alternative Classes with Different Interfaces(인터페이스가 다른 대체 클래스)

**징후:**
- 비슷한 일을 하는 두 클래스
- 같은 개념에 다른 메서드 이름을 사용함
- 서로 대체 가능하지만 공통 인터페이스가 없음

**왜 나쁜가:**
- 구현이 중복됩니다
- 공통 인터페이스가 없습니다
- 전환이 어렵습니다

**리팩터링:**
- Rename Method
- Move Method
- Extract Superclass
- Extract Interface

---

## Change Preventers(변경 방해자)

변경을 어렵게 만드는 스멜 그룹입니다 - 하나를 바꾸려면 다른 많은 것을 바꿔야 합니다.

### Divergent Change(발산적 변경)

**징후:**
- 하나의 클래스가 서로 다른 여러 이유로 변경됩니다
- 서로 다른 영역의 변경이 같은 클래스 수정을 유발합니다
- 그 클래스가 "신 클래스"가 되어 갑니다

**왜 나쁜가:**
- 단일 책임 원칙을 위반합니다
- 변경 빈도가 높아집니다
- 머지 충돌을 부릅니다

**리팩터링:**
- 클래스 추출
- Extract Superclass
- Extract Subclass

**예시:**
`User` 클래스가 다음 이유로 변경됩니다:
- 인증 변경
- 프로필 변경
- 과금 변경
- 알림 변경

→ 추출: `AuthService`, `ProfileService`, `BillingService`, `NotificationService`

---

### Shotgun Surgery(산탄총 수술)

**징후:**
- 하나의 변경에 많은 클래스 수정이 필요합니다
- 작은 기능에도 10개 이상의 파일을 손대야 합니다
- 변경 지점이 흩어져 있어 모두 찾기 어렵습니다

**왜 나쁜가:**
- 수정 누락이 생기기 쉽습니다
- 결합도가 높습니다
- 변경이 오류를 유발하기 쉽습니다

**리팩터링:**
- Move Method
- Move Field
- Inline Class

**검출 기준:**
필드 하나를 추가할 때 5개 이상의 파일 변경이 필요한지 확인합니다.

---

### Parallel Inheritance Hierarchies(평행 상속 계층)

**징후:**
- 한쪽 계층에 서브클래스를 만들면 다른 쪽에도 만들어야 합니다
- 클래스 이름의 접두사가 맞춰져 있습니다(예: `DatabaseOrder`, `DatabaseProduct`)

**왜 나쁜가:**
- 유지보수 비용이 두 배가 됩니다
- 계층 간 결합도가 높습니다
- 한쪽을 빠뜨리기 쉽습니다

**리팩터링:**
- Move Method
- Move Field
- 한쪽 계층을 제거합니다

---

## Dispensables(불필요한 것)

불필요하며 제거해야 할 것을 나타내는 스멜 그룹입니다.

### Comments(과도한 주석)

**징후:**
- 코드가 무엇을 하는지 설명하는 주석
- 주석 처리된 코드
- 영원히 남아 있는 TODO/FIXME
- 변명하는 주석

**왜 나쁜가:**
- 주석은 거짓말을 합니다(코드와 괴리됩니다)
- 코드는 스스로 문서화되어야 합니다
- 죽은 코드는 혼란을 낳습니다

**리팩터링:**
- 메서드 추출(이름으로 "무엇"을 표현)
- Rename(주석 없이 명확하게)
- 주석 처리된 코드 제거
- Introduce Assertion

**좋은 주석과 나쁜 주석:**
```javascript
// 나쁨: "무엇"을 설명함
// users를 순회하며 활성 상태인지 확인
for (const user of users) {
  if (user.status === 'active') { }
}

// 좋음: "왜"를 설명함
// 활성 사용자만. 비활성 사용자는 정리 작업에서 처리됨
const activeUsers = users.filter(u => u.isActive);
```

---

### Duplicate Code(중복 코드)

**징후:**
- 같은 코드가 여러 곳에 있습니다
- 사소한 차이만 있는 비슷한 코드가 있습니다
- 복사-붙여넣기 패턴이 있습니다

**왜 나쁜가:**
- 버그 수정을 여러 곳에서 해야 합니다
- 불일치 위험이 있습니다
- 코드베이스가 비대해집니다

**리팩터링:**
- 메서드 추출
- 클래스 추출
- Pull Up Method(계층 내)
- Form Template Method

**검출 규칙:**
3회 이상 중복되는 코드는 추출해야 합니다.

---

### Lazy Class(게으른 클래스)

**징후:**
- 클래스가 존재를 정당화할 만큼 일하지 않습니다
- 부가 가치 없는 래퍼입니다
- 과잉 설계의 결과입니다

**왜 나쁜가:**
- 유지보수 오버헤드
- 불필요한 간접 참조
- 이점 없는 복잡성

**리팩터링:**
- Inline Class
- Collapse Hierarchy

---

### Dead Code(데드 코드)

**징후:**
- 도달 불가능한 코드
- 사용되지 않는 변수/메서드/클래스
- 주석 처리된 코드
- 일어날 수 없는 조건 아래의 코드

**왜 나쁜가:**
- 혼란을 부릅니다
- 유지보수 부담입니다
- 이해 속도를 떨어뜨립니다

**리팩터링:**
- 데드 코드 제거
- Safe Delete

**검출 기준:**
```bash
# 사용되지 않는 export 찾기
# 참조되지 않는 함수 찾기
# IDE의 "사용되지 않음" 경고 확인
```

---

### Speculative Generality(추측성 일반화)

**징후:**
- 서브클래스가 하나뿐인 추상 클래스
- "미래를 위한" 미사용 매개변수
- 위임만 하는 메서드
- 용도가 하나뿐인 "프레임워크"

**왜 나쁜가:**
- 이점 없는 복잡성
- YAGNI(You Ain't Gonna Need It)
- 이해하기 어려움

**리팩터링:**
- Collapse Hierarchy
- Inline Class
- Remove Parameter
- Rename Method

---

## Couplers(결합 문제)

클래스 간 과도한 결합을 나타내는 스멜 그룹입니다.

### Feature Envy(기능 욕심)

**징후:**
- 메서드가 자기 클래스보다 다른 클래스의 데이터를 더 많이 사용합니다
- 다른 객체의 getter 호출이 많습니다
- 데이터와 동작이 분리되어 있습니다

**왜 나쁜가:**
- 동작이 잘못된 위치에 있습니다
- 캡슐화가 부족합니다
- 유지보수가 어렵습니다

**리팩터링:**
- Move Method
- Move Field
- 메서드 추출(그 후 move)

**예시(Before):**
```javascript
class Order {
  getDiscountedPrice(customer) {
    // customer의 데이터를 많이 사용함
    if (customer.loyaltyYears > 5) {
      return this.price * customer.discountRate;
    }
    return this.price;
  }
}
```

**예시(After):**
```javascript
class Customer {
  getDiscountedPriceFor(price) {
    if (this.loyaltyYears > 5) {
      return price * this.discountRate;
    }
    return price;
  }
}
```

---

### Inappropriate Intimacy(부적절한 친밀함)

**징후:**
- 클래스가 서로의 private 부분에 접근합니다
- 양방향 참조가 있습니다
- 서브클래스가 부모에 대해 너무 많이 압니다

**왜 나쁜가:**
- 결합도가 높습니다
- 변경이 연쇄됩니다
- 한쪽을 바꾸면 다른 쪽도 바꿔야 합니다

**리팩터링:**
- Move Method
- Move Field
- Change Bidirectional to Unidirectional
- 클래스 추출
- Hide Delegate

---

### Message Chains(메시지 체인)

**징후:**
- 메서드 호출의 긴 연쇄: `a.getB().getC().getD().getValue()`
- 클라이언트가 탐색 구조에 의존합니다
- "열차 사고" 코드

**왜 나쁜가:**
- 취약합니다 - 연쇄 중 하나라도 바뀌면 깨집니다
- 디미터 법칙을 위반합니다
- 구조에 결합됩니다

**리팩터링:**
- Hide Delegate
- 메서드 추출
- Move Method

**예시:**
```javascript
// 나쁨: 메시지 체인
const managerName = employee.getDepartment().getManager().getName();

// 좋음: 위임을 숨김
const managerName = employee.getManagerName();
```

---

### Middle Man(중개자)

**징후:**
- 다른 클래스에 위임만 하는 클래스
- 메서드의 절반이 위임
- 부가 가치가 없음

**왜 나쁜가:**
- 불필요한 간접 참조
- 유지보수 오버헤드
- 아키텍처를 파악하기 어려움

**리팩터링:**
- Remove Middle Man
- 메서드 인라인화

---

## 스멜 심각도 가이드

| 심각도 | 설명 | 대응 |
|----------|-------------|--------|
| **Critical** | 개발을 막고 버그의 원인이 됨 | 즉시 수정 |
| **High** | 유지보수 부담이 큼 | 해당 스프린트 중에 수정 |
| **Medium** | 눈에 띄지만 허용 범위 | 가까운 시일 내에 계획 |
| **Low** | 경미한 불편 | 기회가 있을 때 수정 |

---

## 간이 검출 체크리스트

코드를 스캔할 때 사용하는 체크리스트입니다.

- [ ] 30줄을 넘는 메서드가 있는가?
- [ ] 300줄을 넘는 클래스가 있는가?
- [ ] 4개를 넘는 매개변수를 가진 메서드가 있는가?
- [ ] 중복된 코드 블록이 있는가?
- [ ] 타입 코드에 대한 switch/case가 있는가?
- [ ] 사용되지 않는 코드가 있는가?
- [ ] 다른 클래스의 데이터를 많이 사용하는 메서드가 있는가?
- [ ] 메서드 호출의 긴 연쇄가 있는가?
- [ ] "왜"가 아니라 "무엇"을 설명하는 주석이 있는가?
- [ ] 객체화해야 할 기본 타입이 있는가?

---

## 참고 문헌

- Fowler, M. (2018). *Refactoring: Improving the Design of Existing Code* (2nd ed.)
- Kerievsky, J. (2004). *Refactoring to Patterns*
- Feathers, M. (2004). *Working Effectively with Legacy Code*
