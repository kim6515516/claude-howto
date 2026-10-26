<!-- i18n-source: CHANGELOG.md -->
<!-- i18n-source-sha: cf92e8e -->
<!-- i18n-date: 2026-10-26 -->

# 변경 이력

## v2.1.112 — 2026-04-16

### 하이라이트

- 모든 영어 튜토리얼을 Claude Code v2.1.112와 새 Opus 4.7 모델(`claude-opus-4-7`)에 동기화. Opus 4.7에서 기본값이 되는 새 `xhigh` 노력 수준(`high`와 `max`의 중간), 새 내장 슬래시 명령어 2개(`/ultrareview`, `/less-permission-prompts`), Opus 4.7의 Max 구독자에게 `--enable-auto-mode`가 필요 없어진 오토 모드, Windows의 PowerShell 도구, "Auto(터미널에 맞춤)" 테마, 프롬프트 이름으로 명명되는 플랜 파일을 반영. 영어 문서 18건의 푸터를 Claude Code v2.1.112로 업데이트. @Luong NGUYEN

### 기능

- 전체 모듈, 루트 문서, 예제, 레퍼런스에 걸친 우크라이나어(uk) 현지화를 완전 추가(039dde2) @Evgenij I

### 버그 수정

- pre-tool-check.sh 훅의 프로토콜 버그 수정(bce7cf8) @yarlinghe
- CI를 통과하도록 잘못된 mermaid 예제를 텍스트 블록으로 변경(b8a7b1f) @Evgenij I
- 우크라이나어판 claude_concepts_guide.md 목차의 CP1251 인코딩 문제 수정(d970cc6) @Evgenij I
- 스텁 상태의 우크라이나어 README를 완전한 번역으로 교체하고 깨진 앵커 수정(f6d73e2) @Evgenij I
- 모든 푸터의 Claude Code 버전을 2.1.97로 통일(63a1416) @Luong NGUYEN
- 2026-04-09 문서 정확성 업데이트 적용(e015f39) @Luong NGUYEN

### 문서

- Claude Code v2.1.112에 동기화(Opus 4.7, `xhigh` 노력 수준, `/ultrareview`, `/less-permission-prompts`, PowerShell 도구, Auto-match-terminal 테마) @Luong NGUYEN
- Claude Code v2.1.110에 동기화(TUI, 푸시 알림, 세션 요약)(15f0085) @Luong NGUYEN
- Claude Code v2.1.101에 동기화(`/team-onboarding`, `/ultraplan`, Monitor 도구)(2deba3a) @Luong NGUYEN
- 베트남어 문서를 영어 원본에 동기화(561c6cb) @Thiên Toán
- 전체 파일의 Last Updated 날짜와 Claude Code 버전 업데이트(7f2e773) @Luong NGUYEN
- 언어 전환 링크에 우크라이나어 추가(9c224ff) @Luong NGUYEN
- 기여자 섹션 삭제(f07313d) @Luong NGUYEN
- GitHub 지표를 21,800+ stars, 2,585+ forks로 업데이트(4f55374) @Luong NGUYEN

**Full Changelog**: https://github.com/luongnv89/claude-howto/compare/v2.3.0...v2.1.112

---

## v2.3.0 — 2026-04-07

### 기능

- 언어별 EPUB 아티팩트를 빌드·공개(90e9c30) @Thiên Toán
- 누락되어 있던 pre-tool-check.sh 훅을 06-hooks에 추가(b511ed1) @JiayuWang
- zh/ 디렉터리에 중국어 번역 추가(89e89d4) @Luong NGUYEN
- performance-optimizer 서브에이전트와 dependency-check 훅 추가(f53d080) @qk

### 버그 수정

- Windows Git Bash 호환성 + stdin JSON 프로토콜(2cbb10c) @Luong NGUYEN
- 08-checkpoints의 autoCheckpoint 설정 문서 수정(749c79f) @JiayuWang
- 플레이스홀더 치환 대신 SVG 이미지를 임베드(1b16709) @Thiên Toán
- memory README의 중첩 코드 펜스 렌더링 수정(ce24423) @Zhaoshan Duan
- squash merge로 사라진 리뷰 수정 사항 재적용(34259ca) @Luong NGUYEN
- 훅 스크립트를 Windows Git Bash와 호환되게 하고 stdin JSON 프로토콜 사용(107153d) @binyu li

### 문서

