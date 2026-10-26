<!-- i18n-source: 03-skills/refactor/references/refactoring-catalog.md -->
<!-- i18n-source-sha: 245272f -->
<!-- i18n-date: 2026-10-26 -->

# 리팩터링 카탈로그

Martin Fowler의 『Refactoring』(2판)에서 엄선한 리팩터링 기법 카탈로그입니다. 각 리팩터링마다 동기, 절차, 예시를 실었습니다.

> "리팩터링은 그 절차, 즉 변경을 수행하기 위한 정확한 단계의 나열로 정의됩니다." — Martin Fowler

---

## 이 카탈로그 사용법

1. 코드 스멜 레퍼런스를 이용해 **코드 스멜을 찾아냅니다**
2. 이 카탈로그에서 **대응하는 리팩터링을 찾습니다**
3. **절차를 따라 한 단계씩 진행합니다**
4. **각 단계마다 테스트**를 실행해 동작이 유지되는지 확인합니다

**철칙**: 어떤 절차가 10분 이상 걸린다면 더 작은 단계로 나누세요.

---

## 가장 자주 쓰이는 리팩터링

### 메서드 추출 (Extract Method)

**사용 시점**: 긴 메서드, 중복 코드, 개념에 이름을 붙이고 싶을 때

**동기**: 코드 조각을 목적을 드러내는 이름을 가진 메서드로 떼어 냅니다.

**절차**:
1. 하는 일(어떻게가 아니라)을 따서 이름 붙인 새 메서드를 만듭니다
2. 코드 조각을 새 메서드로 복사합니다
3. 코드 조각에서 사용하는 로컬 변수를 찾아냅니다
4. 로컬 변수를 매개변수로 전달합니다(또는 메서드 안에서 선언합니다)
5. 반환값을 적절히 처리합니다
6. 원래 코드 조각을 새 메서드 호출로 바꿉니다
7. 테스트합니다

**Before**:
```javascript
function printOwing(invoice) {
  let outstanding = 0;

  console.log("***********************");
  console.log("**** Customer Owes ****");
  console.log("***********************");

  // 미납액 계산
  for (const order of invoice.orders) {
    outstanding += order.amount;
  }

  // 상세 출력
  console.log(`name: ${invoice.customer}`);
  console.log(`amount: ${outstanding}`);
}
```

**After**:
```javascript
function printOwing(invoice) {
  printBanner();
  const outstanding = calculateOutstanding(invoice);
  printDetails(invoice, outstanding);
}

function printBanner() {
  console.log("***********************");
  console.log("**** Customer Owes ****");
  console.log("***********************");
}

function calculateOutstanding(invoice) {
  return invoice.orders.reduce((sum, order) => sum + order.amount, 0);
}

function printDetails(invoice, outstanding) {
  console.log(`name: ${invoice.customer}`);
  console.log(`amount: ${outstanding}`);
}
```

---

### 메서드 인라인 (Inline Method)

**사용 시점**: 메서드 본문이 이름만큼이나 명확할 때, 과도한 위임이 보일 때

**동기**: 메서드가 가치를 더하지 못한다면 불필요한 간접 참조를 제거합니다.

**절차**:
1. 메서드가 다형적이지 않은지 확인합니다
2. 메서드의 모든 호출 지점을 찾습니다
3. 각 호출을 메서드 본문으로 바꿉니다
4. 바꿀 때마다 테스트합니다
5. 메서드 정의를 삭제합니다

**Before**:
```javascript
function getRating(driver) {
  return moreThanFiveLateDeliveries(driver) ? 2 : 1;
}

function moreThanFiveLateDeliveries(driver) {
  return driver.numberOfLateDeliveries > 5;
}
```

**After**:
```javascript
function getRating(driver) {
  return driver.numberOfLateDeliveries > 5 ? 2 : 1;
}
```

---

### 변수 추출 (Extract Variable)

**사용 시점**: 복잡하고 이해하기 어려운 식이 있을 때

