<!-- i18n-source: 05-mcp/README.md -->
<!-- i18n-source-sha: d17d515 -->
<!-- i18n-date: 2026-10-26 -->

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../../resources/logos/claude-howto-logo.svg">
</picture>

# MCP(Model Context Protocol)

이 폴더에는 Claude Code에서 MCP 서버를 설정하고 사용하는 방법에 관한 포괄적인 문서와 예제가 들어 있습니다.

## 개요

MCP(Model Context Protocol)는 Claude가 외부 도구, API, 실시간 데이터 소스에 접근하기 위한 표준화된 방식입니다. 메모리와 달리 MCP는 변화하는 데이터에 대한 실시간 접근을 제공합니다.

주요 특징:
- 외부 서비스에 대한 실시간 접근
- 라이브 데이터 동기화
- 확장 가능한 아키텍처
- 안전한 인증
- 도구 기반 상호작용

## MCP 아키텍처

```mermaid
graph TB
    A["Claude"]
    B["MCP Server"]
    C["External Service"]

    A -->|Request: list_issues| B
    B -->|Query| C
    C -->|Data| B
    B -->|Response| A

    A -->|Request: create_issue| B
    B -->|Action| C
    C -->|Result| B
    B -->|Response| A

    style A fill:#e1f5fe,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
    style C fill:#e8f5e9,stroke:#333,color:#333
```

## MCP 생태계

```mermaid
graph TB
    A["Claude"] -->|MCP| B["Filesystem<br/>MCP Server"]
    A -->|MCP| C["GitHub<br/>MCP Server"]
    A -->|MCP| D["Database<br/>MCP Server"]
    A -->|MCP| E["Slack<br/>MCP Server"]
    A -->|MCP| F["Google Docs<br/>MCP Server"]

    B -->|File I/O| G["Local Files"]
    C -->|API| H["GitHub Repos"]
    D -->|Query| I["PostgreSQL/MySQL"]
    E -->|Messages| J["Slack Workspace"]
    F -->|Docs| K["Google Drive"]

    style A fill:#e1f5fe,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
    style C fill:#f3e5f5,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#f3e5f5,stroke:#333,color:#333
    style F fill:#f3e5f5,stroke:#333,color:#333
    style G fill:#e8f5e9,stroke:#333,color:#333
    style H fill:#e8f5e9,stroke:#333,color:#333
    style I fill:#e8f5e9,stroke:#333,color:#333
    style J fill:#e8f5e9,stroke:#333,color:#333
    style K fill:#e8f5e9,stroke:#333,color:#333
```

## MCP 설치 방법

Claude Code는 MCP 서버 연결을 위해 여러 전송(transport) 프로토콜을 지원합니다.

### HTTP 전송 (권장)

```bash
# 기본 HTTP 연결
claude mcp add --transport http notion https://mcp.notion.com/mcp

# 인증 헤더가 있는 HTTP
claude mcp add --transport http secure-api https://api.example.com/mcp \
  --header "Authorization: Bearer your-token"
```

### Stdio 전송 (로컬)

로컬에서 동작하는 MCP 서버용:

```bash
# 로컬 Node.js 서버
claude mcp add --transport stdio myserver -- npx @myorg/mcp-server

# 환경 변수 포함
claude mcp add --transport stdio myserver --env KEY=value -- npx server
```

### SSE 전송 (사용 중단 예정)

Server-Sent Events 전송은 `http`의 등장으로 사용 중단 예정(deprecated)이 되었지만, 계속 지원됩니다.

```bash
claude mcp add --transport sse legacy-server https://example.com/sse
```

### WebSocket 전송 (`ws`)

WebSocket 서버는 지속적인 양방향 연결을 유지하므로, Claude에게 자발적으로 이벤트를 푸시하는 원격 MCP 서버에 적합합니다. 서버가 요청에 응답하기만 한다면 HTTP를 사용하세요. HTTP는 OAuth와 `claude mcp add --transport` 플래그를 모두 지원하지만, WebSocket은 둘 다 지원하지 않습니다.

`--transport`는 `ws`를 받지 않으므로 `.mcp.json` 또는 `claude mcp add-json`으로 설정합니다.

```json
{
  "type": "ws",
  "url": "wss://mcp.example.com/socket",
  "headers": {
    "Authorization": "Bearer YOUR_TOKEN"
  }
}
```

`type: "ws"` 항목은 `http`와 같은 `url`, `headers`, `headersHelper`, `timeout`, `alwaysLoad` 필드를 받습니다. 인증은 **헤더만** 가능하며, WebSocket 서버용 OAuth 흐름은 존재하지 않습니다.

> **참고**: v2.1.285 이후 `claude mcp list`는 WebSocket(`ws`) 서버를 URL과 상태(health)와 함께 목록에 표시합니다 (그 이전 버전에서는 표시되지 않았습니다). `claude mcp get <이름>` 또는 `/mcp` 패널에서도 확인할 수 있습니다.

HTTP나 SSE와 마찬가지로 WebSocket 연결의 유휴 시간은 5분입니다. stdio와 WebSocket에는 요청 단위 타이머가 없습니다. `type`이 없는 `url` 항목은 오류가 되며, 유효한 값으로 `"http"`, `"sse"`, `"ws"`가 안내됩니다.

### Windows 관련 주의점

네이티브 Windows(WSL이 아닌)에서는 npx 명령어에 `cmd /c`를 사용합니다.

```bash
claude mcp add --transport stdio my-server -- cmd /c npx -y @some/package
```

### OAuth 2.0 인증

Claude Code는 OAuth 2.0이 필요한 MCP 서버를 지원합니다. OAuth를 지원하는 서버에 연결할 때 Claude Code가 인증 흐름 전체를 처리합니다.

```bash
# OAuth 지원 MCP 서버에 연결 (대화형 흐름)
claude mcp add --transport http my-service https://my-service.example.com/mcp

# 비대화형 설정을 위해 OAuth 인증 정보를 미리 설정
claude mcp add --transport http my-service https://my-service.example.com/mcp \
  --client-id "your-client-id" \
  --client-secret "your-client-secret" \
  --callback-port 8080
```

