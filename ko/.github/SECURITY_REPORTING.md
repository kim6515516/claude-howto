<!-- i18n-source: .github/SECURITY_REPORTING.md -->
<!-- i18n-source-sha: 6d1e0ae -->
<!-- i18n-date: 2026-10-26 -->
# 보안 취약점 신고

이 파일은 Claude How To 프로젝트의 보안 취약점을 신고하는 방법을 설명합니다.

## 바로 가기

- **비공개 신고**: https://github.com/luongnv89/claude-howto/security/advisories
- **보안 정책**: [SECURITY.md](../SECURITY.md)
- **신고 템플릿**: 아래 참고

## 취약점 신고하기

### 방법 1: GitHub의 Private Vulnerability Report (권장)

보안 취약점을 신고하는 데 우선적으로 사용하는 수단입니다.

**절차:**
1. https://github.com/luongnv89/claude-howto/security/advisories 를 엽니다
2. "Report a vulnerability"를 클릭합니다
3. 세부 내용을 작성합니다 (아래 템플릿 사용)
4. 제출합니다

**장점:**
- 수정 버전이 릴리스될 때까지 취약점을 비공개로 유지
- 메인테이너에게 자동 알림
- 내장된 협업 기능
- GitHub 보안 도구와의 통합

### 방법 2: GitHub Security Alert (의존성용)

의존성에서 취약점을 발견한 경우:

1. https://github.com/luongnv89/claude-howto/security/advisories 를 엽니다
2. 알림을 확인합니다
3. 수정안을 담은 풀 리퀘스트를 만듭니다
4. `security` 라벨을 붙입니다

### 방법 3: 비공개 이메일 (GitHub를 사용할 수 없는 경우)

GitHub의 신고 시스템을 사용할 수 없는 경우:

**준비 중**: 여기에 보안 문의용 이메일 주소를 추가할 예정입니다

당분간은 위의 GitHub 비공개 취약점 신고를 사용해 주세요.

## 취약점 신고 템플릿

취약점을 신고할 때는 다음 템플릿을 사용합니다:

```
**Title**: [Brief description of vulnerability]

**Severity**: [Critical/High/Medium/Low]
Estimated CVSS Score: [0-10]

**Type**: [Code/Documentation/Dependency/Configuration]

**Affected Component**:
- File: [path/to/file.py]
- Section: [Section name if documentation]
- Version: [latest/specific version]

**Description**:
[Clear explanation of what the vulnerability is]

**Potential Impact**:
[What could an attacker do with this vulnerability?]
[Who could be affected?]

**Steps to Reproduce**:
1. [First step]
2. [Second step]
3. [Third step]
[Expected result vs actual result]

**Proof of Concept** (if available):
[Code or steps to demonstrate the vulnerability]

**Suggested Fix**:
[Your recommended solution, if you have one]

**Additional Context**:
[Any other relevant information]

**Your Information**:
- Name: [Your name or anonymous]
- Email: [Your email]
- Credit: [How you'd like to be credited, if at all]
```

## 신고 후 진행 과정

### 타임라인

1. **즉시 (1시간 이내)**
   - 프로젝트 메인테이너에게 자동 알림이 전송됩니다

2. **24시간 이내**
   - 신고 내용을 초기 평가합니다
   - 접수를 확인합니다
   - 잠정적인 심각도 평가를 수행합니다

3. **48시간 이내**
   - 보안 팀의 상세 답변
   - 필요에 따라 확인 질문
   - 취약점이 확인된 경우의 수정 타임라인

4. **1~7일 이내** (심각도에 따라 다름)
   - 수정 개발과 테스트
   - 보안 권고문 준비
   - 수정 릴리스와 공개 권고문 게시

### 커뮤니케이션

다음 경로로 진행 상황을 공유합니다:
- GitHub 비공개 취약점 토론
- 이메일 (제공된 경우)
- 스레드 내 업데이트

신고자는 다음을 할 수 있습니다:
- 확인 질문하기
- 추가 정보 제공하기
- 수정안 제안하기
- 타임라인 조정 요청하기