**동기**: 복잡한 식의 일부에 이름을 붙입니다.

**절차**:
1. 식에 부수 효과가 없는지 확인합니다
2. 불변 변수를 선언합니다
3. 식(또는 식의 일부)의 결과를 그 변수에 대입합니다
4. 원래 식을 변수로 바꿉니다
5. 테스트합니다

**Before**:
```javascript
return order.quantity * order.itemPrice -
  Math.max(0, order.quantity - 500) * order.itemPrice * 0.05 +
  Math.min(order.quantity * order.itemPrice * 0.1, 100);
```

**After**:
```javascript
const basePrice = order.quantity * order.itemPrice;
const quantityDiscount = Math.max(0, order.quantity - 500) * order.itemPrice * 0.05;
const shipping = Math.min(basePrice * 0.1, 100);
return basePrice - quantityDiscount + shipping;
```

---

### 변수 인라인 (Inline Variable)

**사용 시점**: 변수 이름이 식 이상의 정보를 전달하지 못할 때

**동기**: 불필요한 간접 참조를 제거합니다.

**절차**:
1. 우변에 부수 효과가 없는지 확인합니다
2. 변수가 불변이 아니라면 불변으로 만들고 테스트합니다
3. 첫 번째 참조 지점을 찾아 식으로 바꿉니다
4. 테스트합니다
5. 모든 참조 지점에 대해 반복합니다
6. 선언과 대입을 삭제합니다
7. 테스트합니다

---

### 변수 이름 바꾸기 (Rename Variable)

**사용 시점**: 이름이 목적을 명확히 전달하지 못할 때

**동기**: 클린 코드에는 좋은 이름이 필수입니다.

**절차**:
1. 변수가 널리 쓰인다면 캡슐화를 검토합니다
2. 모든 참조 지점을 찾습니다
3. 각 참조 지점을 변경합니다
4. 테스트합니다

**Tips**:
- 의도를 드러내는 이름을 사용합니다
- 약어를 피합니다
- 도메인 용어를 사용합니다

```javascript
// 나쁜 예
const d = 30;
const x = users.filter(u => u.a);

// 좋은 예
const daysSinceLastLogin = 30;
const activeUsers = users.filter(user => user.isActive);
```

---

### 함수 선언 변경 (Change Function Declaration)

**사용 시점**: 함수 이름이 목적을 드러내지 못할 때, 매개변수 변경이 필요할 때

**동기**: 좋은 함수 이름은 코드를 스스로 설명하게 만듭니다.

**절차 (간단 버전)**:
1. 불필요한 매개변수를 제거합니다
2. 이름을 변경합니다
3. 필요한 매개변수를 추가합니다
4. 테스트합니다

**절차 (마이그레이션 버전 — 복잡한 변경용)**:
1. 매개변수를 제거한다면 그것이 사용되지 않는지 확인합니다
2. 원하는 선언을 가진 새 함수를 만듭니다
3. 이전 함수가 새 함수를 호출하도록 합니다
4. 테스트합니다
5. 호출 측을 새 함수를 사용하도록 변경합니다
6. 각 변경 후 테스트합니다
7. 이전 함수를 삭제합니다

**Before**:
```javascript
function circum(radius) {
  return 2 * Math.PI * radius;
}
```

**After**:
```javascript
function circumference(radius) {
  return 2 * Math.PI * radius;
}
```

---

### 변수 캡슐화 (Encapsulate Variable)

**사용 시점**: 데이터에 여러 곳에서 직접 접근하고 있을 때

**동기**: 데이터 조작을 위한 명확한 접근 지점을 제공합니다.

**절차**:
1. getter와 setter 함수를 만듭니다
2. 모든 참조 지점을 찾습니다
3. 읽기를 getter로 바꿉니다
4. 쓰기를 setter로 바꿉니다
5. 각 변경 후 테스트합니다
6. 변수의 가시성을 제한합니다

