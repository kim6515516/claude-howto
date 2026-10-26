<!-- i18n-source: 01-slash-commands/setup-ci-cd.md -->
<!-- i18n-source-sha: 7f2e773 -->
<!-- i18n-date: 2026-10-26 -->

---
name: setup-ci-cd
description: 품질 보증을 위한 pre-commit 훅과 GitHub Actions를 도입합니다
---

# CI/CD 파이프라인 설정

프로젝트 종류에 맞춰 포괄적인 DevOps 품질 게이트를 도입합니다:

1. **프로젝트 분석**: 언어, 프레임워크, 빌드 시스템, 기존 도구를 감지합니다
2. **언어별 도구로 pre-commit 훅을 설정합니다**:
   - 포매터: Prettier/Black/gofmt/rustfmt 등
   - 린터: ESLint/Ruff/golangci-lint/Clippy 등
   - 보안: Bandit/gosec/cargo-audit/npm audit 등
   - 타입 검사: TypeScript/mypy/flow(해당하는 경우)
   - 테스트: 관련 테스트 스위트를 실행합니다
3. **GitHub Actions 워크플로를 만듭니다**(.github/workflows/):
   - push/PR 시 pre-commit과 동일한 검사를 실행합니다
   - 여러 버전/플랫폼 매트릭스(해당하는 경우)
   - 빌드와 테스트 검증
   - 배포 단계(필요한 경우)
4. **파이프라인을 검증합니다**: 로컬에서 동작을 확인하고, 테스트용 PR을 만들어 모든 검사가 통과하는지 확인합니다

무료·오픈소스 도구를 사용합니다. 기존 설정을 존중합니다. 실행 시간은 짧게 유지합니다.

---
**Last Updated**: April 9, 2026