### 공개 타임라인

**긴급 (CVSS 9.0~10.0)**
- 수정: 즉시 릴리스 (24시간 이내)
- 공개: 같은 날 공개 권고문
- 통지: 신고자에게 24시간 전 통지

**심각 (CVSS 7.0~8.9)**
- 수정: 48~72시간 이내 릴리스
- 공개: 릴리스 시 공개 권고문
- 통지: 신고자에게 5일 전 통지

**중간 (CVSS 4.0~6.9)**
- 수정: 다음 정기 업데이트에 포함
- 공개: 릴리스 시 공개 권고문
- 통지: 시기 조율

**경미 (CVSS 0.1~3.9)**
- 수정: 다음 정기 업데이트에 포함
- 공개: 릴리스 시 권고문
- 통지: 릴리스 당일

## 보안 취약점 기준

### 범위 내

다음에 관한 신고를 받습니다:

- **코드 취약점**
  - 인젝션 공격 (명령어, SQL 등)
  - 예제 안의 크로스 사이트 스크립팅(XSS)
  - 인증·인가의 결함
  - 경로 탐색(path traversal) 취약점
  - 암호화 관련 문제

- **문서 보안**
  - 노출된 비밀 정보나 인증 정보
  - 안전하지 않은 코드 패턴
  - 보안 안티패턴
  - 오해를 부르는 보안 주장

- **의존성 취약점**
  - 알려진 CVE가 포함된 의존성
  - 공급망 공격
  - 악의적인 의존성

- **설정 문제**
  - 안전하지 않은 기본값
  - 누락된 보안 헤더
  - 예제 안의 인증 정보 노출

### 범위 외

다음에 관한 신고는 받지 않습니다:

- Claude Code 자체의 취약점 (Anthropic에 연락해 주세요)
- 외부 서비스의 취약점
- 증거가 없는 이론상의 취약점
- 이미 업스트림 프로젝트에 신고된 문제
- 소셜 엔지니어링이나 피싱
- 사용자 교육·훈련 문제

## 책임 있는 공개 가이드라인

### 해야 할 것 ✅

- 공개하기 전에 **비공개로 신고**합니다
- 파일 경로나 줄 번호 등 **구체적으로** 기술합니다
- 취약점의 **증거를 제시**합니다
- 수정할 **시간을 확보**해 줍니다 (협조적 공개)
- 세부 내용이 발견되면 **업데이트**합니다
- 모든 소통에서 **전문가답게** 행동합니다
- 게시 전까지 **기밀을 존중**합니다

### 하지 말아야 할 것 ❌

- 수정 전에 **공개하지 않습니다**
- 테스트 범위를 넘어 **취약점을 악용하지 않습니다**
- 다른 사용자의 데이터를 **변경하지 않습니다**
- 금전이나 대가를 **요구하지 않습니다**
- 다른 사람과 취약점을 **공유하지 않습니다**
- 어떤 형태로든 **악용하지 않습니다**
- 보안 이외의 문제로 **스팸을 보내지 않습니다**

## 협조적 공개

책임 있는 공개를 실천하고 있습니다:

1. **비공개 신고**: 신고자가 비공개로 신고합니다
2. **평가**: 저희가 심각도를 평가합니다
3. **수정 개발**: 수정을 개발하고 테스트합니다
4. **사전 통지**: 공개 전에 신고자에게 미리 알립니다
5. **공개 릴리스**: 수정과 권고문을 동시에 공개합니다
6. **크레딧**: 원하는 경우 기여를 명시합니다

**타임라인은 심각도에 따라 달라집니다** (위 섹션 참고)

## 수정 릴리스 후

### 공개 권고문

공개 보안 권고문에는 다음이 포함됩니다:
- 취약점 설명
- 영향을 받는 버전
- 심각도 (CVSS 점수)
- 조치 절차
- 수정 링크
- 신고자 크레딧 (허락한 경우)

### 신고자 인정

