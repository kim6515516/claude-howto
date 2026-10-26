<!-- i18n-source: 01-slash-commands/push-all.md -->
<!-- i18n-source-sha: 7f2e773 -->
<!-- i18n-date: 2026-10-26 -->

---
description: 모든 변경을 스테이징, 커밋하고 원격으로 push한다(취급 주의)
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git push:*), Bash(git diff:*), Bash(git log:*), Bash(git pull:*)
---

# 모두 커밋·push하기

⚠️ **주의**: 모든 변경을 스테이징·커밋하고 원격으로 push한다. 모든 변경이 하나의 묶음이라고 확신할 수 있을 때만 사용할 것.

## 워크플로

### 1. 변경 분석

병렬로 실행한다:
- `git status` — 변경/추가/삭제/추적되지 않는 파일 표시
- `git diff --stat` — 변경 통계 표시
- `git log -1 --oneline` — 메시지 스타일 참고를 위해 최근 커밋 표시

### 2. 안전성 점검

**❌ 발견 시 STOP하고 WARN을 내야 하는 항목:**
- 시크릿: `.env*`, `*.key`, `*.pem`, `credentials.json`, `secrets.yaml`, `id_rsa`, `*.p12`, `*.pfx`, `*.cer`
- API 키: `*_API_KEY`, `*_SECRET`, `*_TOKEN` 등의 변수에 실제 값이 들어 있는 것(`your-api-key`, `xxx`, `placeholder` 같은 플레이스홀더가 아닌 것)
- 큰 파일: Git LFS 없는 `>10MB`
- 빌드 산출물: `node_modules/`, `dist/`, `build/`, `__pycache__/`, `*.pyc`, `.venv/`
- 임시 파일: `.DS_Store`, `thumbs.db`, `*.swp`, `*.tmp`

**API 키 검증:**
변경된 파일에 다음과 같은 패턴이 없는지 확인한다:
```bash
OPENAI_API_KEY=sk-proj-xxxxx  # ❌ 실제 키 감지!
AWS_SECRET_KEY=AKIA...         # ❌ 실제 키 감지!
STRIPE_API_KEY=sk_live_...    # ❌ 실제 키 감지!

# ✅ 허용되는 플레이스홀더:
API_KEY=your-api-key-here
SECRET_KEY=placeholder
TOKEN=xxx
API_KEY=<your-key>
SECRET=${YOUR_SECRET}
```

**✅ 확인 사항:**
- `.gitignore`가 적절히 설정되어 있다
- 머지 충돌이 없다
- 올바른 브랜치다(main/master인 경우 경고)
- API 키는 플레이스홀더뿐이다

### 3. 확인 요청

요약을 제시한다:
```
📊 Changes Summary:
- X files modified, Y added, Z deleted
- Total: +AAA insertions, -BBB deletions

🔒 Safety: ✅ No secrets | ✅ No large files | ⚠️ [warnings]
🌿 Branch: [name] → origin/[name]

I will: git add . → commit → push

Type 'yes' to proceed or 'no' to cancel.
```

**명시적인 "yes"를 기다린 뒤 진행한다.**

### 4. 실행(확인 후)

순서대로 실행한다:
```bash
git add .
git status  # 스테이징 확인
```

### 5. 커밋 메시지 생성

변경을 분석해 Conventional Commits 형식의 커밋을 만든다:

**형식:**
```
[type]: Brief summary (max 72 characters)

- Key change 1
- Key change 2
- Key change 3
```

**Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `build`, `ci`

**예:**
```
docs: Update concept README files with comprehensive documentation

- Add architecture diagrams and tables
- Include practical examples
- Expand best practices sections
```

### 6. 커밋과 push

```bash
git commit -m "$(cat <<'EOF'
[Generated commit message]
EOF
)"
git push  # 실패 시: git pull --rebase && git push
git log -1 --oneline --decorate  # 확인
```

### 7. 성공 알림

```
✅ Successfully pushed to remote!

Commit: [hash] [message]
Branch: [branch] → origin/[branch]
Files changed: X (+insertions, -deletions)
```

## 오류 처리

- **git add 실패**: 권한, 잠긴 파일, 저장소 초기화 여부를 확인
- **git commit 실패**: pre-commit 훅을 수정하고 git config(user.name/email)를 확인
- **git push 실패**:
  - non-fast-forward: `git pull --rebase && git push`
  - 원격 브랜치 없음: `git push -u origin [branch]`
  - 보호 브랜치: PR 워크플로를 사용

## 사용해야 할 때

✅ **적합한 상황:**
- 여러 파일에 걸친 문서 업데이트
- 테스트와 문서를 동반한 기능 추가
- 여러 파일에 걸친 버그 수정
- 프로젝트 전체의 포맷팅/리팩터링
- 설정 변경

❌ **피해야 할 상황:**
- 무엇을 커밋할지 불명확
- 시크릿/민감 데이터를 포함
- 리뷰 없는 보호 브랜치
- 머지 충돌이 있음
- 세밀한 커밋 이력을 남기고 싶음
- pre-commit 훅이 실패하고 있음

## 대안

사용자가 더 세밀하게 제어하고 싶어 하면 다음을 제안한다:
1. **선택적 스테이징**: 특정 파일을 리뷰/스테이징
2. **대화형 스테이징**: 패치 단위 선택에 `git add -p`
3. **PR 워크플로**: 브랜치 생성 → push → PR(`/pr` 명령어 사용)

**⚠️ 주의**: push하기 전에 반드시 변경을 확인한다. 망설여진다면 더 세밀한 제어를 위해 개별 git 명령어를 사용한다.

---
**Last Updated**: April 9, 2026