**Before**:
```javascript
let defaultOwner = { firstName: "Martin", lastName: "Fowler" };

// 여러 곳에서 사용됨
spaceship.owner = defaultOwner;
```

**After**:
```javascript
let defaultOwnerData = { firstName: "Martin", lastName: "Fowler" };

function defaultOwner() { return defaultOwnerData; }
function setDefaultOwner(arg) { defaultOwnerData = arg; }

spaceship.owner = defaultOwner();
```

---

### 매개변수 객체 도입 (Introduce Parameter Object)

**사용 시점**: 여러 매개변수가 자주 함께 등장할 때

**동기**: 자연스럽게 묶여야 할 데이터를 그룹화합니다.

**절차**:
1. 그룹화한 매개변수용 새 클래스/구조체를 만듭니다
2. 테스트합니다
3. "함수 선언 변경"으로 새 객체를 추가합니다
4. 테스트합니다
5. 그룹 안의 각 매개변수에 대해, 함수에서 제거하고 새 객체를 사용하도록 합니다
6. 각 변경 후 테스트합니다

**Before**:
```javascript
function amountInvoiced(startDate, endDate) { ... }
function amountReceived(startDate, endDate) { ... }
function amountOverdue(startDate, endDate) { ... }
```

**After**:
```javascript
class DateRange {
  constructor(start, end) {
    this.start = start;
    this.end = end;
  }
}

function amountInvoiced(dateRange) { ... }
function amountReceived(dateRange) { ... }
function amountOverdue(dateRange) { ... }
```

---

### 함수들을 클래스로 묶기 (Combine Functions into Class)

**사용 시점**: 여러 함수가 같은 데이터를 다루고 있을 때

**동기**: 함수를 그것이 다루는 데이터와 함께 묶습니다.

**절차**:
1. 공통 데이터에 "레코드 캡슐화 (Encapsulate Record)"를 적용합니다
2. 각 함수를 클래스 안으로 옮깁니다
3. 옮길 때마다 테스트합니다
4. 데이터 인수를 클래스 필드 사용으로 바꿉니다

**Before**:
```javascript
function base(reading) { ... }
function taxableCharge(reading) { ... }
function calculateBaseCharge(reading) { ... }
```

**After**:
```javascript
class Reading {
  constructor(data) { this._data = data; }

  get base() { ... }
  get taxableCharge() { ... }
  get calculateBaseCharge() { ... }
}
```

---

### 단계 쪼개기 (Split Phase)

**사용 시점**: 코드가 서로 다른 두 가지 일을 다루고 있을 때

**동기**: 코드를 명확한 경계를 가진 별도의 단계로 분리합니다.

**절차**:
1. 두 번째 단계용 함수를 만듭니다
2. 테스트합니다
3. 단계 사이의 중간 데이터 구조를 도입합니다
4. 테스트합니다
5. 첫 번째 단계를 독립된 함수로 추출합니다
6. 테스트합니다

**Before**:
```javascript
function priceOrder(product, quantity, shippingMethod) {
  const basePrice = product.basePrice * quantity;
  const discount = Math.max(quantity - product.discountThreshold, 0)
    * product.basePrice * product.discountRate;
  const shippingPerCase = (basePrice > shippingMethod.discountThreshold)
    ? shippingMethod.discountedFee : shippingMethod.feePerCase;
  const shippingCost = quantity * shippingPerCase;
  return basePrice - discount + shippingCost;
}
```

**After**:
```javascript
function priceOrder(product, quantity, shippingMethod) {
  const priceData = calculatePricingData(product, quantity);
  return applyShipping(priceData, shippingMethod);
}

function calculatePricingData(product, quantity) {
  const basePrice = product.basePrice * quantity;
  const discount = Math.max(quantity - product.discountThreshold, 0)
    * product.basePrice * product.discountRate;
  return { basePrice, quantity, discount };
}

function applyShipping(priceData, shippingMethod) {
  const shippingPerCase = (priceData.basePrice > shippingMethod.discountThreshold)
    ? shippingMethod.discountedFee : shippingMethod.feePerCase;
  const shippingCost = priceData.quantity * shippingPerCase;
  return priceData.basePrice - priceData.discount + shippingCost;
}
```