| 기능 | 설명 |
|------|------|
| **대화형 OAuth** | `/mcp`를 사용해 브라우저 기반 OAuth 흐름을 트리거 |
| **사전 설정된 OAuth 클라이언트** | Notion, Stripe 등 일반적인 서비스용 내장 OAuth 클라이언트 (v2.1.30 이상) |
| **사전 설정된 인증 정보** | 자동 설정용 `--client-id`, `--client-secret`, `--callback-port` 플래그 |
| **토큰 저장** | 토큰은 시스템 키체인에 안전하게 저장됨 |
| **단계적 인증(step-up)** | 특권 작업에 대한 단계적 인증 지원 |
| **디스커버리 캐시** | OAuth 디스커버리 메타데이터가 캐시되어 재연결이 빨라짐 |
| **메타데이터 재정의** | `.mcp.json`의 `oauth.authServerMetadataUrl`로 기본 OAuth 메타데이터 디스커버리를 재정의 |

#### OAuth 메타데이터 디스커버리 재정의

MCP 서버가 표준 OAuth 메타데이터 엔드포인트(`/.well-known/oauth-authorization-server`)에서 오류를 반환하지만 동작하는 OIDC 엔드포인트를 공개하고 있다면, Claude Code가 특정 URL에서 OAuth 메타데이터를 가져오도록 지시할 수 있습니다. 서버 설정의 `oauth` 객체 안에 `authServerMetadataUrl`을 설정합니다.

```json
{
  "mcpServers": {
    "my-server": {
      "type": "http",
      "url": "https://mcp.example.com/mcp",
      "oauth": {
        "authServerMetadataUrl": "https://auth.example.com/.well-known/openid-configuration"
      }
    }
  }
}
```

URL은 `https://`를 사용해야 합니다. 이 옵션은 Claude Code v2.1.64 이상이 필요합니다.

### Claude.ai MCP 커넥터

Claude.ai 계정에서 설정한 MCP 서버는 Claude Code에서도 자동으로 사용할 수 있게 됩니다. 즉, Claude.ai 웹 인터페이스를 통해 설정한 MCP 연결은 추가 설정 없이 접근할 수 있습니다.

Claude.ai MCP 커넥터는 `--print` 모드(v2.1.83 이상)에서도 사용할 수 있어 비대화형 스크립트 실행이 가능합니다.

> **시작 시 참고 (v2.1.117 이상):** 로컬과 claude.ai의 MCP 서버가 모두 설정되어 있으면 병렬 연결이 기본이 됩니다 (이전에는 순차 연결). 여러 서버를 사용할 때 시작 지연이 줄어듭니다.

Claude Code 안에서 Claude.ai MCP 서버를 비활성화하려면 `ENABLE_CLAUDEAI_MCP_SERVERS` 환경 변수를 `false`로 설정합니다.

```bash
ENABLE_CLAUDEAI_MCP_SERVERS=false claude
```

> **참고:** 이 기능은 Claude.ai 계정으로 로그인한 사용자만 사용할 수 있습니다.

## MCP 설정 흐름

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Config as Config File
    participant Service as External Service

    User->>Claude: Type /mcp
    Claude->>Claude: List available MCP servers
    Claude->>User: Show options
    User->>Claude: Select GitHub MCP
    Claude->>Config: Update configuration
    Config->>Claude: Activate connection
    Claude->>Service: Test connection
    Service-->>Claude: Authentication successful
    Claude->>User: ✅ MCP connected!
```

## MCP 도구 검색

도구 검색은 기본적으로 활성화되어 있습니다. MCP 도구는 지연 로드되어 필요할 때 검색되므로, 그 정의가 모델 컨텍스트를 채우지 않습니다. `ANTHROPIC_BASE_URL`이 퍼스트파티가 아닌 호스트를 가리키는 경우, 대부분의 프록시가 필요한 블록을 전달하지 않기 때문에 Claude Code는 도구 검색을 비활성화합니다.

| 설정 | 값 | 설명 |
|------|-----|------|
| `ENABLE_TOOL_SEARCH` | (미설정 — 기본값) | 모든 MCP 도구를 지연시키고 필요할 때 읽어 들입니다 |
| `ENABLE_TOOL_SEARCH` | `auto` | 임계값 모드: 도구 정의가 컨텍스트 윈도우의 10%에 이를 때까지는 도구를 미리 읽어 들이고, 이른 시점에 전부 지연시킵니다 |
| `ENABLE_TOOL_SEARCH` | `auto:<N>` | 사용자 지정 비율(0-100)에 따른 임계값 모드. 예: `auto:5`는 5% |
| `ENABLE_TOOL_SEARCH` | `true` | 모든 MCP 도구를 지연 |
| `ENABLE_TOOL_SEARCH` | `false` | 비활성화. 모든 도구 설명이 완전한 형태로 전송됩니다 |

> **참고:** 도구 검색에는 `tool_reference` 블록을 지원하는 모델이 필요합니다: Claude Opus 4, Claude Sonnet 4, Claude Haiku 4.5 및 그 이후 모델 (Google Cloud의 Agent Platform에서는 Opus 4.5, Sonnet 4.5, Haiku 4.5 이상).

## 동적 도구 업데이트

Claude Code는 MCP의 `list_changed` 알림을 지원합니다. MCP 서버가 사용 가능한 도구를 동적으로 추가·삭제·변경하면 Claude Code는 업데이트를 받아 도구 목록을 자동으로 조정합니다. 재연결이나 재시작은 필요 없습니다.

## MCP Apps

MCP Apps는 최초의 공식 MCP 확장으로, MCP 도구 호출이 채팅 인터페이스에 직접 렌더링되는 대화형 UI 컴포넌트를 반환할 수 있게 합니다. 평문 응답 대신 MCP 서버가 풍부한 대시보드, 폼, 데이터 시각화, 다단계 워크플로를 채팅 안에 직접 표시할 수 있습니다. 대화를 벗어나지 않고 모든 것이 인라인으로 표시됩니다.

## MCP Elicitation

MCP 서버는 대화형 다이얼로그를 통해 사용자에게 구조화된 입력을 요청할 수 있습니다 (v2.1.49 이상). 이를 통해 MCP 서버는 워크플로 도중에 추가 정보를 요청할 수 있습니다. 예를 들어 확인 프롬프트, 선택지 목록에서 고르기, 필수 필드 입력 등이 가능해져 MCP 서버와의 상호작용에 대화성이 더해집니다.

## 도구 설명과 지시의 상한

Claude Code는 장황한 서버가 컨텍스트를 비대하게 만들지 않도록 MCP 도구 설명과 각 서버의 지시를 잘라냅니다. 기본 상한은 서버 지시와 처음부터 읽어 들이는 도구 설명이 **4,096자**(v2.1.296. 그 이전에는 v2.1.84부터 2,048자), Claude가 tool search를 통해 읽어 들이는 설명이 **16,384자**(v2.1.295)입니다. v2.1.280 이후에는 `CLAUDE_CODE_MAX_MCP_DESCRIPTION_LENGTH`로 재정의할 수 있으며, 설정한 숫자가 **두 상한 모두**를 대체합니다 (`8192`이면 짧은 쪽 상한은 올라가고 긴 쪽은 내려갑니다). v2.1.299 이후 `api.anthropic.com`에 있는 Anthropic 퍼스트파티 MCP 서버의 설명과 지시는 잘리지 않고 Claude에게 전달됩니다. 중요한 정보는 설명의 앞부분에 두세요.

## MCP 프롬프트를 슬래시 명령어로 사용하기

MCP 서버는 슬래시 명령어로 표시되는 프롬프트를 공개할 수 있습니다. 프롬프트는 다음 명명 규칙으로 접근합니다.

```
/mcp__<server>__<prompt>
```

예를 들어 `github`라는 이름의 서버가 `review`라는 프롬프트를 공개하고 있다면 `/mcp__github__review`로 호출할 수 있습니다.

## 서버 중복 제거

같은 MCP 서버가 여러 범위(local, project, user)에 정의되어 있으면 로컬 설정이 우선합니다. 덕분에 충돌 없이 로컬 사용자 지정으로 project 수준이나 user 수준의 MCP 설정을 재정의할 수 있습니다.

## @ 멘션으로 MCP 리소스 사용하기

`@` 멘션 구문을 사용해 프롬프트 안에서 MCP 리소스를 직접 참조할 수 있습니다.

```
@server-name:protocol://resource/path
```

예를 들어 특정 데이터베이스 리소스를 참조하려면:

```
@database:postgres://mydb/users
```

이렇게 하면 Claude가 MCP 리소스의 내용을 대화 컨텍스트의 일부로 인라인으로 가져와 포함할 수 있습니다.

## MCP 범위(scope)

MCP 설정은 공유 수준이 다른 여러 범위에 저장할 수 있습니다.

| 범위 | 플래그 | 위치 | 설명 | 공유 대상 | 승인 필요 여부 |
|----------|--------|------|------|----------|-----------|
| **Local** (기본값) | `--scope local` | `~/.claude.json` (프로젝트 경로 아래) | 현재 사용자, 현재 프로젝트에 비공개 (구버전에서는 `project`라고 불림) | 본인만 | 불필요 |
| **Project** | `--scope project` | `.mcp.json` | git 저장소에 체크인됨 | 팀원 | 필요 (최초 사용 시) |
| **User** | `--scope user` | `~/.claude.json` | 모든 프로젝트에서 사용 가능 (구버전에서는 `global`이라고 불림) | 본인만 | 불필요 |

서버를 추가할 때의 범위는 `--scope`(축약형 `-s`)로 선택합니다. 생략하면
Claude Code는 `local`을 사용합니다.

```bash
# Project 범위 — .mcp.json에 기록되어 팀과 공유됨
claude mcp add --scope project --transport http github https://api.githubcopilot.com/mcp/ --header "Authorization: Bearer YOUR_GITHUB_PAT"

