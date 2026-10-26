<!-- i18n-source: README.md -->
<!-- i18n-source-sha: d17d515 -->
<!-- i18n-date: 2026-10-26 -->

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

<p align="center">
  <a href="https://github.com/trending">
    <img src="https://img.shields.io/badge/GitHub-🔥%20%231%20Trending-purple?style=for-the-badge&logo=github"/>
  </a>
</p>

[![GitHub Stars](https://img.shields.io/github/stars/luongnv89/claude-howto?style=flat&color=gold)](https://github.com/luongnv89/claude-howto/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/luongnv89/claude-howto?style=flat)](https://github.com/luongnv89/claude-howto/network/members)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../LICENSE)
[![Version](https://img.shields.io/badge/version-2.1.119-brightgreen)](../CHANGELOG.md)
[![Claude Code](https://img.shields.io/badge/Claude_Code-2.1+-purple)](https://code.claude.com)

🌐 **Language / Ngôn ngữ / 语言 / Мова / 言語 / 언어:** [English](../README.md) | [Tiếng Việt](../vi/README.md) | [中文](../zh/README.md) | [Українська](../uk/README.md) | [日本語](../ja/README.md) | [한국어](README.md)

# 주말 만에 Claude Code 마스터하기

`claude`를 입력하기만 하던 단계에서 에이전트, 훅, 스킬, MCP 서버를 한데 엮는 단계로. 시각적인 튜토리얼, 복사해서 바로 쓰는 템플릿, 가이드 학습 경로로 안내합니다.

**[15분 만에 시작하기](#15분-만에-시작하기)** | **[내 레벨 찾기](#어디서-시작해야-할지-모르겠다면)** | **[기능 카탈로그 보기](CATALOG.md)**

---

## 목차

- [문제](#문제)
- [Claude How To가 해결하는 방법](#claude-how-to가-해결하는-방법)
- [동작 방식](#동작-방식)
- [어디서 시작해야 할지 모르겠다면?](#어디서-시작해야-할지-모르겠다면)
- [15분 만에 시작하기](#15분-만에-시작하기)
- [무엇을 만들 수 있나](#무엇을-만들-수-있나)
- [FAQ](#faq)
- [기여하기](#기여하기)
- [라이선스](#라이선스)

---

## 문제

Claude Code를 설치하고 프롬프트를 몇 번 실행해 봤습니다. 다음에는 무엇을 해야 할까요?

- **공식 문서는 기능을 설명하지만, 조합하는 법은 알려 주지 않습니다.** 슬래시 명령어가 있다는 건 알아도, 훅, 메모리, 서브에이전트와 연계해 실제로 시간을 아껴 주는 워크플로로 엮는 방법은 알 수 없습니다.
- **명확한 학습 경로가 없습니다.** MCP를 훅보다 먼저 배워야 할까요? 스킬을 서브에이전트보다 먼저 배워야 할까요? 결국 전부 훑어보기만 하고 어느 것 하나 제대로 익히지 못합니다.
- **예제가 너무 기초적입니다.** "hello world" 슬래시 명령어로는 메모리를 활용하고, 전문 에이전트에 위임하고, 보안 스캔을 자동 실행하는 프로덕션 품질의 코드 리뷰 파이프라인을 만들 수 없습니다.

Claude Code가 가진 힘의 90%를 잠재워 둔 채, 심지어 자신이 무엇을 모르는지조차 모르는 상태입니다.

---

## Claude How To가 해결하는 방법

이것은 단순한 기능 레퍼런스가 아닙니다. **구조화되고, 시각적이며, 예제 중심인 가이드**로서, Claude Code의 각 기능을 사용하는 법을 오늘 당장 프로젝트에 그대로 복사해 쓸 수 있는 실전 템플릿과 함께 가르칩니다.

| | 공식 문서 | 이 가이드 |
|--|---------------|------------|
| **형식** | 레퍼런스 문서 | Mermaid 다이어그램이 있는 시각적 튜토리얼 |
| **깊이** | 기능 설명 | 내부 동작 원리 |
| **예제** | 기본 스니펫 | 바로 쓸 수 있는 프로덕션 품질 템플릿 |
| **구조** | 기능별 구성 | 단계적 학습 경로(초급부터 고급까지) |
| **온보딩** | 자율 학습 | 소요 시간이 표시된 가이드 로드맵 |
| **자가 진단** | 없음 | 약점을 찾아 개인 맞춤 경로를 만들어 주는 인터랙티브 퀴즈 |

### 얻을 수 있는 것

- **10개의 튜토리얼 모듈**: 슬래시 명령어부터 커스텀 에이전트 팀까지 Claude Code의 전 기능을 다룹니다
- **복사해서 바로 쓰는 설정**: 슬래시 명령어, CLAUDE.md 템플릿, 훅 스크립트, MCP 설정, 서브에이전트 정의, 완전한 플러그인 번들
- **Mermaid 다이어그램**으로 각 기능의 내부 동작을 시각화해 "어떻게"뿐 아니라 "왜"까지 이해할 수 있습니다
- **가이드 학습 경로**로 11~13시간 만에 초급자에서 파워 유저로 올라설 수 있습니다
- **내장 자가 진단**: Claude Code 안에서 `/self-assessment` 또는 `/lesson-quiz hooks`를 실행해 약점을 찾아낼 수 있습니다

**[학습 경로 시작하기 ->](LEARNING-ROADMAP.md)**

---

## 동작 방식

### 1. 내 레벨 찾기

[자가 진단 퀴즈](LEARNING-ROADMAP.md#-자신의-레벨-찾기)를 풀거나 Claude Code 안에서 `/self-assessment`를 실행하세요. 이미 알고 있는 내용을 바탕으로 개인 맞춤 로드맵을 얻을 수 있습니다.

### 2. 가이드 경로 따라가기

10개 모듈을 순서대로 진행합니다. 각 모듈은 이전 모듈 위에 쌓아 올려집니다. 배우면서 템플릿을 그대로 프로젝트에 복사하세요.

### 3. 기능을 조합해 워크플로 만들기

진짜 힘은 기능의 조합에서 나옵니다. 슬래시 명령어, 메모리, 서브에이전트, 훅을 연계해 코드 리뷰, 배포, 문서 생성을 자동화하는 파이프라인을 만드는 법을 배웁니다.

### 4. 이해도 점검하기

각 모듈이 끝나면 `/lesson-quiz [주제]`를 실행하세요. 퀴즈가 놓친 부분을 짚어 주므로 약점을 빠르게 메울 수 있습니다.

**[15분 만에 시작하기](#15분-만에-시작하기)**

---

## 개발자들이 신뢰하는 가이드

- **GitHub 스타**: Claude Code를 매일 사용하는 개발자들로부터
- **포크**: 자기 팀의 워크플로에 맞게 응용하는 팀들로부터
- **적극적인 유지 보수**: Claude Code 릴리스에 맞춰 동기화(최신은 v2.1.119, 2026년 4월)
- **커뮤니티 주도**: 실제 운영 설정을 공유하는 개발자들의 기여

[![Star History Chart](https://api.star-history.com/svg?repos=luongnv89/claude-howto&type=Date)](https://star-history.com/#luongnv89/claude-howto&Date)

---

## 어디서 시작해야 할지 모르겠다면?

자가 진단을 받거나 레벨을 고르세요.

| 레벨 | 할 수 있는 것 | 시작 지점 | 소요 시간 |
|-------|-----------|------------|------|
| **초급** | Claude Code를 실행해 대화하기 | [슬래시 명령어](01-slash-commands/) | 약 2.5시간 |
| **중급** | CLAUDE.md와 커스텀 명령어 사용하기 | [스킬](03-skills/) | 약 3.5시간 |
| **고급** | MCP 서버와 훅 설정하기 | [고급 기능](09-advanced-features/) | 약 5시간 |

**전체 10개 모듈의 완전 학습 경로:**

| 순서 | 모듈 | 레벨 | 소요 시간 |
|-------|--------|-------|------|
| 1 | [슬래시 명령어](01-slash-commands/) | 초급 | 30분 |
| 2 | [메모리](02-memory/) | 초급+ | 45분 |
| 3 | [체크포인트](08-checkpoints/) | 중급 | 45분 |
| 4 | [CLI 기초](10-cli/) | 초급+ | 30분 |
| 5 | [스킬](03-skills/) | 중급 | 1시간 |
| 6 | [훅](06-hooks/) | 중급 | 1시간 |
| 7 | [MCP](05-mcp/) | 중급+ | 1시간 |
| 8 | [서브에이전트](04-subagents/) | 중급+ | 1.5시간 |
| 9 | [고급 기능](09-advanced-features/) | 고급 | 2~3시간 |
| 10 | [플러그인](07-plugins/) | 고급 | 2시간 |

**[완전 학습 로드맵 ->](LEARNING-ROADMAP.md)**

---

## 15분 만에 시작하기

> **설치 관련 참고**: v2.1.113부터 Claude Code는 플랫폼별 네이티브 바이너리(macOS / Linux / Windows)로 배포됩니다. 권장 설치 방법은 네이티브 설치 프로그램(`curl -fsSL https://claude.ai/install.sh | bash`)입니다. 공식 README에서는 npm 설치를 권장하지 않으므로 네이티브 설치 프로그램, Homebrew(`brew install --cask claude-code`) 또는 WinGet(`winget install Anthropic.ClaudeCode`)을 권장합니다. 참고로 `npm install -g @anthropic-ai/claude-code`는 설치 시 플랫폼별 선택적 의존성을 통해 같은 네이티브 바이너리를 가져옵니다. v2.1.116부터 다운로드 출처는 `https://downloads.claude.ai/claude-code-releases`이며, 기업 프록시에서는 이 호스트를 허용 목록에 추가해야 합니다.

```bash
# 1. 가이드 클론
git clone https://github.com/luongnv89/claude-howto.git
cd claude-howto

# 2. 첫 슬래시 명령어 복사
mkdir -p /path/to/your-project/.claude/commands
cp 01-slash-commands/optimize.md /path/to/your-project/.claude/commands/

# 3. 시험해 보기 — Claude Code에서 다음을 입력:
# /optimize

# 4. 다음 단계로 가고 싶다면 프로젝트 메모리 설정:
cp 02-memory/project-CLAUDE.md /path/to/your-project/CLAUDE.md

# 5. 스킬 설치:
cp -r 03-skills/code-review-specialist ~/.claude/skills/
```

전체 설정이 필요하다면 **1시간 안에 끝내는 필수 설정**은 다음과 같습니다.

```bash
# 슬래시 명령어 (15분)
cp 01-slash-commands/*.md .claude/commands/

# 프로젝트 메모리 (15분)
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# 스킬 설치 (15분)
cp -r 03-skills/code-review-specialist ~/.claude/skills/

# 주말 목표: 훅, 서브에이전트, MCP, 플러그인 추가
# 가이드 설정은 학습 경로를 따르세요
```

**[전체 설치 레퍼런스 보기](#15분-만에-시작하기)**

---

## 무엇을 만들 수 있나

| 사용 사례 | 조합하는 기능 |
|----------|------------------------|
| **자동 코드 리뷰** | 슬래시 명령어 + 서브에이전트 + 메모리 + MCP |
| **팀 온보딩** | 메모리 + 슬래시 명령어 + 플러그인 |
| **CI/CD 자동화** | CLI 레퍼런스 + 훅 + 백그라운드 작업 |
| **문서 생성** | 스킬 + 서브에이전트 + 플러그인 |
| **보안 감사** | 서브에이전트 + 스킬 + 훅(읽기 전용 모드) |
| **DevOps 파이프라인** | 플러그인 + MCP + 훅 + 백그라운드 작업 |
| **복잡한 리팩터링** | 체크포인트 + 플랜 모드 + 훅 |

---

## FAQ

**무료인가요?**
네. MIT 라이선스로 영원히 무료입니다. 개인 프로젝트, 업무, 팀에서 자유롭게 사용할 수 있습니다. 라이선스 표기를 포함하는 것 외에는 제약이 없습니다.

**유지 보수되고 있나요?**
적극적으로 되고 있습니다. 이 가이드는 Claude Code 릴리스마다 동기화됩니다. 현재 버전은 v2.1.119(2026년 4월)이며 Claude Code 2.1+와 호환됩니다.

**공식 문서와 무엇이 다른가요?**
공식 문서는 기능 레퍼런스입니다. 이 가이드는 다이어그램, 프로덕션 품질 템플릿, 단계적 학습 경로를 갖춘 튜토리얼입니다. 둘은 상호 보완 관계입니다. 배울 때는 여기서 시작하고, 구체적인 사양이 필요할 때 공식 문서를 참고하면 좋습니다.

**전부 마치는 데 얼마나 걸리나요?**
완전 경로는 11~13시간입니다. 다만 15분 만에 바로 가치를 얻을 수 있습니다. 슬래시 명령어 템플릿을 복사해서 시험해 보기만 하면 됩니다.

**Claude Sonnet / Haiku / Opus와 함께 쓸 수 있나요?**
쓸 수 있습니다. 모든 템플릿은 Claude Sonnet 5.5, Claude Sonnet 4.6, Claude Opus 4.7, Claude Haiku 4.5에서 동작합니다.

**기여할 수 있나요?**
물론입니다. 가이드라인은 [CONTRIBUTING.md](CONTRIBUTING.md)를 참고하세요. 새로운 예제, 버그 수정, 문서 개선, 커뮤니티 템플릿을 환영합니다.

**오프라인에서 읽을 수 있나요?**
읽을 수 있습니다. `uv run scripts/build_epub.py`를 실행하면 모든 콘텐츠와 렌더링된 다이어그램이 포함된 EPUB 전자책이 생성됩니다.

---

## 오늘부터 Claude Code 마스터하기

이미 Claude Code는 설치되어 있을 것입니다. 이제 다루는 법만 알면 생산성이 10배가 됩니다. 이 가이드는 그곳에 도달하기 위한 구조화된 경로, 시각적인 설명, 복사해서 바로 쓰는 템플릿을 제공합니다.

MIT 라이선스. 영원히 무료. 클론하고, 포크하고, 자기 것으로 만드세요.

**[학습 경로 시작하기 ->](LEARNING-ROADMAP.md)** | **[기능 카탈로그 보기](CATALOG.md)** | **[15분 만에 시작하기](#15분-만에-시작하기)**

---

<details>
<summary>빠른 탐색 — 전체 기능</summary>

| 기능 | 설명 | 폴더 |
|---------|-------------|--------|
| **기능 카탈로그** | 설치 명령어가 포함된 완전 레퍼런스 | [CATALOG.md](CATALOG.md) |
| **슬래시 명령어** | 사용자가 실행하는 단축 명령 | [01-slash-commands/](01-slash-commands/) |
| **메모리** | 영속적인 컨텍스트 | [02-memory/](02-memory/) |
| **스킬** | 재사용 가능한 기능 | [03-skills/](03-skills/) |
| **서브에이전트** | 전문 특화된 AI 어시스턴트 | [04-subagents/](04-subagents/) |
| **MCP 프로토콜** | 외부 도구 접근 | [05-mcp/](05-mcp/) |
| **훅** | 이벤트 기반 자동화 | [06-hooks/](06-hooks/) |
| **플러그인** | 번들된 기능 | [07-plugins/](07-plugins/) |
| **체크포인트** | 세션 스냅샷과 되감기 | [08-checkpoints/](08-checkpoints/) |
| **고급 기능** | 플래닝, 싱킹, 백그라운드 작업 | [09-advanced-features/](09-advanced-features/) |
| **CLI 레퍼런스** | 명령어, 플래그, 옵션 | [10-cli/](10-cli/) |
| **블로그 글** | 실제 활용 사례 | [Blog Posts](https://medium.com/@luongnv89) |

</details>

<details>
<summary>기능 비교</summary>

| 기능 | 실행 방식 | 지속성 | 적합한 용도 |
|---------|-----------|------------|----------|
| **슬래시 명령어** | 수동(`/cmd`) | 세션 내에서만 | 빠른 단축 명령 |
| **메모리** | 자동 로드 | 세션 간 유지 | 장기적인 학습 |
| **스킬** | 자동 실행 | 파일 시스템 | 자동화 워크플로 |
| **서브에이전트** | 자동 위임 | 컨텍스트 분리 | 작업 분산 |
| **MCP 프로토콜** | 자동 질의 | 실시간 | 라이브 데이터 접근 |
| **훅** | 이벤트 트리거 | 설정값으로 영속화 | 자동화와 검증 |
| **플러그인** | 명령어 1개 | 전체 기능 포함 | 완전한 솔루션 |
| **체크포인트** | 수동 / 자동 | 세션 단위 | 안전한 실험 |
| **플랜 모드** | 수동 / 자동 | 계획 단계 | 복잡한 구현 |
| **백그라운드 작업** | 수동 | 작업 생존 기간 | 장시간 처리 |
| **CLI 레퍼런스** | 터미널 명령어 | 세션 / 스크립트 | 자동화와 스크립팅 |

</details>

<details>
<summary>설치 요약표</summary>

```bash
# Slash Commands
cp 01-slash-commands/*.md .claude/commands/

# Memory
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# Skills
cp -r 03-skills/code-review-specialist ~/.claude/skills/

# Subagents
cp 04-subagents/*.md .claude/agents/

# MCP
claude mcp add --transport http github https://api.githubcopilot.com/mcp/ --header "Authorization: Bearer YOUR_GITHUB_PAT"

# Hooks
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# Plugins(저장소 루트에서 로컬 플러그인을 불러옵니다)
claude --plugin-dir ./07-plugins/pr-review

# Checkpoints (자동 활성화, 설정으로 조정)
# 08-checkpoints/README.md 참고

# Advanced Features (설정으로 조정)
# 09-advanced-features/config-examples.json 참고

# CLI Reference (설치 불필요)
# 활용 예시는 10-cli/README.md 참고
```

</details>

<details>
<summary>01. 슬래시 명령어</summary>

**위치**: [01-slash-commands/](01-slash-commands/)

**개요**: Markdown 파일로 저장되는, 사용자가 실행하는 단축 명령

**예시**:
- `optimize.md` — 코드 최적화 분석
- `pr.md` — 풀 리퀘스트 준비
- `generate-api-docs.md` — API 문서 생성

**설치**:
```bash
cp 01-slash-commands/*.md /path/to/project/.claude/commands/
```

**사용법**:
```
/optimize
/pr
/generate-api-docs
```

**더 알아보기**: [Discovering Claude Code Slash Commands](https://medium.com/@luongnv89/discovering-claude-code-slash-commands-cdc17f0dfb29)

</details>

<details>
<summary>02. 메모리</summary>

**위치**: [02-memory/](02-memory/)

**개요**: 세션을 넘어 유지되는 영속적인 컨텍스트

**예시**:
- `project-CLAUDE.md` — 팀 공통 프로젝트 규약
- `directory-api-CLAUDE.md` — 디렉터리별 규칙
- `personal-CLAUDE.md` — 개인 선호 설정

**설치**:
```bash
# 프로젝트 메모리
cp 02-memory/project-CLAUDE.md /path/to/project/CLAUDE.md

# 디렉터리 메모리
cp 02-memory/directory-api-CLAUDE.md /path/to/project/src/api/CLAUDE.md

# 개인 메모리
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

**사용법**: Claude가 자동으로 읽어 들입니다

</details>

<details>
<summary>03. 스킬</summary>

**위치**: [03-skills/](03-skills/)

**개요**: 지시문과 스크립트를 갖춘, 재사용 가능하고 자동으로 실행되는 기능

**예시**:
- `code-review/` — 스크립트가 포함된 포괄적인 코드 리뷰
- `brand-voice/` — 브랜드 보이스 일관성 검사기
- `doc-generator/` — API 문서 생성

**설치**:
```bash
# 개인 스킬
cp -r 03-skills/code-review-specialist ~/.claude/skills/

# 프로젝트 스킬
cp -r 03-skills/code-review-specialist /path/to/project/.claude/skills/
```

**사용법**: 관련된 상황에서 자동으로 실행됩니다

</details>

<details>
<summary>04. 서브에이전트</summary>

**위치**: [04-subagents/](04-subagents/)

**개요**: 분리된 컨텍스트와 커스텀 프롬프트를 가진 전문 특화 AI 어시스턴트

**예시**:
- `code-reviewer.md` — 포괄적인 코드 품질 분석
- `test-engineer.md` — 테스트 전략과 커버리지
- `documentation-writer.md` — 기술 문서 작성
- `secure-reviewer.md` — 보안 중심 리뷰(읽기 전용)
- `implementation-agent.md` — 기능의 완전한 구현

**설치**:
```bash
cp 04-subagents/*.md /path/to/project/.claude/agents/
```

**사용법**: 메인 에이전트가 자동으로 위임합니다

</details>

<details>
<summary>05. MCP 프로토콜</summary>

**위치**: [05-mcp/](05-mcp/)

**개요**: 외부 도구와 API에 접근하기 위한 Model Context Protocol

**예시**:
- `github-mcp.json` — GitHub 연동
- `database-mcp.json` — 데이터베이스 쿼리
- `filesystem-mcp.json` — 파일 작업
- `multi-mcp.json` — 여러 MCP 서버

**설치**:
```bash
# 환경 변수 설정
export DATABASE_URL="postgresql://..."

# CLI로 MCP 서버 추가
claude mcp add --transport http github https://api.githubcopilot.com/mcp/ --header "Authorization: Bearer YOUR_GITHUB_PAT"

# 또는 프로젝트 .mcp.json에 수동 추가 (예시는 05-mcp/ 참고)
```

**사용법**: 설정 후에는 MCP 도구를 Claude가 자동으로 사용할 수 있게 됩니다

</details>

<details>
<summary>06. 훅</summary>

**위치**: [06-hooks/](06-hooks/)

**개요**: Claude Code 이벤트에 반응해 자동 실행되는 이벤트 기반 셸 명령어

**예시**:
- `format-code.sh` — 쓰기 후 코드 자동 포맷
- `pre-commit.sh` — 커밋 전 테스트 실행
- `security-scan.sh` — 보안 문제 스캔
- `log-bash.sh` — 모든 bash 명령어를 로그에 기록
- `validate-prompt.sh` — 사용자 프롬프트 검증
- `notify-team.sh` — 이벤트 발생 시 알림 전송

**설치**:
```bash
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

`~/.claude/settings.json`에서 훅을 설정합니다:
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "hooks": [
          { "type": "command", "command": "~/.claude/hooks/format-code.sh" },
          { "type": "command", "command": "~/.claude/hooks/security-scan.sh" }
        ]
      }
    ]
  }
}
```

**사용법**: 이벤트가 발생하면 훅이 자동 실행됩니다

**훅 종류**(5종): `command`, `http`, `prompt`, `mcp_tool`, `agent` — 훅의 실행 방식.

**훅 이벤트**(33개, 4개 카테고리) — 실행 시점:
- **도구 계열 훅**: `PreToolUse`, `PostToolUse`, `PostToolUseFailure`, `PostToolBatch`, `PermissionRequest`, `PermissionDenied`
- **세션 계열 훅**: `SessionStart`, `Setup`, `SessionEnd`, `Stop`, `StopFailure`, `SubagentStart`, `SubagentStop`
- **작업 계열 훅**: `UserPromptSubmit`, `UserPromptExpansion`, `MessageDisplay`, `TaskCompleted`, `TaskCreated`, `TeammateIdle`(`TaskCompleted`와 `TaskCreated`는 todo 도구가 활성화되어 있을 때만 발화 — Claude 3.x, Opus 4~4.7, Sonnet 4~4.6, Haiku 4.5에서만 기본 활성화. `CLAUDE_CODE_ENABLE_TODO_TOOLS=1`로 되살릴 수 있음)
- **라이프사이클 계열 훅**: `ConfigChange`, `CwdChanged`, `DirectoryAdded`, `FileChanged`, `PreCompact`, `PostCompact`, `PreModelSwitch`, `PostModelSwitch`, `WorktreeCreate`, `WorktreeRemove`, `Notification`, `InstructionsLoaded`, `Elicitation`, `ElicitationResult`

</details>

<details>
<summary>07. 플러그인</summary>

**위치**: [07-plugins/](07-plugins/)

**개요**: 명령어, 에이전트, MCP, 훅을 한데 묶은 번들

**예시**:
- `pr-review/` — 완전한 PR 리뷰 워크플로
- `devops-automation/` — 배포와 모니터링
- `documentation/` — 문서 생성

**설치**:
```bash
# 저장소 루트에서 실행(이 저장소에는 마켓플레이스가 없으므로 /plugin install은 사용할 수 없습니다)
claude --plugin-dir ./07-plugins/pr-review
claude --plugin-dir ./07-plugins/devops-automation
claude --plugin-dir ./07-plugins/documentation
```

**사용법**: 번들된 슬래시 명령어와 기능을 사용합니다

</details>

<details>
<summary>08. 체크포인트와 되감기</summary>

**위치**: [08-checkpoints/](08-checkpoints/)

**개요**: 대화 상태를 저장하고 과거 지점으로 되감아 다른 접근을 시도할 수 있는 기능

**핵심 개념**:
- **체크포인트**: 대화 상태의 스냅샷
- **되감기**: 이전 체크포인트로 돌아가기
- **분기점**: 같은 체크포인트에서 여러 접근을 시도하기

**사용법**:
```
# 체크포인트는 사용자 프롬프트마다 자동 생성됩니다
# 되감기는 Esc를 두 번 누르거나 다음을 실행:
/rewind

# 6가지 선택지 중 하나를 고릅니다:
# 1. 코드와 대화 복원
# 2. 대화만 복원
# 3. 코드만 복원
# 4. 여기서부터 요약
# 5. 여기까지 요약
# 6. 취소
```

**사용 사례**:
- 여러 구현 접근 시도하기
- 실수에서 복구하기
- 안전한 실험
- 대안 비교
- 서로 다른 설계의 A/B 테스트

</details>

<details>
<summary>09. 고급 기능</summary>

**위치**: [09-advanced-features/](09-advanced-features/)

**개요**: 복잡한 워크플로와 자동화를 위한 고급 기능

**포함된 기능**:
- **플랜 모드** — 코딩 전에 상세한 구현 계획 작성
- **확장 사고(Extended Thinking)** — 복잡한 문제에 대한 깊은 추론(`Alt+T` / `Option+T`로 전환)
- **백그라운드 작업** — 블로킹 없이 장시간 처리 실행
- **권한 모드** — `default`, `acceptEdits`, `plan`, `dontAsk`, `bypassPermissions`
- **헤드리스 모드** — CI/CD에서 Claude Code 실행: `claude -p "Run tests and generate report"`
- **세션 관리** — `/resume`, `/rename`, `/fork`, `claude -c`, `claude -r`
- **설정** — `~/.claude/settings.json`에서 동작 커스터마이즈

전체 설정 예시는 [config-examples.json](09-advanced-features/config-examples.json)을 참고하세요.

</details>

<details>
<summary>10. CLI 레퍼런스</summary>

**위치**: [10-cli/](10-cli/)

**개요**: Claude Code 명령줄 인터페이스 완전 레퍼런스

**간단한 예시**:
```bash
# 대화형 모드
claude "explain this project"

# 출력 모드 (비대화형)
claude -p "review this code"

# 파일 내용 처리
cat error.log | claude -p "explain this error"

# 스크립트용 JSON 출력
claude -p --output-format json "list functions"

# 세션 재개
claude -r "feature-auth" "continue implementation"
```

**사용 사례**: CI/CD 파이프라인 통합, 스크립트 자동화, 배치 처리, 다중 세션 워크플로, 커스텀 에이전트 설정

</details>

<details>
<summary>워크플로 예시</summary>

### 완전한 코드 리뷰 워크플로

```markdown
# 사용 기능: 슬래시 명령어 + 서브에이전트 + 메모리 + MCP

User: /review-pr

Claude:
1. 프로젝트 메모리(코딩 규약)를 읽어 들임
2. GitHub MCP를 통해 PR 가져오기
3. code-reviewer 서브에이전트에 위임
4. test-engineer 서브에이전트에 위임
5. 결과 통합
6. 포괄적인 리뷰 제공
```

### 문서 자동 생성

```markdown
# 사용 기능: 스킬 + 서브에이전트 + 메모리

User: "auth 모듈의 API 문서를 생성해 줘"

Claude:
1. 프로젝트 메모리(문서 규약)를 읽어 들임
2. 문서 생성 요청 감지
3. doc-generator 스킬 자동 실행
4. api-documenter 서브에이전트에 위임
5. 예시가 포함된 포괄적인 문서 작성
```

### DevOps 배포

```markdown
# 사용 기능: 플러그인 + MCP + 훅

User: /deploy production

Claude:
1. 배포 전 훅 실행(환경 검증)
2. deployment-specialist 서브에이전트에 위임
3. Kubernetes MCP를 통해 배포 실행
4. 진행 상황 모니터링
5. 배포 후 훅 실행(헬스 체크)
6. 상태 보고
```

</details>

<details>
<summary>디렉터리 구조</summary>

```
├── 01-slash-commands/
│   ├── optimize.md
│   ├── pr.md
│   ├── generate-api-docs.md
│   └── README.md
├── 02-memory/
│   ├── project-CLAUDE.md
│   ├── directory-api-CLAUDE.md
│   ├── personal-CLAUDE.md
│   └── README.md
├── 03-skills/
│   ├── code-review/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   └── templates/
│   ├── brand-voice/
│   │   ├── SKILL.md
│   │   └── templates/
│   ├── doc-generator/
│   │   ├── SKILL.md
│   │   └── generate-docs.py
│   └── README.md
├── 04-subagents/
│   ├── code-reviewer.md
│   ├── test-engineer.md
│   ├── documentation-writer.md
│   ├── secure-reviewer.md
│   ├── implementation-agent.md
│   └── README.md
├── 05-mcp/
│   ├── github-mcp.json
│   ├── database-mcp.json
│   ├── filesystem-mcp.json
│   ├── multi-mcp.json
│   └── README.md
├── 06-hooks/
│   ├── format-code.sh
│   ├── pre-commit.sh
│   ├── security-scan.sh
│   ├── log-bash.sh
│   ├── validate-prompt.sh
│   ├── notify-team.sh
│   └── README.md
├── 07-plugins/
│   ├── pr-review/
│   ├── devops-automation/
│   ├── documentation/
│   └── README.md
├── 08-checkpoints/
│   ├── checkpoint-examples.md
│   └── README.md
├── 09-advanced-features/
│   ├── config-examples.json
│   ├── planning-mode-examples.md
│   └── README.md
├── 10-cli/
│   └── README.md
└── README.md (이 파일)
```

</details>

<details>
<summary>모범 사례</summary>

### 권장 사항
- 슬래시 명령어부터 간단하게 시작하기
- 기능을 단계적으로 추가하기
- 메모리에 팀 규약 넣기
- 설정은 먼저 로컬에서 시험하기
- 커스텀 구현을 문서화하기
- 프로젝트 설정을 버전 관리하기
- 플러그인을 팀과 공유하기

### 피해야 할 것
- 중복된 기능을 만들지 않기
- 인증 정보를 하드코딩하지 않기
- 문서화를 건너뛰지 않기
- 단순한 작업을 지나치게 복잡하게 만들지 않기
- 보안 모범 사례를 무시하지 않기
- 민감한 데이터를 커밋하지 않기

</details>

<details>
<summary>문제 해결</summary>

### 기능이 로드되지 않을 때
1. 파일 위치와 이름 확인
2. YAML 프런트매터 문법 확인
3. 파일 권한 확인
4. Claude Code 버전 호환성 확인

### MCP 연결 실패
1. 환경 변수 확인
2. MCP 서버 설치 확인
3. 인증 정보 테스트
4. 네트워크 연결 확인

### 서브에이전트에 위임되지 않을 때
1. 도구 권한 확인
2. 에이전트 설명문이 명확한지 확인
3. 작업 복잡도 확인
4. 에이전트 단독으로 테스트

</details>

<details>
<summary>테스트</summary>

이 프로젝트에는 포괄적인 자동 테스트가 포함되어 있습니다.

- **단위 테스트**: pytest를 사용한 Python 테스트(Python 3.10, 3.11, 3.12)
- **코드 품질**: Ruff 린팅과 포맷
- **보안**: Bandit 취약점 스캔
- **타입 검사**: mypy 정적 타입 분석
- **빌드 검증**: EPUB 생성 테스트
- **커버리지 측정**: Codecov 통합

```bash
# 개발 의존성 설치
uv pip install -r requirements-dev.txt

# 모든 단위 테스트 실행
pytest scripts/tests/ -v

# 커버리지 리포트와 함께 테스트 실행
pytest scripts/tests/ -v --cov=scripts --cov-report=html

# 코드 품질 검사
ruff check scripts/
ruff format --check scripts/

# 보안 스캔
bandit -c pyproject.toml -r scripts/ --exclude scripts/tests/

# 타입 검사
mypy scripts/ --ignore-missing-imports
```

`main`/`develop`으로 push할 때와 `main`으로 PR을 열 때 테스트가 자동 실행됩니다. 자세한 내용은 [TESTING.md](../.github/TESTING.md)를 참고하세요.

</details>

<details>
<summary>EPUB 생성</summary>

이 가이드를 오프라인에서 읽고 싶다면 EPUB 전자책을 생성하세요.

```bash
uv run scripts/build_epub.py
```

이렇게 하면 렌더링된 Mermaid 다이어그램을 포함한 전체 콘텐츠의 `claude-howto-guide.epub`이 만들어집니다.

자세한 옵션은 [scripts/README.md](../scripts/README.md)를 참고하세요.

</details>

<details>
<summary>기여하기</summary>

문제를 발견했거나 예제를 제공하고 싶다면 환영합니다.

**자세한 가이드라인은 [CONTRIBUTING.md](CONTRIBUTING.md)를 참고하세요:**
- 기여 종류(예제, 문서, 기능, 버그, 피드백)
- 개발 환경 설정 방법
- 디렉터리 구조와 콘텐츠 추가 방법
- 작성 가이드라인과 모범 사례
- 커밋 및 PR 프로세스

**커뮤니티 표준:**
- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) — 구성원끼리 서로를 대하는 방식
- [SECURITY.md](SECURITY.md) — 보안 정책과 취약점 보고

### 보안 문제 보고

보안 취약점을 발견했다면 책임감 있는 방식으로 보고해 주세요.

1. **GitHub의 비공개 취약점 보고를 사용합니다**: https://github.com/luongnv89/claude-howto/security/advisories
2. **또는** [.github/SECURITY_REPORTING.md](../.github/SECURITY_REPORTING.md)에서 자세한 절차를 읽습니다
3. 보안 취약점에 대해서는 **공개 issue를 만들지 않습니다**

퀵 스타트:
1. 저장소를 포크하고 클론합니다
2. 내용을 알 수 있는 브랜치 이름을 만듭니다(`add/feature-name`, `fix/bug`, `docs/improvement` 등)
3. 가이드라인에 따라 변경합니다
4. 명확한 설명을 붙여 풀 리퀘스트를 보냅니다

**도움이 필요하신가요?** issue나 디스커션을 열어 주시면 절차를 안내해 드립니다.

</details>

<details>
<summary>추가 리소스</summary>

- [Claude Code Documentation](https://code.claude.com/docs/en/overview)
- [MCP Protocol Specification](https://modelcontextprotocol.io)
- [Skills Repository](https://github.com/luongnv89/skills) — 바로 쓸 수 있는 스킬 모음
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook)
- [Boris Cherny's Claude Code Workflow](https://x.com/bcherny/status/2007179832300581177) — Claude Code 제작자가 체계화한 워크플로 공유: 병렬 에이전트, 공유 CLAUDE.md, 플랜 모드, 슬래시 명령어, 서브에이전트, 자율적인 장시간 세션을 위한 검증 훅.

</details>

---

## 기여하기

기여를 환영합니다. 시작 방법은 [Contributing Guide](CONTRIBUTING.md)를 참고하세요.

---

## 라이선스

MIT License — [LICENSE](../LICENSE)를 참고하세요. 사용, 수정, 재배포는 자유입니다. 유일한 조건은 라이선스 표기를 포함하는 것입니다.

---

**최종 업데이트**: 2026년 10월 18일
**Claude Code 버전**: 2.1.302
**정보 출처**:
- https://code.claude.com/docs/en/tools-reference#task-tool-availability
- https://code.claude.com/docs/en/hooks
- https://code.claude.com/docs/en/overview
- https://code.claude.com/docs/en/changelog
- https://github.com/anthropics/claude-code/releases/tag/v2.1.119
- https://github.com/anthropics/claude-code/releases/tag/v2.1.113
- https://code.claude.com/docs/en/setup
- https://code.claude.com/docs/en/mcp
- https://code.claude.com/docs/en/plugins/install
- https://code.claude.com/docs/en/checkpointing
- https://code.claude.com/docs/en/model-config
- https://github.com/anthropics/claude-code
**호환 모델**: Claude Sonnet 4.6, Claude Opus 4.7, Claude Haiku 4.5