---

## 기능 옮기기

### 메서드 옮기기 (Move Method)

**사용 시점**: 메서드가 자신의 클래스보다 다른 클래스의 기능을 더 많이 사용할 때

**동기**: 함수를 가장 많이 사용하는 데이터 가까이에 둡니다.

**절차**:
1. 자기 클래스 안에서 메서드가 사용하는 프로그램 요소를 모두 조사합니다
2. 메서드가 다형적인지 확인합니다
3. 대상 클래스에 메서드를 복사합니다
4. 새 컨텍스트에 맞게 조정합니다
5. 원래 메서드가 대상에 위임하도록 합니다
6. 테스트합니다
7. 원래 메서드의 삭제를 검토합니다

---

### 필드 옮기기 (Move Field)

**사용 시점**: 필드가 다른 클래스에서 더 많이 쓰일 때

**동기**: 데이터를 그것을 사용하는 함수와 함께 둡니다.

**절차**:
1. 아직이라면 필드를 캡슐화합니다
2. 테스트합니다
3. 대상에 필드를 만듭니다
4. 참조 지점을 대상 필드를 사용하도록 갱신합니다
5. 테스트합니다
6. 원래 필드를 삭제합니다

---

### 문장을 함수로 옮기기 (Move Statements into Function)

**사용 시점**: 같은 코드가 항상 특정 함수 호출과 함께 나타날 때

**동기**: 반복되는 코드를 함수 안으로 옮겨 중복을 제거합니다.

**절차**:
1. 아직이라면 반복 코드를 함수로 추출합니다
2. 그 함수 안으로 문장을 옮깁니다
3. 테스트합니다
4. 호출 측에서 단독 문장이 불필요해지면 삭제합니다

---

### 문장을 호출한 곳으로 옮기기 (Move Statements to Callers)

**사용 시점**: 공통 동작이 호출 측마다 달라질 때

**동기**: 동작을 바꿔야 한다면 함수 밖으로 옮깁니다.

**절차**:
1. 옮길 코드에 "메서드 추출"을 적용합니다
2. 원래 함수에 "메서드 인라인"을 적용합니다
3. 인라인된 호출을 삭제합니다
4. 추출한 코드를 각 호출 측으로 옮깁니다
5. 테스트합니다

---

## 데이터 조직화

### 기본형을 객체로 바꾸기 (Replace Primitive with Object)

**사용 시점**: 데이터 항목에 단순한 값 이상의 동작이 필요할 때

**동기**: 데이터를 동작과 함께 캡슐화합니다.

**절차**:
1. "변수 캡슐화"를 적용합니다
2. 단순한 값 클래스를 만듭니다
3. setter를 새 인스턴스 생성으로 변경합니다
4. getter를 값 반환으로 변경합니다
5. 테스트합니다
6. 새 클래스에 더 풍부한 동작을 추가합니다

**Before**:
```javascript
class Order {
  constructor(data) {
    this.priority = data.priority; // 문자열: "high", "rush" 등
  }
}

// 사용 지점
if (order.priority === "high" || order.priority === "rush") { ... }
```

**After**:
```javascript
class Priority {
  constructor(value) {
    if (!Priority.legalValues().includes(value))
      throw new Error(`Invalid priority: ${value}`);
    this._value = value;
  }

  static legalValues() { return ['low', 'normal', 'high', 'rush']; }
  get value() { return this._value; }

  higherThan(other) {
    return Priority.legalValues().indexOf(this._value) >
           Priority.legalValues().indexOf(other._value);
  }
}

// 사용 지점
if (order.priority.higherThan(new Priority("normal"))) { ... }
```

---

### 임시 변수를 질의 함수로 바꾸기 (Replace Temp with Query)