# User 범위 — 모든 프로젝트에서 사용할 수 있음
claude mcp add --scope user --transport stdio memory -- npx @modelcontextprotocol/server-memory
```

### Project 범위 사용하기

프로젝트 고유의 MCP 설정을 `.mcp.json`에 저장합니다.

```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": {
        "Authorization": "Bearer ${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }
}
```

팀원에게는 프로젝트 MCP를 처음 사용할 때 승인 프롬프트가 표시됩니다.

## MCP 설정 관리

### MCP 서버 추가

```bash
# HTTP 기반 서버 추가
claude mcp add --transport http github https://api.githubcopilot.com/mcp/ --header "Authorization: Bearer YOUR_GITHUB_PAT"

# 로컬 stdio 서버 추가
claude mcp add --transport stdio database -- npx @company/db-server

# 모든 MCP 서버 목록 표시
claude mcp list

# 특정 서버의 세부 정보 가져오기
claude mcp get github

# MCP 서버 삭제
claude mcp remove github

# 프로젝트별 승인 선택 초기화
claude mcp reset-project-choices

# Claude Desktop에서 가져오기
claude mcp add-from-claude-desktop
```

## 사용 가능한 MCP 서버 목록

| MCP 서버 | 용도 | 일반적인 도구 | 인증 | 실시간 |
|--------------|------|----------------|------|--------------|
| **Filesystem** | 파일 조작 | read, write, delete | OS 권한 | ✅ Yes |
| **GitHub** | 저장소 관리 | list_prs, create_issue, push | OAuth | ✅ Yes |
| **Slack** | 팀 커뮤니케이션 | send_message, list_channels | 토큰 | ✅ Yes |
| **Database** | SQL 쿼리 | query, insert, update | 인증 정보 | ✅ Yes |
| **Google Docs** | 문서 접근 | read, write, share | OAuth | ✅ Yes |
| **Asana** | 프로젝트 관리 | create_task, update_status | API 키 | ✅ Yes |
| **Stripe** | 결제 데이터 | list_charges, create_invoice | API 키 | ✅ Yes |
| **Memory** | 영속 메모리 | store, retrieve, delete | 로컬 | ❌ No |

## 실전 예제

### 예제 1: GitHub MCP 설정

**파일:** `.mcp.json` (프로젝트 루트)

```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": {
        "Authorization": "Bearer ${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }
}
```

**사용 가능한 GitHub MCP 도구:**

#### 풀 리퀘스트 관리
- `list_prs` - 저장소의 모든 PR 목록
- `get_pr` - diff를 포함한 PR 세부 정보 가져오기
- `create_pr` - 새 PR 만들기
- `update_pr` - PR 설명·제목 업데이트
- `merge_pr` - PR을 main 브랜치에 머지
- `review_pr` - 리뷰 댓글 추가

**요청 예시:**
```
/mcp__github__get_pr 456