크레딧을 원하는 경우:
- 권고문에 이름·핸들 표기
- 프로필/웹사이트 링크
- 릴리스 노트에서 언급
- Hall of Fame에 추가 (만들어진 경우)

### 보상 없음

참고:
- 이 프로젝트는 자원봉사로 운영되는 오픈 소스입니다
- 금전적 보상은 제공할 수 없습니다
- 인정과 크레딧은 제공합니다
- 기여는 커뮤니티에 도움이 됩니다

## 보안 리서치

보안 리서치를 수행하는 경우:

1. **허가를 받습니다**: 먼저 메인테이너에게 연락합니다
2. **범위를 정합니다**: 무엇을 테스트할지 합의합니다
3. **신고합니다**: 이 프로세스를 사용합니다
4. **타임라인을 존중합니다**: 수정할 시간을 확보해 줍니다
5. **책임 있게 공개합니다**: 저희와 협조합니다

## 질문

이 프로세스에 관한 질문은:

1. 상세 정책은 [SECURITY.md](../SECURITY.md)를 확인합니다
2. 아래 [FAQ](#faq) 섹션을 봅니다
3. `[SECURITY]` 라벨을 붙여 Discussion을 엽니다
4. 민감한 질문은 비공개 취약점 신고를 사용합니다

## FAQ

**Q: 신고 내용은 비밀로 유지되나요?**
A: 네, 수정 릴리스까지 비밀로 유지됩니다. 세부 내용은 수정에 관여하는 사람에게만 공유합니다.

**Q: 공개하기까지 얼마나 기다려야 하나요?**
A: 심각도에 따른 책임 있는 공개 타임라인(24시간~7일)을 따릅니다. 필요하면 연장에 합의할 수 있습니다.

**Q: 크레딧을 받을 수 있나요?**
A: 네, 원하시면 보안 권고문과 릴리스 노트에 기재합니다 (익명을 원하지 않는 경우).

**Q: 경미한 취약점도 대응해 주나요?**
A: 정당한 보안 문제는 모두 진지하게 다룹니다. 경미한 수정이라도 인정합니다.

**Q: 문서에만 해당하는 취약점도 신고해도 되나요?**
A: 물론입니다. 문서 보안도 중요합니다. 안전하지 않은 패턴을 포함한 예제는 범위 내입니다.

**Q: 보안 문제인지 판단이 서지 않으면 어떻게 하나요?**
A: 그래도 신고해 주세요. 보안 문제가 아니면 그렇게 알려 드립니다. 오탐이어도 괜찮습니다.

**Q: 신고 후에 취약점을 공개적으로 논의해도 되나요?**
A: 안 됩니다. 권고문 공개까지 비공개를 유지해 주세요. 사전 공개는 사용자를 위험에 빠뜨릴 수 있습니다.

**Q: 신고가 접수되었는지 어떻게 확인하나요?**
A: GitHub에서 자동 알림이 전송되고, 24시간 이내에 별도로 연락드립니다.

**Q: 답변이 없으면 어떻게 하나요?**
A: GitHub 보안 권고문 페이지를 확인합니다. 그래도 응답이 없으면 비공개 신고에 댓글을 달아 후속 문의를 해 주세요.

## 참고 자료

- [SECURITY.md](../SECURITY.md) — 전체 보안 정책
- [CONTRIBUTING.md](../CONTRIBUTING.md) — 기여 가이드라인
- [CODE_OF_CONDUCT.md](../CODE_OF_CONDUCT.md) — 커뮤니티 기준
- [OWASP Vulnerability Disclosure](https://cheatsheetseries.owasp.org/cheatsheets/Vulnerability_Disclosure_Cheat_Sheet.html) — 책임 있는 공개의 모범 사례
- [Coordinated Vulnerability Disclosure](https://cheatsheetseries.owasp.org/cheatsheets/Vulnerable_Dependency_Management_Cheat_Sheet.html)

---

이 프로젝트의 보안 향상에 협력해 주셔서 감사합니다! 🔒