**사용 시점**: 임시 변수가 식의 결과를 담고 있을 때

**동기**: 식을 함수로 떼어 내어 코드를 명확하게 만듭니다.

**절차**:
1. 변수가 한 번만 대입되는지 확인합니다
2. 대입의 우변을 메서드로 추출합니다
3. 임시 변수의 참조 지점을 메서드 호출로 바꿉니다
4. 테스트합니다
5. 임시 변수의 선언과 대입을 삭제합니다

**Before**:
```javascript
const basePrice = this._quantity * this._itemPrice;
if (basePrice > 1000) {
  return basePrice * 0.95;
} else {
  return basePrice * 0.98;
}
```

**After**:
```javascript
get basePrice() {
  return this._quantity * this._itemPrice;
}

// 메서드 안
if (this.basePrice > 1000) {
  return this.basePrice * 0.95;
} else {
  return this.basePrice * 0.98;
}
```

---

## 조건문 단순화

### 조건문 분해 (Decompose Conditional)

**사용 시점**: 복잡한 조건 분기(if-then-else)가 있을 때

**동기**: 조건과 동작을 추출해 의도를 명확히 합니다.

**절차**:
1. 조건 부분에 "메서드 추출"을 적용합니다
2. then 절에 "메서드 추출"을 적용합니다
3. else 절(있다면)에 "메서드 추출"을 적용합니다

**Before**:
```javascript
if (!aDate.isBefore(plan.summerStart) && !aDate.isAfter(plan.summerEnd)) {
  charge = quantity * plan.summerRate;
} else {
  charge = quantity * plan.regularRate + plan.regularServiceCharge;
}
```

**After**:
```javascript
if (isSummer(aDate, plan)) {
  charge = summerCharge(quantity, plan);
} else {
  charge = regularCharge(quantity, plan);
}

function isSummer(date, plan) {
  return !date.isBefore(plan.summerStart) && !date.isAfter(plan.summerEnd);
}

function summerCharge(quantity, plan) {
  return quantity * plan.summerRate;
}

function regularCharge(quantity, plan) {
  return quantity * plan.regularRate + plan.regularServiceCharge;
}
```

---

### 조건식 통합 (Consolidate Conditional Expression)

**사용 시점**: 같은 결과를 반환하는 조건이 여러 개 있을 때

**동기**: 그 조건들이 하나의 검사라는 점을 분명히 합니다.

**절차**:
1. 조건에 부수 효과가 없는지 확인합니다
2. 조건을 `and` 또는 `or`로 결합합니다
3. 결합한 조건에 "메서드 추출"을 검토합니다

**Before**:
```javascript
if (employee.seniority < 2) return 0;
if (employee.monthsDisabled > 12) return 0;
if (employee.isPartTime) return 0;
```

**After**:
```javascript
if (isNotEligibleForDisability(employee)) return 0;

function isNotEligibleForDisability(employee) {
  return employee.seniority < 2 ||
         employee.monthsDisabled > 12 ||
         employee.isPartTime;
}
```

---

### 중첩 조건문을 보호 구문으로 바꾸기 (Replace Nested Conditional with Guard Clauses)

**사용 시점**: 중첩 조건 분기가 깊어 흐름을 따라가기 어려울 때

**동기**: 특수 케이스에 보호 구문을 사용해 정상 흐름을 명확하게 유지합니다.

**절차**:
1. 특수 케이스 조건을 찾습니다
2. 그것들을 조기 return하는 보호 구문으로 바꿉니다
3. 각 변경 후 테스트합니다

**Before**:
```javascript
function payAmount(employee) {
  let result;
  if (employee.isSeparated) {
    result = { amount: 0, reasonCode: "SEP" };
  } else {
    if (employee.isRetired) {
      result = { amount: 0, reasonCode: "RET" };
    } else {
      result = calculateNormalPay(employee);
    }
  }
  return result;
}
```