# Returns:
Title: Add dark mode support
Author: @alice
Description: Implements dark theme using CSS variables
Status: OPEN
Reviewers: @bob, @charlie
```

#### 이슈 관리
- `list_issues` - 모든 이슈 목록
- `get_issue` - 이슈 세부 정보 가져오기
- `create_issue` - 새 이슈 만들기
- `close_issue` - 이슈 닫기
- `add_comment` - 이슈에 댓글 추가

#### 저장소 정보
- `get_repo_info` - 저장소 세부 정보
- `list_files` - 파일 트리 구조
- `get_file_content` - 파일 내용 읽기
- `search_code` - 코드베이스 전체 검색

#### 커밋 작업
- `list_commits` - 커밋 이력
- `get_commit` - 특정 커밋의 세부 정보
- `create_commit` - 새 커밋 만들기

**설정:**
```bash
export GITHUB_PERSONAL_ACCESS_TOKEN="your_github_token"
# 또는 CLI로 직접 추가:
claude mcp add --transport http github https://api.githubcopilot.com/mcp/ --header "Authorization: Bearer YOUR_GITHUB_PAT"
```

### 설정에서의 환경 변수 확장

MCP 설정은 환경 변수 확장과 대체 기본값을 지원합니다. `${VAR}` 및 `${VAR:-default}` 구문은 다음 필드에서 동작합니다: `command`, `args`, `env`, `url`, `headers`.

```json
{
  "mcpServers": {
    "api-server": {
      "type": "http",
      "url": "${API_BASE_URL:-https://api.example.com}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}",
        "X-Custom-Header": "${CUSTOM_HEADER:-default-value}"
      }
    },
    "local-server": {
      "command": "${MCP_BIN_PATH:-npx}",
      "args": ["${MCP_PACKAGE:-@company/mcp-server}"],
      "env": {
        "DB_URL": "${DATABASE_URL:-postgresql://localhost/dev}"
      }
    }
  }
}
```

변수는 실행 시에 확장됩니다.
- `${VAR}` - 환경 변수를 사용합니다. 미설정(그리고 기본값 없음)인 경우에도 서버는 리터럴 `${VAR}` 그대로 읽어 들여지며, `claude mcp list`와 `/mcp`가 변수 누락을 경고합니다
- `${VAR:-default}` - 환경 변수를 사용하고, 미설정이면 default로 대체합니다

### 예제 2: Database MCP 설정

**설정:**

```json
{
  "mcpServers": {
    "database": {
      "command": "npx",
      "args": ["-y", "@bytebase/dbhub", "--dsn", "${DATABASE_URL}"]
    }
  }
}
```

**사용 예:**

```markdown
User: Fetch all users with more than 10 orders

Claude: I'll query your database to find that information.

# Using MCP database tool:
SELECT u.*, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id
HAVING COUNT(o.id) > 10
ORDER BY order_count DESC;

# Results:
- Alice: 15 orders
- Bob: 12 orders
- Charlie: 11 orders
```

**설정 방법:**
```bash
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
claude mcp add --transport stdio database -- npx -y @bytebase/dbhub \
  --dsn "$DATABASE_URL"
```

> **Warning**: 이 설정에서는 Claude에게 쓰기 권한이 부여됩니다. DBHub의 `execute_sql` 도구는 읽기 전용 모드를 활성화하지 않는 한 `UPDATE`, `DELETE`, `DROP`을 포함한 모든 SQL을 실행합니다. 프로덕션 환경이 아니라 로컬 또는 일회용 데이터베이스를 사용하세요.

**읽기 전용 설정 (권장):**

`SELECT`만 실행할 수 있는 데이터베이스 사용자를 만듭니다 (PostgreSQL 예시):

```sql
CREATE ROLE claude_readonly LOGIN PASSWORD 'change-me';
GRANT CONNECT ON DATABASE mydb TO claude_readonly;
GRANT USAGE ON SCHEMA public TO claude_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO claude_readonly;
```

`dbhub.toml`에서 읽기 전용 모드를 활성화합니다. 예전의 `--readonly` 플래그는 더 이상 사용할 수 없습니다. DBHub는 `${DATABASE_URL}`을 환경 변수에서 읽어 들이므로 파일에 인증 정보를 적을 필요는 없습니다:

```toml
[[sources]]
id = "default"
dsn = "${DATABASE_URL}"

[[tools]]
name = "execute_sql"
source = "default"
readonly = true
```

`--dsn` 대신 이 파일을 DBHub에 지정합니다. Claude Code는 같은 이름의 서버를 중복해서 추가할 수 없으므로, 먼저 위에서 추가한 쓰기 가능한 `database` 서버를 삭제하세요:

```bash
# 위에서 추가한 쓰기 가능한 서버를 교체
claude mcp remove database
export DATABASE_URL="postgresql://claude_readonly:change-me@localhost/mydb"
claude mcp add --transport stdio database -- npx -y @bytebase/dbhub \
  --config "$PWD/dbhub.toml"
```

읽기 전용 모드는 SQL 문자열을 검사하는 방식이라 과거에 우회된 사례가 있습니다 (DBHub 0.22.6에서 수정됨). 데이터를 진짜로 지켜 주는 것은 `SELECT` 전용 사용자입니다. 자세한 내용은 [DBHub의 읽기 전용 모드](https://dbhub.ai/tools/execute-sql#read-only-mode)를 참고하세요.

### 예제 3: 다중 MCP 워크플로

**시나리오: 일일 보고서 생성**

```markdown
# Daily Report Workflow using Multiple MCPs

## Setup
1. GitHub MCP - fetch PR metrics
2. Database MCP - query sales data
3. Slack MCP - post report
4. Filesystem MCP - save report

## Workflow

### Step 1: Fetch GitHub Data
/mcp__github__list_prs completed:true last:7days

Output:
- Total PRs: 42
- Average merge time: 2.3 hours
- Review turnaround: 1.1 hours

### Step 2: Query Database
SELECT COUNT(*) as sales, SUM(amount) as revenue
FROM orders
WHERE created_at > NOW() - INTERVAL '1 day'

Output:
- Sales: 247
- Revenue: $12,450

### Step 3: Generate Report
Combine data into HTML report

### Step 4: Save to Filesystem
Write report.html to /reports/

### Step 5: Post to Slack
Send summary to #daily-reports channel

Final Output:
✅ Report generated and posted
📊 47 PRs merged this week
💰 $12,450 in daily sales
```

**설정 방법:**
```bash
export GITHUB_PERSONAL_ACCESS_TOKEN="your_github_token"
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
export SLACK_BOT_TOKEN="your_slack_bot_token"
export SLACK_TEAM_ID="your_slack_team_id"
# 각 MCP 서버를 CLI로 추가하거나 .mcp.json으로 설정
```

### 예제 4: Filesystem MCP 조작

**설정:**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "/home/user/projects"]
    }
  }
}
```

**사용 가능한 조작:**

| 조작 | 명령어 | 용도 |
|------|----------|------|
| 파일 목록 | `ls ~/projects` | 디렉터리 내용 표시 |
| 파일 읽기 | `cat src/main.ts` | 파일 내용 읽기 |
| 파일 쓰기 | `create docs/api.md` | 새 파일 만들기 |
| 파일 편집 | `edit src/app.ts` | 파일 변경 |
| 검색 | `grep "async function"` | 파일 안 검색 |
| 삭제 | `rm old-file.js` | 파일 삭제 |