- 전체 튜토리얼을 Claude Code 최신 문서(2026년 4월)에 동기화(72d3b01) @Luong NGUYEN
- 언어 전환 링크에 중국어 추가(6cbaa4d) @Luong NGUYEN
- 영어와 베트남어 언어 전환 링크 추가(100c45e) @Luong NGUYEN
- GitHub #1 Trending 배지 추가(0ca8c37) @Luong NGUYEN
- 컨텍스트 영역 모니터링을 위한 cc-context-stats 소개(d41b335) @Luong NGUYEN
- luongnv89/skills 컬렉션과 luongnv89/asm 스킬 매니저 소개(7e3c0b6) @Luong NGUYEN
- README 통계를 최신 GitHub 지표(5,900+ stars, 690+ forks)로 업데이트(5001525) @Luong NGUYEN
- README 통계를 최신 GitHub 지표(3,900+ stars, 460+ forks)로 업데이트(9cb92d6) @Luong NGUYEN

### 리팩터링

- Kroki HTTP 의존성을 로컬 mmdc 렌더링으로 교체(e76bbe4) @Luong NGUYEN
- 품질 검사를 pre-commit으로 앞당기고 CI를 2차 검사로 전환(6d1e0ae) @Luong NGUYEN
- 오토 모드 권한 기준선 축소(2790fb2) @Luong NGUYEN
- auto-adapt 훅을 일회성 권한 설정 스크립트로 교체(995a5d6) @Luong NGUYEN

### 기타

- 품질 게이트 시프트 레프트 — pre-commit에 mypy를 추가하고 CI 실패 수정(699fb39) @Luong NGUYEN
- 베트남어(Tiếng Việt) 현지화 추가(a70777e) @Thiên Toán

**Full Changelog**: https://github.com/luongnv89/claude-howto/compare/v2.2.0...v2.3.0

---

## v2.2.0 — 2026-03-26

### 문서

- 전체 튜토리얼과 레퍼런스를 Claude Code v2.1.84에 동기화(f78c094) @luongnv89
  - 슬래시 명령어를 55개 이상의 내장 + 5개의 번들 스킬로 업데이트, 3개를 지원 중단으로 표시
  - 훅 이벤트를 18개에서 25개로 확장, `agent` 훅 타입 추가(4개 타입으로)
  - Auto Mode, Channels, Voice Dictation을 고급 기능에 추가
  - 스킬 프런트매터에 `effort`, `shell` 필드 추가; 에이전트에 `initialPrompt`, `disallowedTools` 필드 추가
  - WebSocket MCP 전송, 엘리시테이션, 2KB 도구 상한 추가
  - 플러그인의 LSP 지원, `userConfig`, `${CLAUDE_PLUGIN_DATA}` 추가
  - 전체 레퍼런스 문서(CATALOG, QUICK_REFERENCE, LEARNING-ROADMAP, INDEX) 업데이트
- README를 랜딩 페이지 구성의 가이드로 재작성(32a0776) @luongnv89

### 버그 수정

- CI 준수를 위해 누락된 cSpell 단어와 README 섹션 추가(93f9d51) @luongnv89
- cSpell 사전에 `Sandboxing` 추가(b80ce6f) @luongnv89

**Full Changelog**: https://github.com/luongnv89/claude-howto/compare/v2.1.1...v2.2.0

---

## v2.1.1 — 2026-03-13

### 버그 수정

- CI 링크 검사에서 실패하는 죽은 마켓플레이스 링크 삭제(3fdf0d6) @luongnv89
- cSpell 사전에 `sandboxed`와 `pycache` 추가(dc64618) @luongnv89

**Full Changelog**: https://github.com/luongnv89/claude-howto/compare/v2.1.0...v2.1.1

---

## v2.1.0 — 2026-03-13

### 기능

- 자기 평가와 레슨 퀴즈 스킬을 통한 적응형 학습 경로 추가(1ef46cd) @luongnv89
  - `/self-assessment` — 10개 기능 영역에 걸친 대화형 숙련도 퀴즈와 개인 맞춤 학습 경로
  - `/lesson-quiz [lesson]` — 8~10개의 집중 질문으로 레슨별 지식 점검

### 버그 수정

- 깨진 URL, 지원 중단, 오래된 레퍼런스 업데이트(8fe4520) @luongnv89
- 리소스와 self-assessment 스킬 안의 깨진 링크 수정(7a05863) @luongnv89
- concepts 가이드의 중첩 코드 블록에 물결표 펜스 사용(5f82719) @VikalpP
- cSpell 사전에 누락된 단어 추가(8df7572) @luongnv89