**After**:
```javascript
function payAmount(employee) {
  if (employee.isSeparated) return { amount: 0, reasonCode: "SEP" };
  if (employee.isRetired) return { amount: 0, reasonCode: "RET" };
  return calculateNormalPay(employee);
}
```

---

### 조건문을 다형성으로 바꾸기 (Replace Conditional with Polymorphism)

**사용 시점**: 타입에 기반한 switch/case, 타입마다 달라지는 조건 로직

**동기**: 객체 스스로 동작을 책임지게 합니다.

**절차**:
1. 클래스 계층을 만듭니다(없다면)
2. 객체 생성에 팩토리 함수를 사용합니다
3. 조건 로직을 슈퍼클래스의 메서드로 옮깁니다
4. 케이스마다 서브클래스 메서드를 만듭니다
5. 원래 조건문을 삭제합니다

**Before**:
```javascript
function plumages(birds) {
  return birds.map(b => plumage(b));
}

function plumage(bird) {
  switch (bird.type) {
    case 'EuropeanSwallow':
      return "average";
    case 'AfricanSwallow':
      return (bird.numberOfCoconuts > 2) ? "tired" : "average";
    case 'NorwegianBlueParrot':
      return (bird.voltage > 100) ? "scorched" : "beautiful";
    default:
      return "unknown";
  }
}
```

**After**:
```javascript
class Bird {
  get plumage() { return "unknown"; }
}

class EuropeanSwallow extends Bird {
  get plumage() { return "average"; }
}

class AfricanSwallow extends Bird {
  get plumage() {
    return (this.numberOfCoconuts > 2) ? "tired" : "average";
  }
}

class NorwegianBlueParrot extends Bird {
  get plumage() {
    return (this.voltage > 100) ? "scorched" : "beautiful";
  }
}

function createBird(data) {
  switch (data.type) {
    case 'EuropeanSwallow': return new EuropeanSwallow(data);
    case 'AfricanSwallow': return new AfricanSwallow(data);
    case 'NorwegianBlueParrot': return new NorwegianBlueParrot(data);
    default: return new Bird(data);
  }
}
```

---

### 특수 케이스 도입 (Introduce Special Case / Null Object)

**사용 시점**: 특수 케이스에 대한 null 검사가 반복될 때

**동기**: 특수 케이스를 처리하는 특수 객체를 반환합니다.

**절차**:
1. 기대되는 인터페이스를 가진 특수 케이스 클래스를 만듭니다
2. isSpecialCase 검사를 추가합니다
3. 팩토리 메서드를 도입합니다
4. null 검사를 특수 케이스 객체 사용으로 바꿉니다
5. 테스트합니다

**Before**:
```javascript
const customer = site.customer;
// ... 여러 곳에서 검사
if (customer === "unknown") {
  customerName = "occupant";
} else {
  customerName = customer.name;
}
```

**After**:
```javascript
class UnknownCustomer {
  get name() { return "occupant"; }
  get billingPlan() { return registry.defaultPlan; }
}

// 팩토리 메서드
function customer(site) {
  return site.customer === "unknown"
    ? new UnknownCustomer()
    : site.customer;
}

// 사용 지점 — null 검사 불필요
const customerName = customer.name;
```

---

## API 리팩터링

### 질의 함수와 변경 함수 분리 (Separate Query from Modifier)

**사용 시점**: 함수가 값을 반환하면서 동시에 부수 효과도 가질 때

**동기**: 어떤 연산에 부수 효과가 있는지 명확히 합니다.

**절차**:
1. 새 질의 함수를 만듭니다
2. 원래 함수의 반환값 로직을 복사합니다
3. 원래 함수를 void를 반환하도록 변경합니다
4. 반환값을 사용하던 호출을 바꿉니다
5. 테스트합니다

**Before**:
```javascript
function alertForMiscreant(people) {
  for (const p of people) {
    if (p === "Don") {
      setOffAlarms();
      return "Don";
    }
    if (p === "John") {
      setOffAlarms();
      return "John";
    }
  }
  return "";
}
```