**설정 방법:**
```bash
# CLI로 직접 추가:
claude mcp add --transport stdio filesystem -- npx @modelcontextprotocol/server-filesystem /home/user/projects
```

## MCP와 메모리 비교: 판단 매트릭스

```mermaid
graph TD
    A["Need external data?"]
    A -->|No| B["Use Memory"]
    A -->|Yes| C["Does it change frequently?"]
    C -->|No/Rarely| B
    C -->|Yes/Often| D["Use MCP"]

    B -->|Stores| E["Preferences<br/>Context<br/>History"]
    D -->|Accesses| F["Live APIs<br/>Databases<br/>Services"]

    style A fill:#fff3e0,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#fff3e0,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#e8f5e9,stroke:#333,color:#333
    style F fill:#e8f5e9,stroke:#333,color:#333
```

## 요청/응답 패턴

```mermaid
sequenceDiagram
    participant App as Claude
    participant MCP as MCP Server
    participant DB as Database

    App->>MCP: Request: "SELECT * FROM users WHERE id=1"
    MCP->>DB: Execute query
    DB-->>MCP: Result set
    MCP-->>App: Return parsed data
    App->>App: Process result
    App->>App: Continue task

    Note over MCP,DB: Real-time access<br/>No caching
```

## 환경 변수

민감한 인증 정보는 환경 변수에 저장합니다.

```bash
# ~/.bashrc or ~/.zshrc
export GITHUB_PERSONAL_ACCESS_TOKEN="ghp_xxxxxxxxxxxxx"
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
export SLACK_BOT_TOKEN="your-slack-bot-token"
export SLACK_TEAM_ID="T0000000000"
```

그리고 MCP 설정에서 참조합니다.

```json
{
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
  }
}
```

## Claude를 MCP 서버로 만들기 (`claude mcp serve`)

Claude Code 자체가 다른 애플리케이션을 위한 MCP 서버로 동작할 수 있습니다. 이를 통해 외부 도구, 에디터, 자동화 시스템이 표준 MCP 프로토콜을 거쳐 Claude의 기능을 활용할 수 있습니다.

```bash
# Claude Code를 stdio 위의 MCP 서버로 시작
claude mcp serve
```

다른 애플리케이션은 stdio 기반 MCP 서버와 똑같이 이 서버에 연결할 수 있습니다. 예를 들어 다른 Claude Code 인스턴스에 Claude Code를 MCP 서버로 추가하려면:

```bash
claude mcp add --transport stdio claude-agent -- claude mcp serve
```

이는 한 Claude 인스턴스가 다른 인스턴스를 오케스트레이션하는 멀티 에이전트 워크플로를 구축하는 데 유용합니다.

## 관리형 MCP 설정 (엔터프라이즈)

엔터프라이즈 환경에서는 IT 관리자가 두 가지 독립된 장치로 MCP 서버 정책을 강제합니다. 고정된 서버 집합을 배타적인 통제 아래 배포하는 `managed-mcp.json` 파일과, 설정된 서버 중 어느 것을 읽어 들일 수 있는지 필터링하는 `allowedMcpServers` / `deniedMcpServers` 설정 키입니다.

**배치 위치:**
- macOS: `/Library/Application Support/ClaudeCode/managed-mcp.json`
- Linux 및 WSL: `/etc/claude-code/managed-mcp.json`
- Windows: `C:\Program Files\ClaudeCode\managed-mcp.json`

`managed-mcp.json`은 프로젝트의 `.mcp.json`과 같은 형식, 즉 최상위 `mcpServers` 맵을 사용합니다. 서버를 배포하는 것이지 필터링하는 것이 아닙니다.

```json
{
  "mcpServers": {
    "example-remote": {
      "type": "http",
      "url": "https://mcp.example.com/mcp"
    },
    "company-internal": {
      "type": "stdio",
      "command": "/usr/local/bin/company-mcp-server",
      "args": ["--config", "/etc/company/mcp-config.json"]
    }
  }
}
```

이 파일은 머신의 어떤 사용자든 읽을 수 있으므로 `env` 블록에 인증 정보를 두어서는 안 됩니다. 대신 `${VAR}` 확장, OAuth 또는 `headersHelper`를 사용합니다.

**필터링: 허용 목록과 거부 목록**

`allowedMcpServers`와 `deniedMcpServers`는 **설정 키이며 `managed-mcp.json`의 필드가 아닙니다**. 강제력을 갖게 하려면 관리형 설정 소스(server-managed settings, `managed-settings.json`, MDM 프로필 또는 레지스트리)에 둡니다.

- `allowedMcpServers` -- 허용할 서버의 허용 목록입니다. 같은 관리 소스 안에 `allowManagedMcpServersOnly: true`를 함께 적습니다. 함께 적지 않으면 허용 목록이 모든 범위에서 병합되어 사용자가 허용 범위를 넓힐 수 있게 됩니다.
- `deniedMcpServers` -- 차단할 서버의 거부 목록입니다. 항상 모든 범위에서 병합됩니다.

각 항목은 **단일** 키를 가진 객체입니다.

| 키 | 매칭 대상 |
|-----|-----------|
| `serverUrl` | 원격 서버의 URL. 완전 일치 또는 `*` 와일드카드 포함 |
| `serverCommand` | stdio 서버를 시작하는 정확한 명령어와 인수를 배열로 지정. 모든 인수를 순서대로 |
| `serverName` | 사용자가 붙인 라벨. **완전 일치만. 와일드카드는 확장되지 않음** |

**설정 예:**

```json
{
  "allowedMcpServers": [
    { "serverUrl": "https://mcp.example.com/*" },
    { "serverCommand": ["/usr/local/bin/company-mcp-server", "--config", "/etc/company/mcp-config.json"] }
  ],
  "deniedMcpServers": [
    { "serverName": "untrusted-server" },
    { "serverUrl": "http://*" }
  ],
  "allowManagedMcpServersOnly": true
}
```

> **참고:** `allowedMcpServers`와 `deniedMcpServers`가 모두 같은 서버에 매칭되면 deny 규칙이 우선합니다.

## 플러그인이 제공하는 MCP 서버

플러그인은 자체 MCP 서버를 번들로 포함할 수 있으며, 플러그인을 설치하면 자동으로 사용할 수 있게 됩니다. 플러그인이 제공하는 MCP 서버는 두 가지 방법으로 정의할 수 있습니다.

