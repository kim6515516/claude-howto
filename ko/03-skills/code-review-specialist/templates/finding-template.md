<!-- i18n-source: 03-skills/code-review-specialist/templates/finding-template.md -->
<!-- i18n-source-sha: 6d1e0ae -->
<!-- i18n-date: 2026-10-26 -->

# 코드 리뷰 지적 사항 템플릿

코드 리뷰 중에 발견한 각 문제를 문서화할 때 이 템플릿을 사용합니다.

---

## Issue: [TITLE]

### 심각도
- [ ] Critical(배포를 차단)
- [ ] High(머지 전에 수정해야 함)
- [ ] Medium(조기에 수정해야 함)
- [ ] Low(있으면 좋음)

### 카테고리
- [ ] Security
- [ ] Performance
- [ ] Code Quality
- [ ] Maintainability
- [ ] Testing
- [ ] Design Pattern
- [ ] Documentation

### 위치
**File:** `src/components/UserCard.tsx`

**Lines:** 45-52

**Function/Method:** `renderUserDetails()`

### 문제 설명

**What:** 문제의 내용을 기술합니다.

**Why it matters:** 영향과 수정이 필요한 이유를 설명합니다.

**Current behavior:** 문제가 있는 코드나 동작을 보여 줍니다.

**Expected behavior:** 대신 기대되는 동작을 기술합니다.

### 코드 예시

#### 현재 상태(문제 있음)

```typescript
// N+1 쿼리 문제를 보여 줍니다
const users = fetchUsers();
users.forEach(user => {
  const posts = fetchUserPosts(user.id); // 사용자마다 쿼리!
  renderUserPosts(posts);
});
```

#### 수정안

```typescript
// JOIN 쿼리로 최적화
const usersWithPosts = fetchUsersWithPosts();
usersWithPosts.forEach(({ user, posts }) => {
  renderUserPosts(posts);
});
```

### 영향 분석

| Aspect | Impact | Severity |
|--------|--------|----------|
| Performance | 사용자 20명에 쿼리 100건 이상 | High |
| User Experience | 페이지 로딩이 느림 | High |
| Scalability | 규모가 커지면 무너짐 | Critical |
| Maintainability | 디버깅이 어려움 | Medium |

### 관련 문제

- `AdminUserList.tsx` 120번째 줄에 유사한 문제
- 관련 PR: #456
- 관련 이슈: #789

### 추가 자료

- [N+1 Query Problem](https://en.wikipedia.org/wiki/N%2B1_problem)
- [Database Join Documentation](https://docs.example.com/joins)

### 리뷰어 메모

- 이 코드베이스에서 자주 보이는 패턴입니다
- 코드 스타일 가이드에 추가하는 것을 검토합니다
- 헬퍼 함수를 만들 가치가 있을 수 있습니다

### 작성자 응답(피드백용)

*코드 작성자가 기입합니다:*

- [ ] 수정 구현 커밋: `abc123`
- [ ] 수정 상태: Complete / In Progress / Needs Discussion
- [ ] 질문이나 우려 사항: (기술)

---

## 지적 통계(리뷰어용)

여러 지적 사항을 리뷰할 때는 다음을 추적합니다.

- **Total Issues Found:** X
- **Critical:** X
- **High:** X
- **Medium:** X
- **Low:** X

**Recommendation:** ✅ Approve / ⚠️ Request Changes / 🔄 Needs Discussion

**Overall Code Quality:** 1-5 stars