**After**:
```javascript
function findMiscreant(people) {
  for (const p of people) {
    if (p === "Don") return "Don";
    if (p === "John") return "John";
  }
  return "";
}

function alertForMiscreant(people) {
  if (findMiscreant(people) !== "") setOffAlarms();
}
```

---

### 함수 매개변수화 (Parameterize Function)

**사용 시점**: 비슷한 처리를 서로 다른 값으로 수행하는 함수가 여러 개 있을 때

**동기**: 매개변수를 추가해 중복을 제거합니다.

**절차**:
1. 함수 하나를 고릅니다
2. 변하는 리터럴용 매개변수를 추가합니다
3. 본문을 그 매개변수를 사용하도록 변경합니다
4. 테스트합니다
5. 호출 측을 매개변수화된 버전을 사용하도록 변경합니다
6. 불필요해진 함수를 삭제합니다

**Before**:
```javascript
function tenPercentRaise(person) {
  person.salary = person.salary * 1.10;
}

function fivePercentRaise(person) {
  person.salary = person.salary * 1.05;
}
```

**After**:
```javascript
function raise(person, factor) {
  person.salary = person.salary * (1 + factor);
}

// 사용 지점
raise(person, 0.10);
raise(person, 0.05);
```

---

### 플래그 인수 제거 (Remove Flag Argument)

**사용 시점**: 함수의 동작을 전환하는 불리언 매개변수가 있을 때

**동기**: 별도의 함수를 통해 동작을 명시적으로 드러냅니다.

**절차**:
1. 플래그 값마다 명시적인 함수를 만듭니다
2. 각 호출을 적절한 새 함수로 바꿉니다
3. 각 변경 후 테스트합니다
4. 원래 함수를 삭제합니다

**Before**:
```javascript
function bookConcert(customer, isPremium) {
  if (isPremium) {
    // 프리미엄 예약 로직
  } else {
    // 일반 예약 로직
  }
}

bookConcert(customer, true);
bookConcert(customer, false);
```

**After**:
```javascript
function bookPremiumConcert(customer) {
  // 프리미엄 예약 로직
}

function bookRegularConcert(customer) {
  // 일반 예약 로직
}

bookPremiumConcert(customer);
bookRegularConcert(customer);
```

---

## 상속 다루기

### 메서드 올리기 (Pull Up Method)

**사용 시점**: 같은 메서드가 여러 서브클래스에 있을 때

**동기**: 클래스 계층 안의 중복을 제거합니다.

**절차**:
1. 메서드들이 동일한지 확인합니다
2. 시그니처가 같은지 확인합니다
3. 슈퍼클래스에 새 메서드를 만듭니다
4. 서브클래스 하나에서 본문을 복사합니다
5. 서브클래스 하나에서 메서드를 삭제하고 테스트합니다
6. 다른 서브클래스의 메서드도 차례로 삭제하고 그때마다 테스트합니다

---

### 메서드 내리기 (Push Down Method)

**사용 시점**: 일부 서브클래스에만 관련된 동작이 있을 때

**동기**: 메서드를 사용되는 곳에 둡니다.

**절차**:
1. 메서드를 필요로 하는 각 서브클래스에 복사합니다
2. 슈퍼클래스에서 메서드를 삭제합니다
3. 테스트합니다
4. 필요로 하지 않는 서브클래스에서는 삭제합니다
5. 테스트합니다

---

### 서브클래스를 위임으로 바꾸기 (Replace Subclass with Delegate)

**사용 시점**: 상속이 잘못 사용되었거나 더 많은 유연성이 필요할 때

**동기**: 적절한 상황에서는 상속보다 컴포지션을 우선합니다.

**절차**:
1. 위임 대상용 빈 클래스를 만듭니다
2. 위임 대상을 담을 필드를 호스트 클래스에 추가합니다
3. 호스트에서 호출되는 위임 대상의 생성자를 만듭니다
4. 기능을 위임 대상으로 옮깁니다
5. 옮길 때마다 테스트합니다
6. 상속을 위임으로 바꿉니다