1. **독립형 `.mcp.json`** -- 플러그인의 루트 디렉터리에 `.mcp.json` 파일을 배치
2. **`plugin.json` 안에 인라인 정의** -- 플러그인 매니페스트 안에서 MCP 서버를 직접 정의

`${CLAUDE_PLUGIN_ROOT}` 변수를 사용해 플러그인 설치 디렉터리 기준의 상대 경로를 참조합니다.

```json
{
  "mcpServers": {
    "plugin-tools": {
      "command": "node",
      "args": ["${CLAUDE_PLUGIN_ROOT}/dist/mcp-server.js"],
      "env": {
        "CONFIG_PATH": "${CLAUDE_PLUGIN_ROOT}/config.json"
      }
    }
  }
}
```

## 서브에이전트 범위의 MCP

MCP 서버는 에이전트의 프런트매터 안에서 `mcpServers:` 키를 사용해 인라인으로 정의할 수 있으며, 프로젝트 전체가 아니라 특정 서브에이전트로 범위를 한정할 수 있습니다. 워크플로 안의 다른 에이전트에는 필요 없는 특정 MCP 서버에 어떤 에이전트가 접근해야 할 때 유용합니다.

```yaml
---
name: my-tool-agent
description: Uses my-tool for specialized operations
mcpServers:
  my-tool:
    type: http
    url: https://my-tool.example.com/mcp
---

You are an agent with access to my-tool for specialized operations.
```

서브에이전트 범위의 MCP 서버는 해당 에이전트의 실행 컨텍스트 안에서만 사용할 수 있으며, 부모 에이전트나 형제 에이전트와는 공유되지 않습니다.

## MCP 출력 상한

Claude Code는 컨텍스트 오버플로를 막기 위해 MCP 도구 출력에 상한을 강제합니다.

| 상한 | 임계값 | 동작 |
|------|----------|------|
| **경고** | 10,000 토큰 | 출력이 크다는 경고를 표시 |
| **기본 최댓값** | 25,000 토큰 | 이 상한을 넘는 출력은 파일에 저장되고, 대화에는 그 파일 경로가 들어감 |
| **디스크 영속화** | 50,000자 | 50K자를 넘는 도구 결과는 디스크에 영속화됨 |

최대 출력 상한은 `MAX_MCP_OUTPUT_TOKENS` 환경 변수로 설정할 수 있습니다.

```bash
# 최대 출력을 50,000 토큰으로 올리기
export MAX_MCP_OUTPUT_TOKENS=50000
```

## 코드 실행으로 컨텍스트 비대화 해결하기

MCP 도입이 확대되면서 수십 개의 서버와 수백~수천 개의 도구에 연결하는 일은 큰 과제를 낳습니다: **컨텍스트 비대화**입니다. 이는 MCP가 확장될 때 가장 큰 문제라고 할 수 있으며, Anthropic 엔지니어링 팀이 제안하는 우아한 해결책은 도구를 직접 호출하는 대신 코드 실행을 사용하는 방법입니다.

