<!-- i18n-source: 01-slash-commands/pr.md -->
<!-- i18n-source-sha: 7f2e773 -->
<!-- i18n-date: 2026-10-26 -->

---
description: 코드를 정리하고, 변경 사항을 스테이징하고, 풀 리퀘스트를 준비합니다
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(npm test:*), Bash(npm run lint:*)
---

# 풀 리퀘스트 준비 체크리스트

PR을 만들기 전에 다음 단계를 실행합니다:

1. 린터 실행: `prettier --write .`
2. 테스트 실행: `npm test`
3. git 차이 검토: `git diff HEAD`
4. 변경 사항 스테이징: `git add .`
5. Conventional Commits를 따르는 커밋 메시지 작성:
   - `fix:` 버그 수정
   - `feat:` 새 기능
   - `docs:` 문서
   - `refactor:` 코드 재구성
   - `test:` 테스트 추가
   - `chore:` 유지 보수

6. PR 요약 생성. 다음 항목을 포함합니다:
   - 무엇을 변경했는지
   - 왜 변경했는지
   - 수행한 테스트
   - 예상되는 영향

---
**Last Updated**: April 9, 2026