---

## 클래스 추출 (Extract Class)

**사용 시점**: 여러 책임을 가진 큰 클래스가 있을 때

**동기**: 클래스를 분할해 단일 책임을 유지합니다.

**절차**:
1. 책임을 어떻게 나눌지 결정합니다
2. 새 클래스를 만듭니다
3. 필드를 원래 클래스에서 새 클래스로 옮깁니다
4. 테스트합니다
5. 메서드를 원래 클래스에서 새 클래스로 옮깁니다
6. 옮길 때마다 테스트합니다
7. 두 클래스를 다시 살펴보고 필요하면 이름을 바꿉니다
8. 새 클래스를 어떻게 공개할지 결정합니다

**Before**:
```javascript
class Person {
  get name() { return this._name; }
  set name(arg) { this._name = arg; }
  get officeAreaCode() { return this._officeAreaCode; }
  set officeAreaCode(arg) { this._officeAreaCode = arg; }
  get officeNumber() { return this._officeNumber; }
  set officeNumber(arg) { this._officeNumber = arg; }

  get telephoneNumber() {
    return `(${this._officeAreaCode}) ${this._officeNumber}`;
  }
}
```

**After**:
```javascript
class Person {
  constructor() {
    this._telephoneNumber = new TelephoneNumber();
  }
  get name() { return this._name; }
  set name(arg) { this._name = arg; }
  get telephoneNumber() { return this._telephoneNumber.toString(); }
  get officeAreaCode() { return this._telephoneNumber.areaCode; }
  set officeAreaCode(arg) { this._telephoneNumber.areaCode = arg; }
}

class TelephoneNumber {
  get areaCode() { return this._areaCode; }
  set areaCode(arg) { this._areaCode = arg; }
  get number() { return this._number; }
  set number(arg) { this._number = arg; }
  toString() { return `(${this._areaCode}) ${this._number}`; }
}
```

---

## 빠른 참조: 스멜에서 리팩터링으로

| 코드 스멜 | 주요 리팩터링 | 대안 |
|------------|-------------------|-------------|
| 긴 메서드 (Long Method) | 메서드 추출 | 임시 변수를 질의 함수로 바꾸기 |
| 중복 코드 (Duplicate Code) | 메서드 추출 | 메서드 올리기 |
| 거대한 클래스 (Large Class) | 클래스 추출 | 서브클래스 추출 |
| 긴 매개변수 목록 (Long Parameter List) | 매개변수 객체 도입 | 객체 통째로 넘기기 |
| 기능 편애 (Feature Envy) | 메서드 옮기기 | 메서드 추출 + 옮기기 |
| 데이터 뭉치 (Data Clumps) | 클래스 추출 | 매개변수 객체 도입 |
| 기본형 집착 (Primitive Obsession) | 기본형을 객체로 바꾸기 | 타입 코드 바꾸기 |
| switch 문 (Switch Statements) | 조건문을 다형성으로 바꾸기 | 타입 코드 바꾸기 |
| 임시 필드 (Temporary Field) | 클래스 추출 | Null 객체 도입 |
| 메시지 체인 (Message Chains) | 위임 숨기기 | 메서드 추출 |
| 중개자 (Middle Man) | 중개자 제거 | 메서드 인라인 |
| 뒤엉킨 변경 (Divergent Change) | 클래스 추출 | 단계 쪼개기 |
| 산탄총 수술 (Shotgun Surgery) | 메서드 옮기기 | 클래스 인라인 |
| 죽은 코드 (Dead Code) | 죽은 코드 제거 | - |
| 추측성 일반화 (Speculative Generality) | 계층 평탄화 | 클래스 인라인 |

---

## 참고 문헌

- Fowler, M. (2018). *Refactoring: Improving the Design of Existing Code* (2nd ed.)
- 온라인 카탈로그: https://refactoring.com/catalog/