> **출처:** [Code Execution with MCP: Building More Efficient Agents](https://www.anthropic.com/engineering/code-execution-with-mcp) — Anthropic Engineering Blog

### 문제: 토큰 낭비의 두 가지 원인

**1. 도구 정의가 컨텍스트 윈도우를 과부하시킵니다**

대부분의 MCP 클라이언트는 모든 도구 정의를 미리 읽어 들입니다. 수천 개의 도구에 연결되어 있으면 모델은 사용자의 요청을 읽기도 전에 수십만 토큰을 처리해야 합니다.

**2. 중간 결과가 토큰을 더 소비합니다**

모든 중간 도구 결과는 모델의 컨텍스트를 거칩니다. Google Drive에서 Salesforce로 회의 녹취록을 옮기는 경우를 생각하면, 녹취록 전체가 컨텍스트를 **두 번** 흐릅니다. 읽어 들일 때와 대상에 쓸 때입니다. 2시간짜리 회의 녹취록은 50,000 토큰 이상을 추가로 차지할 수 있습니다.

```mermaid
graph LR
    A["Model"] -->|"Tool Call: getDocument"| B["MCP Server"]
    B -->|"Full transcript (50K tokens)"| A
    A -->|"Tool Call: updateRecord<br/>(re-sends full transcript)"| B
    B -->|"Confirmation"| A

    style A fill:#ffcdd2,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
```

### 해결책: 코드 API로서의 MCP 도구

도구 정의와 결과를 컨텍스트 윈도우에 통과시키는 대신, 에이전트가 MCP 도구를 API로 호출하는 **코드를 작성**합니다. 코드는 샌드박스 실행 환경에서 동작하며 최종 결과만 모델에 반환됩니다.

```mermaid
graph LR
    A["Model"] -->|"Writes code"| B["Code Execution<br/>Environment"]
    B -->|"Calls tools directly"| C["MCP Servers"]
    C -->|"Data stays in<br/>execution env"| B
    B -->|"Only final result<br/>(minimal tokens)"| A

    style A fill:#c8e6c9,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#f3e5f5,stroke:#333,color:#333
```

#### 동작 방식

MCP 도구는 타입이 지정된 함수의 파일 트리로 제시됩니다.

```
servers/
├── google-drive/
│   ├── getDocument.ts
│   └── index.ts
├── salesforce/
│   ├── updateRecord.ts
│   └── index.ts
└── ...
```

각 도구 파일에는 타입이 지정된 래퍼가 들어 있습니다.

```typescript
// ./servers/google-drive/getDocument.ts
import { callMCPTool } from "../../../client.js";

interface GetDocumentInput {
  documentId: string;
}

interface GetDocumentResponse {
  content: string;
}

export async function getDocument(
  input: GetDocumentInput
): Promise<GetDocumentResponse> {
  return callMCPTool<GetDocumentResponse>(
    'google_drive__get_document', input
  );
}
```

에이전트는 도구를 오케스트레이션하는 코드를 작성합니다.

```typescript
import * as gdrive from './servers/google-drive';
import * as salesforce from './servers/salesforce';

// 데이터는 도구 사이를 직접 흐릅니다 — 모델을 거치지 않습니다
const transcript = (
  await gdrive.getDocument({ documentId: 'abc123' })
).content;

await salesforce.updateRecord({
  objectType: 'SalesMeeting',
  recordId: '00Q5f000001abcXYZ',
  data: { Notes: transcript }
});
```

**결과: 토큰 사용량이 약 150,000에서 약 2,000으로 감소 — 98.7% 절감.**

### 주요 이점

| 이점 | 설명 |
|------|------|
| **점진적 공개** | 에이전트는 파일 시스템을 탐색해 필요한 도구 정의만 읽어 들이고, 모든 도구를 미리 읽어 들이지 않습니다 |
| **컨텍스트 효율적인 결과** | 데이터는 실행 환경 안에서 필터링/변환된 뒤 모델에 반환됩니다 |
| **강력한 제어 흐름** | 반복문, 조건 분기, 오류 처리가 모델과의 왕복 없이 코드 안에서 동작합니다 |
| **프라이버시 보호** | 중간 데이터(PII, 기밀 레코드)는 실행 환경 안에 머물며 모델 컨텍스트에 들어가지 않습니다 |
| **상태 영속화** | 에이전트는 중간 결과를 파일에 저장하고 재사용 가능한 스킬 함수를 구축할 수 있습니다 |

#### 예: 대규모 데이터셋 필터링

```typescript
// 코드 실행 없음 — 10,000행 전부가 컨텍스트를 흐름
// TOOL CALL: gdrive.getSheet(sheetId: 'abc123')
//   -> returns 10,000 rows in context

// 코드 실행 있음 — 실행 환경 안에서 필터링
const allRows = await gdrive.getSheet({ sheetId: 'abc123' });
const pendingOrders = allRows.filter(
  row => row["Status"] === 'pending'
);
console.log(`Found ${pendingOrders.length} pending orders`);
console.log(pendingOrders.slice(0, 5)); // 5행만 모델에 도달
```

#### 예: 왕복 없는 반복문

```typescript
// 배포 알림을 폴링 — 전부 코드 안에서 실행
let found = false;
while (!found) {
  const messages = await slack.getChannelHistory({
    channel: 'C123456'
  });
  found = messages.some(
    m => m.text.includes('deployment complete')
  );
  if (!found) await new Promise(r => setTimeout(r, 5000));
}
console.log('Deployment notification received');
```

### 고려해야 할 트레이드오프

코드 실행은 그 나름의 복잡성을 가져옵니다. 에이전트가 생성한 코드를 실행하려면 다음이 필요합니다.

- 적절한 리소스 상한을 가진 **안전한 샌드박스 실행 환경**
- 실행된 코드의 **모니터링과 로그 기록**
- 도구 직접 호출에 비해 추가되는 **인프라 오버헤드**

이점(토큰 비용 절감, 지연 시간 감소, 도구 구성 개선)은 이러한 구현 비용과 저울질해야 합니다. MCP 서버가 몇 개뿐인 에이전트라면 도구 직접 호출이 더 단순할 수 있습니다. 규모가 커지는 에이전트(수십 개의 서버, 수백 개의 도구)에게 코드 실행은 큰 개선입니다.

### MCPorter: MCP 도구 구성을 위한 런타임

[MCPorter](https://github.com/steipete/mcporter)는 MCP 서버 호출을 보일러플레이트 없이 실용적으로 만들어 주는 TypeScript 런타임 겸 CLI 툴킷입니다. 선택적인 도구 공개와 타입이 지정된 래퍼를 통해 컨텍스트 비대화를 억제하는 데도 도움이 됩니다.

**해결하는 것:** 모든 MCP 서버의 전체 도구 정의를 미리 읽어 들이는 대신, MCPorter는 특정 도구를 필요할 때 발견하고 검사하고 호출할 수 있게 합니다. 덕분에 컨텍스트를 가볍게 유지할 수 있습니다.

**주요 기능:**

| 기능 | 설명 |
|------|------|
| **설정 없는 발견** | Cursor, Claude, Codex, 로컬 설정에서 MCP 서버를 자동 발견 |
| **타입이 지정된 도구 클라이언트** | `mcporter emit-ts`가 `.d.ts` 인터페이스와 바로 동작하는 래퍼를 생성 |
| **구성 가능한 API** | `createServerProxy()`가 도구를 camelCase 메서드로 공개하고 `.text()`, `.json()`, `.markdown()` 헬퍼를 제공 |
| **CLI 생성** | `mcporter generate-cli`가 임의의 MCP 서버를 독립 실행형 CLI로 변환하며, `--include-tools` / `--exclude-tools`로 필터링 |
| **매개변수 숨김** | 선택적 매개변수는 기본적으로 숨겨져 스키마의 장황함을 줄임 |

**설치:**

```bash
npx mcporter list          # 설치 불필요 — 서버를 바로 발견
pnpm add mcporter          # 프로젝트에 추가
brew install steipete/tap/mcporter  # macOS의 Homebrew 사용
```

**예 — TypeScript로 도구 구성:**

```typescript
import { createRuntime, createServerProxy } from "mcporter";

const runtime = await createRuntime();
const gdrive = createServerProxy(runtime, "google-drive");
const salesforce = createServerProxy(runtime, "salesforce");

// 데이터는 모델 컨텍스트를 거치지 않고 도구 사이를 흐릅니다
const doc = await gdrive.getDocument({ documentId: "abc123" });
await salesforce.updateRecord({
  objectType: "SalesMeeting",
  recordId: "00Q5f000001abcXYZ",
  data: { Notes: doc.text() }
});
```

**예 — CLI 도구 호출:**

```bash
# 특정 도구를 직접 호출
npx mcporter call linear.create_comment issueId:ENG-123 body:'Looks good!'

# 사용 가능한 서버와 도구 목록
npx mcporter list
```

MCPorter는 앞서 설명한 코드 실행 접근 방식을 보완하며, MCP 도구를 타입이 지정된 API로 호출하기 위한 런타임 기반을 제공합니다. 중간 데이터를 모델 컨텍스트 밖에 두는 일을 쉽게 만들어 줍니다.

## 모범 사례

### 보안 고려 사항

#### 권장 ✅
- 모든 인증 정보에 환경 변수를 사용합니다
- 토큰과 API 키를 정기적으로 교체합니다 (매월 권장)
- 가능한 한 읽기 전용 토큰을 사용합니다
- MCP 서버의 접근 범위를 필요 최소한으로 제한합니다
- MCP 서버의 사용 현황과 접근 로그를 모니터링합니다
- 가능하다면 외부 서비스에 OAuth를 사용합니다
- MCP 요청에 속도 제한을 구현합니다
- 프로덕션 운영 전에 MCP 연결을 테스트합니다
- 운영 중인 MCP 연결을 모두 문서화합니다
- MCP 서버 패키지를 최신 상태로 유지합니다

#### 비권장 ❌
- 인증 정보를 설정 파일에 하드코딩하지 않습니다
- 토큰이나 비밀 정보를 git에 커밋하지 않습니다
- 팀 채팅이나 이메일로 토큰을 공유하지 않습니다
- 개인용 토큰을 팀 프로젝트에 사용하지 않습니다
- 불필요한 권한을 부여하지 않습니다
- 인증 오류를 무시하지 않습니다
- MCP 엔드포인트를 외부에 공개하지 않습니다
- MCP 서버를 root/admin 권한으로 실행하지 않습니다
- 민감한 데이터를 로그에 캐시하지 않습니다
- 인증 메커니즘을 비활성화하지 않습니다

### 설정 모범 사례

1. **버전 관리:** `.mcp.json`을 git에 저장하되, 비밀 정보에는 환경 변수를 사용합니다
2. **최소 권한:** 각 MCP 서버에 필요 최소한의 권한만 부여합니다
3. **격리:** 가능하면 서로 다른 MCP 서버를 별도 프로세스로 실행합니다
4. **모니터링:** 감사 추적을 위해 모든 MCP 요청과 오류를 기록합니다
5. **테스트:** 프로덕션 배포 전에 모든 MCP 설정을 테스트합니다

### 성능 팁

- 자주 접근하는 데이터는 애플리케이션 수준에서 캐시합니다
- 데이터 전송량을 줄이기 위해 구체적인 MCP 쿼리를 사용합니다
- MCP 작업의 응답 시간을 모니터링합니다
- 외부 API에는 속도 제한을 검토합니다
- 여러 작업을 실행할 때는 배치 처리를 사용합니다

## 설치 절차

### 사전 요구 사항
- Node.js와 npm 설치됨
- Claude Code CLI 설치됨
- 외부 서비스용 API 토큰/인증 정보

### 단계별 설정

1. **첫 MCP 서버 추가** (예: GitHub):
```bash
claude mcp add --transport http github https://api.githubcopilot.com/mcp/ --header "Authorization: Bearer YOUR_GITHUB_PAT"
```

   또는 프로젝트 루트에 `.mcp.json` 파일 만들기:
```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/",
      "headers": {
        "Authorization": "Bearer ${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }
}
```

2. **환경 변수 설정:**
```bash
export GITHUB_PERSONAL_ACCESS_TOKEN="your_github_personal_access_token"
```

3. **연결 테스트:**
```bash
claude /mcp
```

4. **MCP 도구 사용:**
```bash
/mcp__github__list_prs
/mcp__github__create_issue "Title" "Description"
```

### 특정 서비스 설치

**GitHub MCP:**
```bash
npm install -g @modelcontextprotocol/server-github
```

**Database MCP:**
```bash
npm install -g @bytebase/dbhub
```

**Filesystem MCP:**
```bash
npm install -g @modelcontextprotocol/server-filesystem
```

**Slack MCP (사용 중단된 패키지):**
```bash
npm install -g @modelcontextprotocol/server-slack
```

## 문제 해결

### MCP 서버를 찾을 수 없음
```bash
# MCP 서버가 설치되어 있는지 확인
npm list -g @modelcontextprotocol/server-github

# 설치되어 있지 않으면 설치
npm install -g @modelcontextprotocol/server-github
```

### 인증 실패
```bash
# 환경 변수가 설정되어 있는지 확인
echo $GITHUB_PERSONAL_ACCESS_TOKEN

# 필요하면 다시 설정
export GITHUB_PERSONAL_ACCESS_TOKEN="your_token"

# 토큰이 올바른 권한을 가졌는지 확인
# GitHub 토큰 범위는 https://github.com/settings/tokens 에서 확인
```

### 연결 시간 초과
- 네트워크 연결 확인: `ping api.github.com`
- API 엔드포인트에 도달할 수 있는지 확인
- API 속도 제한 확인
- 설정에서 시간 제한을 늘려 보기
- 방화벽이나 프록시 문제 확인

### MCP 서버가 크래시함
- MCP 서버 로그 확인: `~/.claude/logs/`
- 모든 환경 변수가 설정되어 있는지 확인
- 적절한 파일 권한 확인
- MCP 서버 패키지 재설치 시도
- 같은 포트에서 충돌하는 프로세스가 없는지 확인

## 관련 개념

### 메모리와 MCP
- **메모리:** 영속적이고 변하지 않는 데이터를 저장 (설정, 컨텍스트, 이력)
- **MCP:** 변화하는 라이브 데이터에 접근 (API, 데이터베이스, 실시간 서비스)

### 어느 것을 사용할까
- **메모리를 사용하는 경우:** 사용자 설정, 대화 이력, 학습한 컨텍스트
- **MCP를 사용하는 경우:** 현재의 GitHub 이슈, 라이브 데이터베이스 쿼리, 실시간 데이터

### 다른 Claude 기능과의 통합
- 메모리와 MCP를 조합해 풍부한 컨텍스트를 구축
- 프롬프트 안에서 MCP 도구를 사용해 더 나은 추론을 실현
- 복잡한 워크플로에는 여러 MCP를 활용

## 추가 자료

- [Official MCP Documentation](https://code.claude.com/docs/en/mcp)
- [MCP Protocol Specification](https://modelcontextprotocol.io/specification)
- [MCP GitHub Repository](https://github.com/modelcontextprotocol/servers)
- [Available MCP Servers](https://github.com/modelcontextprotocol/servers)
- [MCPorter](https://github.com/steipete/mcporter) — 보일러플레이트 없이 MCP 서버를 호출하기 위한 TypeScript 런타임 겸 CLI
- [Code Execution with MCP](https://www.anthropic.com/engineering/code-execution-with-mcp) — 컨텍스트 비대화 해결에 관한 Anthropic 엔지니어링 블로그
- [Claude Code CLI Reference](https://code.claude.com/docs/en/cli-reference)
- [Claude API Documentation](https://docs.anthropic.com)

---

**최종 업데이트:** 2026년 10월 18일
**Claude Code 버전:** 2.1.302
**정보 출처:**
- https://code.claude.com/docs/en/mcp
- https://code.claude.com/docs/en/mcp#configure-tool-search
- https://code.claude.com/docs/en/managed-mcp
- https://code.claude.com/docs/en/changelog
- https://github.com/anthropics/claude-code/releases/tag/v2.1.117
- https://github.com/anthropics/claude-code/releases/tag/v2.1.285
- https://github.com/anthropics/claude-code/releases/tag/v2.1.296
- https://code.claude.com/docs/en/mcp#tool-search-for-mcp-server-authors
- https://code.claude.com/docs/en/mcp#environment-variable-expansion-in-mcp-json
- https://code.claude.com/docs/en/sub-agents
**지원 모델:** Claude Sonnet 4.6, Claude Opus 4.7, Claude Haiku 4.5
