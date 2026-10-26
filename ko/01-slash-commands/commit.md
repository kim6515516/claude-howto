<!-- i18n-source: 01-slash-commands/commit.md -->
<!-- i18n-source-sha: 7f2e773 -->
<!-- i18n-date: 2026-10-26 -->

---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*)
argument-hint: [message]
description: 컨텍스트를 바탕으로 git 커밋을 만듭니다
---

## 컨텍스트

- 현재 git 상태: !`git status`
- 현재 git 차이: !`git diff HEAD`
- 현재 브랜치: !`git branch --show-current`
- 최근 커밋: !`git log --oneline -10`

## 작업

위의 변경 내용을 바탕으로 git 커밋을 하나 만듭니다.

인수로 메시지가 지정된 경우에는 그 메시지를 사용합니다: $ARGUMENTS

그렇지 않으면 변경 내용을 분석하고 Conventional Commits 형식에 따라 적절한 커밋 메시지를 작성합니다:
- `feat:` 새 기능
- `fix:` 버그 수정
- `docs:` 문서 변경
- `refactor:` 코드 리팩터링
- `test:` 테스트 추가
- `chore:` 유지보수 작업

---
**Last Updated**: April 9, 2026