### 문서

- 5단계 QA — 문서 전체의 정합성, URL, 용어 수정(00bbe4c) @luongnv89
- 3~4단계 완료 — 새 기능 커버리지와 레퍼런스 문서 업데이트(132de29) @luongnv89
- MCP 컨텍스트 비대화 섹션에 MCPorter 런타임 추가(ef52705) @luongnv89
- 6개 가이드에 누락된 명령어, 기능, 설정 추가(4bc8f15) @luongnv89
- 기존 저장소 규약에 기반한 스타일 가이드 추가(84141d0) @luongnv89
- 가이드 비교표에 self-assessment 행 추가(8fe0c96) @luongnv89
- PR #7에 대해 VikalpP를 기여자 목록에 추가(d5b4350) @luongnv89
- self-assessment와 lesson-quiz 스킬 참조를 README와 로드맵에 추가(d5a6106) @luongnv89

### 새 기여자

- @VikalpP 님이 #7에서 첫 기여

**Full Changelog**: https://github.com/luongnv89/claude-howto/compare/v2.0.0...v2.1.0

---

## v2.0.0 — 2026-02-01

### 기능

- 전체 문서를 Claude Code 2026년 2월 기능에 동기화(487c96d)
  - 10개 튜토리얼 디렉터리와 7개 레퍼런스 문서에 걸친 26개 파일 업데이트
  - **Auto Memory**(프로젝트별 영속 학습) 문서 추가
  - **Remote Control**, **Web Sessions**, **Desktop App** 문서 추가
  - **Agent Teams**(실험적 멀티 에이전트 협업) 문서 추가
  - **MCP OAuth 2.0**, **Tool Search**, **Claude.ai Connectors** 문서 추가
  - 서브에이전트의 **Persistent Memory**와 **Worktree Isolation** 문서 추가
  - **Background Subagents**, **Task List**, **Prompt Suggestions** 문서 추가
  - **Sandboxing**과 **Managed Settings**(Enterprise) 문서 추가
  - **HTTP Hooks**와 7개의 새 훅 이벤트 문서 추가
  - **Plugin Settings**, **LSP Servers**, Marketplace 업데이트 문서 추가
  - **Summarize from Checkpoint** 되감기 옵션 문서 추가
  - 17개의 새 슬래시 명령어(`/fork`, `/desktop`, `/teleport`, `/tasks`, `/fast` 등) 문서화
  - 새 CLI 플래그(`--worktree`, `--from-pr`, `--remote`, `--teleport`, `--teammate-mode` 등) 문서화
  - 오토 메모리, 노력 수준, 에이전트 팀 등에 관한 새 환경 변수 문서화

### 디자인

- 로고를 나침반·브래킷 마크와 최소한의 팔레트로 새로 단장(20779db)

### 버그 수정 / 정정

- 모델명 업데이트: Sonnet 4.5 → **Sonnet 4.6**, Opus 4.5 → **Opus 4.6**
- 권한 모드명 수정: 가상의 "Unrestricted/Confirm/Read-only"를 실재하는 `default`/`acceptEdits`/`plan`/`dontAsk`/`bypassPermissions`로 교체
- 훅 이벤트 수정: 가상의 `PreCommit`/`PostCommit`/`PrePush`를 삭제하고 실재하는 이벤트(`SubagentStart`, `WorktreeCreate`, `ConfigChange` 등) 추가
- CLI 구문 수정: `claude-code --headless`를 `claude -p`(print mode)로 교체
- 체크포인트 명령어 수정: 가상의 `/checkpoint save/list/rewind/diff`를 실재하는 `Esc+Esc` / `/rewind` 인터페이스로 교체
- 세션 관리 수정: 가상의 `/session list/new/switch/save`를 실재하는 `/resume`/`/rename`/`/fork`로 교체
- 플러그인 매니페스트 형식 수정: `plugin.yaml` → `.claude-plugin/plugin.json`
- MCP 설정 경로 수정: `~/.claude/mcp.json` → `.mcp.json`(프로젝트) / `~/.claude.json`(사용자)
- 문서 URL 수정: `docs.claude.com` → `docs.anthropic.com`; 가상의 `plugins.claude.com` 삭제
- 여러 파일에 걸친 가상의 설정 필드 삭제
- 전체 파일의 "Last Updated" 날짜를 2026년 2월로 업데이트

**Full Changelog**: https://github.com/luongnv89/claude-howto/compare/20779db...v2.0.0
