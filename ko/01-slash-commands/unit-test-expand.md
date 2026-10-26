<!-- i18n-source: 01-slash-commands/unit-test-expand.md -->
<!-- i18n-source-sha: 7f2e773 -->
<!-- i18n-date: 2026-10-26 -->

---
name: unit-test-expand
description: 테스트되지 않은 분기와 엣지 케이스를 겨냥해 테스트 커버리지를 높입니다
---

# 단위 테스트 확충

프로젝트의 테스트 프레임워크에 맞춰 기존 단위 테스트를 확충합니다:

1. **커버리지 분석**: 커버리지 리포트를 실행해 테스트되지 않은 분기, 엣지 케이스, 커버리지가 낮은 영역을 찾습니다
2. **빈틈 파악**: 코드를 검토해 논리 분기, 오류 경로, 경계 조건, null/빈 입력을 확인합니다
3. **프로젝트의 프레임워크로 테스트 작성**:
   - Jest/Vitest/Mocha (JavaScript/TypeScript)
   - pytest/unittest (Python)
   - Go testing/testify (Go)
   - Rust 테스트 프레임워크 (Rust)
4. **특정 시나리오 겨냥**:
   - 오류 처리와 예외
   - 경계값(최소/최대, 빈 값, null)
   - 엣지 케이스와 코너 케이스
   - 상태 전이와 부작용
5. **개선 확인**: 커버리지를 다시 측정해 측정 가능한 향상이 있는지 확인합니다

새로 추가한 테스트 코드만 제시합니다. 기존 테스트 패턴과 명명 규칙을 따릅니다.

---
**Last Updated**: April 9, 2026
