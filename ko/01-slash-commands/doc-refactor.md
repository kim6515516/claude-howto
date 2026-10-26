<!-- i18n-source: 01-slash-commands/doc-refactor.md -->
<!-- i18n-source-sha: 7f2e773 -->
<!-- i18n-date: 2026-10-26 -->

---
name: doc-refactor
description: 프로젝트 문서를 재구성하여 명확성과 접근성을 높입니다
---

# 문서 리팩터링

프로젝트 종류에 맞춰 문서 구조를 리팩터링합니다:

1. **프로젝트 분석**: 종류(라이브러리/API/웹 앱/CLI/마이크로서비스), 아키텍처, 사용자 페르소나를 파악합니다
2. **문서 통합**: 기술 문서를 `docs/`로 옮기고 적절한 상호 참조를 정리합니다
3. **루트 README.md**: 개요, 퀵 스타트, 모듈/컴포넌트 요약, 라이선스, 연락처를 담은 진입점으로 정리합니다
4. **컴포넌트별 문서**: 모듈/패키지/서비스 단위의 README 파일을 추가하고 설치와 테스트 절차를 기재합니다
5. **`docs/`를 관련 카테고리로 정리합니다**:
   - Architecture, API Reference, Database, Design, Troubleshooting, Deployment, Contributing(프로젝트 필요에 맞게 조정)
6. **가이드를 작성합니다**(해당하는 것을 선택):
   - User Guide: 애플리케이션 최종 사용자용 문서
   - API Documentation: API 엔드포인트, 인증, 예제
   - Development Guide: 설치, 테스트, 기여 워크플로
   - Deployment Guide: 서비스/앱의 프로덕션 배포
7. **모든 다이어그램에 Mermaid 사용**(아키텍처, 흐름, 스키마)

문서는 간결하고 훑어보기 쉬우며 프로젝트 종류에 맞는 내용으로 유지합니다.

---
**Last Updated**: April 9, 2026
