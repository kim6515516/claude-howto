<!-- i18n-source: 06-hooks/README.md -->
<!-- i18n-source-sha: 8e2b745 -->
<!-- i18n-date: 2026-10-26 -->

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../../resources/logos/claude-howto-logo.svg">
</picture>

# 훅

훅은 Claude Code 세션 중 특정 이벤트에 반응해 실행되는 자동화 스크립트입니다. 자동화, 검증, 권한 관리, 사용자 지정 워크플로를 가능하게 합니다.

## 개요

훅은 Claude Code 안에서 특정 이벤트가 발생했을 때 자동으로 실행되는 자동화 동작(셸 명령, HTTP 웹훅, LLM 프롬프트, MCP 도구 호출, 서브에이전트 평가)입니다. 훅은 JSON 입력을 받고, 종료 코드와 JSON 출력으로 결과를 전달합니다.

**주요 기능:**
- 이벤트 기반 자동화
- JSON 기반 입출력
- `command`, `http`, `mcp_tool`, `prompt`, `agent` 훅 타입 지원
- 도구별 훅을 위한 패턴 매칭

## 설정

훅은 설정 파일 안에 정해진 구조로 작성합니다.

- `~/.claude/settings.json` - 사용자 설정(모든 프로젝트)
- `.claude/settings.json` - 프로젝트 설정(공유 가능, 커밋 대상)
- `.claude/settings.local.json` - 로컬 프로젝트 설정(커밋하지 않음)
- 관리 정책 - 조직 전체 설정
- 플러그인의 `hooks/hooks.json` - 플러그인 범위의 훅
- 스킬/에이전트의 프런트매터 - 컴포넌트 수명 주기 훅

### 기본 설정 구조

```json
{
  "hooks": {
    "EventName": [
      {
        "matcher": "ToolPattern",
        "hooks": [
          {
            "type": "command",
            "command": "your-command-here",
            "timeout": 60
          }
        ]
      }
    ]
  }
}
```

**주요 필드:**

| 필드 | 설명 | 예 |
|-----------|------|-----|
| `matcher` | 도구 이름에 매칭되는 패턴(대소문자 구분) | `"Write"`, `"Edit\|Write"`, `"*"` |
| `hooks` | 훅 정의 배열 | `[{ "type": "command", ... }]` |
| `type` | 훅 타입: `"command"`(bash), `"prompt"`(LLM), `"http"`(웹훅), `"mcp_tool"`(MCP 도구 호출, v2.1.118 이상), `"agent"`(서브에이전트) | `"command"` |
| `command` | 실행할 셸 명령 | `"$CLAUDE_PROJECT_DIR/.claude/hooks/format.sh"` |
| `timeout` | 선택적 타임아웃(초). 기본값은 command/http/mcp_tool이 600, prompt가 30, agent가 60. | `30` |
| `once` | `true`이면 처음 성공한 실행 뒤에 훅이 제거됩니다(실패·차단·타임아웃된 실행에서는 남습니다). 스킬 프런트매터에서만 유효하며, settings나 에이전트 프런트매터에서는 무시됩니다 | `true` |
| `async` | `true`이면 차단하지 않고 백그라운드에서 실행 | `true` |
| `asyncRewake` | `true`이면 백그라운드에서 실행하고, 종료 코드 2로 Claude를 깨웁니다. `async`를 포함합니다. | `true` |
| `shell` | `"bash"` 또는 `"powershell"`을 받습니다. 기본값은 `"bash"`, Git Bash가 설치되지 않은 Windows에서는 `"powershell"`. | `"bash"` |
| `statusMessage` | 훅 실행 중에 표시되는 사용자 지정 스피너 메시지 | `"포맷 중…"` |

> **참고**: 일부 이벤트는 기본 타임아웃을 낮춥니다. `UserPromptSubmit`은 command/http/mcp_tool의 기본값을 30초로, `MessageDisplay`는 10초로 낮춥니다. `SessionEnd` 훅은 1.5초의 예산을 공유하며, 설정에서 더 긴 `timeout`을 지정하면 Claude Code가 최대 60초까지 예산을 늘립니다.

### 매처 패턴

| 패턴 | 설명 | 예 |
|---------|------|-----|
| 정확히 일치하는 문자열 | 특정 도구에 매칭 | `"Write"` |
| 정규 표현식 | 여러 도구에 매칭 | `"Edit\|Write"` |
| 와일드카드 | 모든 도구에 매칭 | `"*"` 또는 `""` |
| MCP 도구 | 서버와 도구 패턴 | `"mcp__memory__.*"` |

**InstructionsLoaded의 매처 값:**

| 매처 값 | 설명 |
|-------------|------|
| `session_start` | 세션 시작 시 읽어 들이는 지침 |
| `nested_traversal` | 중첩 디렉터리 순회 중에 읽어 들이는 지침 |
| `path_glob_match` | 경로 glob 패턴 매칭으로 읽어 들이는 지침 |

## 훅 타입

Claude Code는 5가지 훅 타입을 지원합니다.

### Command 훅

기본 훅 타입입니다. 셸 명령을 실행하고, JSON 표준 입출력과 종료 코드로 통신합니다.

```json
{
  "type": "command",
  "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate.py\"",
  "timeout": 60
}
```

### HTTP 훅

> v2.1.63에서 추가.

원격 웹훅 엔드포인트가 command 훅과 같은 JSON 입력을 받습니다. HTTP 훅은 URL에 JSON을 POST하고 JSON 응답을 받습니다. 샌드박스가 활성화된 경우 HTTP 훅은 샌드박스를 거쳐 라우팅됩니다. 헤더 값에 환경 변수를 확장하려면 보안을 위해 명시적인 `allowedEnvVars` 목록이 필요합니다.

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write",
      "hooks": [{
        "type": "http",
        "url": "https://my-webhook.example.com/hook"
      }]
    }]
  }
}
```

**주요 속성:**
- `"type": "http"` -- HTTP 훅임을 나타냅니다
- `"url"` -- 웹훅 엔드포인트 URL
- 샌드박스가 활성화되어 있으면 샌드박스를 거쳐 라우팅
- `headers` 값에 환경 변수를 확장하려면 명시적인 `allowedEnvVars` 목록이 필요

### Prompt 훅

LLM이 평가하는 프롬프트로, 훅 내용이 Claude가 평가하는 프롬프트가 됩니다. 주로 `Stop`과 `SubagentStop` 이벤트에서 지능적인 작업 완료 확인에 사용됩니다.

```json
{
  "type": "prompt",
  "prompt": "Evaluate if Claude completed all requested tasks.",
  "timeout": 30
}
```

LLM은 프롬프트를 평가하고 구조화된 판정을 반환합니다(자세한 내용은 [Prompt 기반 훅](#prompt-기반-훅) 참고).

### MCP Tool 훅

> v2.1.118에서 추가.

`mcp_tool` 타입은 설정된 MCP 도구를 직접 호출합니다. 설정은 셸 명령이나 URL이 아니라 MCP 서버와 도구 이름을 참조합니다. 검증이나 반응 로직이 이미 설정된 MCP 서버 쪽에 있을 때 유용합니다.

```json
{
  "matcher": "Edit",
  "hooks": [{
    "type": "mcp_tool",
    "server": "my-mcp-server",
    "tool": "validate_edit",
    "input": { "file_path": "${tool_input.file_path}" }
  }]
}
```

**주요 속성:**
- `"type": "mcp_tool"` -- MCP 도구 훅임을 나타냅니다
- `"server"` -- 설정된 MCP 서버의 이름
- `"tool"` -- 그 서버에서 호출할 도구 이름
- `"input"` -- 도구에 넘길 선택적 인자. 문자열 값에서는 훅의 JSON 입력에서 가져오는 `${path}` 치환을 쓸 수 있습니다(예: `"${tool_input.file_path}"`)

도구 인자는 `input`(`${path}` 치환 포함)에서 만들어지며, 훅 입력이 그대로 전달되는 것은 아닙니다. MCP 서버 설정 방법은 [MCP 서버 설정](../05-mcp/README.md)을 참고하세요.

### Agent 훅

서브에이전트 기반 검증 훅으로, 전용 에이전트를 생성해 조건 평가나 복잡한 확인을 수행합니다. prompt 훅(단발 LLM 평가)과 달리 agent 훅은 도구를 사용해 여러 단계의 추론을 할 수 있습니다.

```json
{
  "type": "agent",
  "prompt": "Verify the code changes follow our architecture guidelines. Check the relevant design docs and compare.",
  "timeout": 120
}
```

> **참고**: Agent 훅은 실험적 기능이며 변경될 수 있습니다.

> **참고**: v2.1.280부터 agent 훅은 `PermissionRequest`에서는 실행되지 않습니다. 그 응답으로는 요청을 허용할 수도 거부할 수도 없기 때문입니다. `PermissionRequest`에는 판정 객체를 반환하는 command 훅이나 HTTP 훅을 사용하세요(prompt 훅의 `ok: false`는 `PermissionRequest`에서 효과가 없습니다).

**주요 속성:**
- `"type": "agent"` -- agent 훅임을 나타냅니다
- `"prompt"` -- 서브에이전트에 주는 작업 설명
- 에이전트는 도구(Read, Grep, Bash 등)를 사용해 평가할 수 있습니다
- prompt 훅과 마찬가지로 구조화된 판정을 반환합니다

## 훅 이벤트

Claude Code는 **33가지 훅 이벤트**를 지원합니다.

| 이벤트 | 발생 시점 | 매처 입력 | 차단 가능 여부 | 용도 예 |
|----------|---------------|---------------|-------------|--------|
| **SessionStart** | 세션 시작/재개/clear/compact/fork | startup/resume/clear/compact/fork | 불가 | 환경 설정 |
| **Setup** | `--init-only`, 또는 `-p`와 함께 쓴 `--init`/`--maintenance`(CI/스크립트 준비) | `init`/`maintenance` | 불가 | 도구 프로비저닝, 의존성 설치 |
| **InstructionsLoaded** | CLAUDE.md나 규칙 파일이 읽힌 뒤 | 읽기 이유(`session_start`/`nested_traversal`/`path_glob_match`/`include`/`compact`) | 불가 | 감사·가시성을 위한 로깅 |
| **UserPromptSubmit** | 사용자가 프롬프트를 전송 | (없음) | 가능 | 프롬프트 검증 |
| **UserPromptExpansion** | 사용자가 입력한 슬래시 명령어나 MCP 프롬프트가 프롬프트로 확장됨 | 명령어 이름 | 가능 | 확장된 프롬프트를 변환/검사 |
| **MessageDisplay** | 어시스턴트의 메시지 본문이 표시될 때 | (없음) | 불가 | 표시 텍스트 변환·숨김(v2.1.152) |
| **PreToolUse** | 도구 실행 전 | 도구 이름 | 가능(allow/deny/ask) | 입력 검증·수정 |
| **PermissionRequest** | 권한 대화 상자 표시 | 도구 이름 | 가능 | 자동 승인/거부 |
| **PermissionDenied** | auto 모드가 도구 호출을 거부 | 도구 이름 | 불가 | 로깅, 분석, 정책 강제 |
| **PostToolUse** | 도구 성공 후 | 도구 이름 | 불가 | 컨텍스트 추가, 피드백 |
| **PostToolUseFailure** | 도구 실행 실패 시 | 도구 이름 | 불가 | 에러 처리, 로깅 |
| **PostToolBatch** | 도구 배치 완료 후 | (없음) | 가능 | 집계 보고, 배치 검증 |
| **Notification** | 알림 전송 시 | 알림 타입 | 불가 | 사용자 지정 알림 |
| **SubagentStart** | 서브에이전트 생성 | 에이전트 타입 이름 | 불가 | 서브에이전트 설정 |
| **SubagentStop** | 서브에이전트 완료 | 에이전트 타입 이름 | 가능 | 서브에이전트 검증 |
| **Stop** | Claude가 응답을 마쳤을 때 | (없음) | 가능 | 작업 완료 확인 |
| **StopFailure** | API 에러로 턴 종료 | 에러 종류(`rate_limit`, `overloaded`, `server_error` 등) | 불가 | 에러 복구, 로깅 |
| **TeammateIdle** | 에이전트 팀의 팀원이 유휴 상태 | (없음) | 가능 | 팀원 연계 |
| **TaskCompleted** | 작업 완료 표시 | (없음) | 가능 | 작업 후 처리 |
| **TaskCreated** | TaskCreate로 작업 생성 | (없음) | 가능 | 작업 추적, 로깅 |
| **ConfigChange** | 설정 파일 변경 | 설정 소스(`user_settings`/`project_settings`/`local_settings`/`policy_settings`/`skills`) | 가능(정책 제외) | 설정 변경에 반응 |
| **CwdChanged** | 작업 디렉터리 변경 | (없음) | 불가 | 디렉터리별 설정 |
| **DirectoryAdded** | `/add-dir` 또는 SDK의 `register_repo_root` 컨트롤 요청으로 세션 중에 새 작업 디렉터리가 등록되었을 때(v2.1.219) | `slash_command`/`register_repo_root` | 불가 | 추가된 디렉터리용 도구 설정 |
| **FileChanged** | 감시 파일 변경 | 감시할 파일 이름(예: `.envrc\|.env`) | 불가 | 파일 감시, 재빌드 |
| **PreCompact** | 컨텍스트 압축 전 | manual/auto | 가능 | 압축 전 처리 |
| **PostCompact** | 압축 완료 후 | (없음) | 불가 | 압축 후 처리 |
| **PreModelSwitch** | 요청된 모델 전환을 Claude Code가 적용하기 전 | 전환 대상 모델의 정식 이름(`to_model`에서 도출) | 가능 | 모델 변경 제어·거부 |
| **PostModelSwitch** | 세션의 모델이 변경된 후(재개 시 모델 복원 등 Claude Code 스스로 바꾼 경우 포함) | 전환 대상 모델의 정식 이름(`to_model`에서 도출) | 불가 | 모델 변경 로깅·후속 처리 |
| **WorktreeCreate** | 워크트리 생성 중 | (없음) | 가능(경로 반환) | 워크트리 초기화 |
| **WorktreeRemove** | 워크트리 삭제 중 | (없음) | 가능(0이 아닌 종료로 삭제 실패) | 워크트리 정리 |
| **Elicitation** | MCP 서버가 사용자 입력을 요청 | MCP 서버 이름 | 가능 | 입력 검증 |
| **ElicitationResult** | 사용자가 elicitation에 응답 | MCP 서버 이름 | 가능 | 응답 처리 |
| **SessionEnd** | 세션 종료 | 종료 이유(`clear`/`resume`/`logout`/`prompt_input_exit`/`other`) | 불가 | 정리, 최종 로깅 |

> **`TaskCreated`와 `TaskCompleted`는 todo 도구가 활성화된 경우에만 발생합니다(v2.1.233).** 이 이벤트들은 todo/작업 추적 도구(`TaskCreate`/`Get`/`Update`/`List`, `TodoWrite`)에서 발생하는데, 이 도구들은 **Claude 3.x 모델, Opus 4~4.7, Sonnet 4~4.6, Haiku 4.5에서만 기본으로 사용할 수 있습니다**. 그 밖의 모델에서는 훅 설정 자체는 유효한 채로 단지 발생하지 않습니다 — 출력도 에러도 없습니다. `CLAUDE_CODE_ENABLE_TODO_TOOLS=1`을 설정하면 다시 동작합니다.

> **PostToolUse의 duration(v2.1.119):** `PostToolUse`와 `PostToolUseFailure`의 훅 입력에 `duration_ms`가 포함되게 되었습니다. 자세한 내용은 [PostToolUse](#posttooluse) 섹션을 참고하세요.

### PreToolUse

Claude가 도구 파라미터를 생성한 뒤, 처리를 시작하기 전에 동작합니다. 도구 입력의 검증·수정에 사용합니다.

**설정:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/validate-bash.py"
          }
        ]
      }
    ]
  }
}
```

**일반적인 매처:** `Agent`, `Bash`, `Glob`, `Grep`, `Read`, `Edit`, `Write`, `WebFetch`, `WebSearch`

**출력 제어:**
- `permissionDecision`: `"allow"`, `"deny"`, `"ask"`, `"defer"`
  - `"allow"`는 권한 프롬프트를 건너뜁니다(사용자 조작이 필수인 도구와 조직이 `ask`로 설정한 커넥터 도구는 제외)
  - `"deny"`는 도구 호출을 막습니다
  - `"ask"`는 사용자에게 확인을 요청합니다
  - `"defer"`는 정상 종료해 나중에 도구를 재개할 수 있게 합니다. 이 값에서는 `permissionDecisionReason`, `updatedInput`, `additionalContext`가 모두 무시됩니다
  - 훅이 무엇을 반환하든 deny/ask 규칙은 계속 평가됩니다. 여러 `PreToolUse` 훅의 판정이 엇갈리면 우선순위는 `deny` > `defer` > `ask` > `allow`입니다
- `permissionDecisionReason`: 판정 이유. `"ask"`에서는 (Claude가 아니라) 사용자에게 표시되고, `"deny"`에서는 Claude에게 표시됩니다. `"allow"`와 `"defer"`에서는 디버그 로그에만 기록됩니다
- `updatedInput`: 대체용 도구 입력(입력 객체 전체를 대체). v2.1.300부터는 Claude 자신의 입력과 마찬가지로 검증되어, 알 수 없는 키는 버려지고 도구가 거부하는 입력이면 호출이 거부됩니다.

### PostToolUse

도구 완료 직후에 동작합니다. 검증, 로깅, Claude에게 컨텍스트 반환에 사용합니다.

**설정:**
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/security-scan.py"
          }
        ]
      }
    ]
  }
}
```

**출력 제어:**
- `"block"` 판정으로 Claude에게 피드백을 촉구
- `additionalContext`: Claude에게 추가되는 컨텍스트

**추가 입력 필드(v2.1.119):**

| 필드 | 타입 | 설명 |
|-----------|----|------|
| `duration_ms` | number | 도구 실행 시간(밀리초). 권한 프롬프트와 PreToolUse 훅 실행 시간은 제외. `PostToolUse`와 `PostToolUseFailure` 두 훅 모두에서 사용 가능. |

### UserPromptSubmit

사용자가 프롬프트를 전송하고 Claude가 처리를 시작하기 전에 동작합니다. v2.1.299부터는 스킬이나 사용자 지정 명령어가 확장되기 전에 실행되므로, 프롬프트를 차단하면 그 명령어의 `!` 셸 줄도 멈춥니다. `UserPromptExpansion`은 그 뒤에 발생합니다.

**설정:**
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/validate-prompt.py"
          }
        ]
      }
    ]
  }
}
```

**출력 제어:**
- `decision`: `"block"`으로 처리를 막음
- `reason`: 차단된 이유
- `additionalContext`: 프롬프트에 추가되는 컨텍스트

### Stop과 SubagentStop

Claude가 응답을 마쳤을 때(Stop), 서브에이전트가 완료되었을 때(SubagentStop) 동작합니다. 지능적인 작업 완료 확인을 위해 prompt 기반 평가를 지원합니다.

**추가 입력 필드:** `Stop`과 `SubagentStop` 두 훅은 JSON 입력에 `last_assistant_message` 필드를 받습니다. 여기에는 중지 전 Claude 또는 서브에이전트의 마지막 메시지가 들어 있어 작업 완료 평가에 유용합니다.

**설정:**
```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Evaluate if Claude completed all requested tasks.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### SubagentStart

서브에이전트가 실행을 시작했을 때 동작합니다. 매처 입력은 에이전트 타입 이름이며, 특정 서브에이전트 타입을 대상으로 지정할 수 있습니다.

**설정:**
```json
{
  "hooks": {
    "SubagentStart": [
      {
        "matcher": "code-review",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/subagent-init.sh"
          }
        ]
      }
    ]
  }
}
```

### SessionStart

세션 시작 또는 재개 시에 동작합니다. 환경 변수를 영속화할 수 있습니다.

**매처:** `startup`, `resume`, `clear`, `compact`, `fork`

> **v2.1.214 업데이트**: 포크된 세션은 이전의 `"resume"` 대신 `"fork"`를 소스로 보고하게 되었습니다.

**특별한 기능:** `CLAUDE_ENV_FILE`을 사용해 환경 변수를 영속화할 수 있습니다(`CwdChanged`와 `FileChanged` 훅에서도 사용 가능).

```bash
#!/bin/bash
if [ -n "$CLAUDE_ENV_FILE" ]; then
  echo 'export NODE_ENV=development' >> "$CLAUDE_ENV_FILE"
fi
exit 0
```

### SessionEnd

세션 종료 시에 정리나 최종 로깅을 실행합니다. 종료를 차단할 수는 없습니다.

**Reason 필드 값:**
- `clear` - 사용자가 세션을 초기화
- `logout` - 사용자가 로그아웃
- `prompt_input_exit` - 사용자가 프롬프트 입력에서 종료
- `other` - 그 밖의 이유

**설정:**
```json
{
  "hooks": {
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR/.claude/hooks/session-cleanup.sh\""
          }
        ]
      }
    ]
  }
}
```

### Notification 이벤트

알림 이벤트의 갱신된 매처:
- `permission_prompt` - 권한 요청 알림
- `idle_prompt` - 유휴 상태 알림
- `auth_success` - 인증 성공
- `elicitation_dialog` - 사용자에게 표시되는 대화 상자

## 컴포넌트 범위의 훅

훅은 특정 컴포넌트(스킬, 에이전트, 명령어)의 프런트매터에 붙일 수 있습니다.

**SKILL.md, agent.md, command.md 안에서:**

```yaml
---
name: secure-operations
description: Perform operations with security checks
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/check.sh"
          once: true  # 스킬 프런트매터에서만: 첫 성공 실행 후 제거
---
```

**지원되는 이벤트:** 모든 훅 이벤트. 서브에이전트의 훅은 그 서브에이전트가 활성 상태인 동안에만 실행됩니다(`Stop` → `SubagentStop`). 스킬의 훅은 스킬 호출 시 등록되어 세션 종료까지 유효하게 남습니다.

이렇게 하면 훅을 사용하는 컴포넌트 안에 직접 정의할 수 있어 관련 코드를 가까이에 모아 둘 수 있습니다.

### 서브에이전트 프런트매터 안의 훅

서브에이전트의 프런트매터에 `Stop` 훅을 정의하면, 자동으로 그 서브에이전트에 범위가 한정된 `SubagentStop` 훅으로 변환됩니다. 이로써 메인 세션이 중지될 때가 아니라 해당 서브에이전트가 완료될 때에만 훅이 발생하는 것이 보장됩니다.

```yaml
---
name: code-review-agent
description: Automated code review subagent
hooks:
  Stop:
    - hooks:
        - type: prompt
          prompt: "Verify the code review is thorough and complete."
  # 위의 Stop 훅은 이 서브에이전트용 SubagentStop으로 자동 변환됩니다
---
```

## PermissionRequest 이벤트

사용자 지정 출력 형식으로 권한 요청을 처리합니다.

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PermissionRequest",
    "decision": {
      "behavior": "allow|deny",
      "updatedInput": {},
      "message": "Custom message",
      "interrupt": false
    }
  }
}
```

## 훅의 입출력

### JSON 입력(stdin 경유)

모든 훅은 stdin을 통해 JSON 입력을 받습니다.

```json
{
  "session_id": "abc123",
  "transcript_path": "/path/to/transcript.jsonl",
  "cwd": "/current/working/directory",
  "permission_mode": "default",
  "hook_event_name": "PreToolUse",
  "tool_name": "Write",
  "tool_input": {
    "file_path": "/path/to/file.js",
    "content": "..."
  },
  "tool_use_id": "toolu_01ABC123...",
  "agent_id": "agent-abc123",
  "agent_type": "security-reviewer",
  "worktree": "/path/to/worktree"
}
```

**공통 필드:**

| 필드 | 설명 |
|-----------|------|
| `session_id` | 세션의 고유 식별자 |
| `transcript_path` | 대화 트랜스크립트 파일의 경로 |
| `cwd` | 현재 작업 디렉터리 |
| `hook_event_name` | 훅을 발생시킨 이벤트 이름 |
| `agent_id` | 이 훅을 실행 중인 에이전트의 식별자 |
| `agent_type` | 에이전트 이름(예: `"Explore"`, `"security-reviewer"`). 세션이 `--agent`를 사용하거나 훅이 서브에이전트 안에서 발생한 경우에만 존재합니다 |
| `worktree` | 에이전트가 git 워크트리에서 동작 중인 경우 그 경로 |

### 종료 코드

| 종료 코드 | 의미 | 동작 |
|-----------|------|------|
| **0** | 성공 | 계속 진행, JSON stdout을 파싱 |
| **2** | 차단 에러 | 작업을 차단, stderr를 에러로 표시 |
| **그 외** | 비차단 에러 | 계속 진행. 트랜스크립트의 `<hook name> hook error` 알림에 stderr의 첫 줄이 표시됩니다 |

### JSON 출력(stdout, 종료 코드 0)

```json
{
  "continue": true,
  "stopReason": "Optional message if stopping",
  "suppressOutput": false,
  "systemMessage": "Optional warning message",
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "permissionDecisionReason": "File is in allowed directory",
    "updatedInput": {
      "file_path": "/modified/path.js"
    }
  }
}
```

## 환경 변수

| 변수 | 사용 가능한 훅 | 설명 |
|------|-----------------|------|
| `CLAUDE_PROJECT_DIR` | 모든 훅 | 프로젝트 루트의 절대 경로 |
| `CLAUDE_ENV_FILE` | SessionStart, CwdChanged, FileChanged | 환경 변수를 영속화할 파일 경로 |
| `CLAUDE_CODE_REMOTE` | 모든 훅 | 원격 환경에서 동작 중이면 `"true"` |
| `${CLAUDE_PLUGIN_ROOT}` | 플러그인 훅 | 플러그인 디렉터리의 경로 |
| `${CLAUDE_PLUGIN_DATA}` | 플러그인 훅 | 플러그인 데이터 디렉터리의 경로 |
| `CLAUDE_CODE_SESSIONEND_HOOKS_TIMEOUT_MS` | SessionEnd 훅 | SessionEnd 훅용 밀리초 단위 타임아웃 설정(기본값을 덮어씀) |

## Prompt 기반 훅

`Stop`과 `SubagentStop` 이벤트에는 LLM 기반 평가를 사용할 수 있습니다.

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Review if all tasks are complete. Return your decision.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

**LLM 응답 스키마:**
```json
{
  "ok": false,
  "reason": "Tests were not run after the last edit"
}
```

`ok: true`이면 동작을 허용합니다. `ok`가 `false`일 때는 `reason`이 필수입니다.

## 예제

### 예제 1: Bash 명령 검증기(PreToolUse)

**파일:** `.claude/hooks/validate-bash.py`

```python
#!/usr/bin/env python3
import json
import sys
import re

BLOCKED_PATTERNS = [
    (r"\brm\s+-rf\s+/", "Blocking dangerous rm -rf / command"),
    (r"\bsudo\s+rm", "Blocking sudo rm command"),
]

def main():
    input_data = json.load(sys.stdin)

    tool_name = input_data.get("tool_name", "")
    if tool_name != "Bash":
        sys.exit(0)

    command = input_data.get("tool_input", {}).get("command", "")

    for pattern, message in BLOCKED_PATTERNS:
        if re.search(pattern, command):
            print(message, file=sys.stderr)
            sys.exit(2)  # 종료 코드 2 = 차단 에러

    sys.exit(0)

if __name__ == "__main__":
    main()
```

**설정:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate-bash.py\""
          }
        ]
      }
    ]
  }
}
```

### 예제 2: 보안 스캐너(PostToolUse)

**파일:** `.claude/hooks/security-scan.py`

```python
#!/usr/bin/env python3
import json
import sys
import re

SECRET_PATTERNS = [
    (r"password\s*=\s*['\"][^'\"]+['\"]", "Potential hardcoded password"),
    (r"api[_-]?key\s*=\s*['\"][^'\"]+['\"]", "Potential hardcoded API key"),
]

def main():
    input_data = json.load(sys.stdin)

    tool_name = input_data.get("tool_name", "")
    if tool_name not in ["Write", "Edit"]:
        sys.exit(0)

    tool_input = input_data.get("tool_input", {})
    content = tool_input.get("content", "") or tool_input.get("new_string", "")
    file_path = tool_input.get("file_path", "")

    warnings = []
    for pattern, message in SECRET_PATTERNS:
        if re.search(pattern, content, re.IGNORECASE):
            warnings.append(message)

    if warnings:
        output = {
            "hookSpecificOutput": {
                "hookEventName": "PostToolUse",
                "additionalContext": f"Security warnings for {file_path}: " + "; ".join(warnings)
            }
        }
        print(json.dumps(output))

    sys.exit(0)

if __name__ == "__main__":
    main()
```

### 예제 3: 코드 자동 포맷(PostToolUse)

**파일:** `.claude/hooks/format-code.sh`

```bash
#!/bin/bash

# stdin에서 JSON을 읽습니다
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_name', ''))")
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_input', {}).get('file_path', ''))")

if [ "$TOOL_NAME" != "Write" ] && [ "$TOOL_NAME" != "Edit" ]; then
    exit 0
fi

# 파일 확장자에 따라 포맷합니다
case "$FILE_PATH" in
    *.js|*.jsx|*.ts|*.tsx|*.json)
        command -v prettier &>/dev/null && prettier --write "$FILE_PATH" 2>/dev/null
        ;;
    *.py)
        command -v black &>/dev/null && black "$FILE_PATH" 2>/dev/null
        ;;
    *.go)
        command -v gofmt &>/dev/null && gofmt -w "$FILE_PATH" 2>/dev/null
        ;;
esac

exit 0
```

### 예제 4: 프롬프트 검증기(UserPromptSubmit)

**파일:** `.claude/hooks/validate-prompt.py`

```python
#!/usr/bin/env python3
import json
import sys
import re

BLOCKED_PATTERNS = [
    (r"delete\s+(all\s+)?database", "Dangerous: database deletion"),
    (r"rm\s+-rf\s+/", "Dangerous: root deletion"),
]

def main():
    input_data = json.load(sys.stdin)
    prompt = input_data.get("prompt", "")

    for pattern, message in BLOCKED_PATTERNS:
        if re.search(pattern, prompt, re.IGNORECASE):
            output = {
                "decision": "block",
                "reason": f"Blocked: {message}"
            }
            print(json.dumps(output))
            sys.exit(0)

    sys.exit(0)

if __name__ == "__main__":
    main()
```

### 예제 5: 지능적인 Stop 훅(Prompt 기반)

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Review if Claude completed all requested tasks. Check: 1) Were all files created/modified? 2) Were there unresolved errors? If incomplete, explain what's missing.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### 예제 6: 컨텍스트 사용량 트래커(훅 쌍)

`UserPromptSubmit`(메시지 전)과 `Stop`(응답 후) 훅을 조합해 요청별 토큰 소비량을 추적합니다.

**파일:** `.claude/hooks/context-tracker.py`

```python
#!/usr/bin/env python3
"""
Context Usage Tracker - Tracks token consumption per request.

Uses UserPromptSubmit as "pre-message" hook and Stop as "post-response" hook
to calculate the delta in token usage for each request.

Token Counting Methods:
1. Character estimation (default): ~4 chars per token, no dependencies
2. tiktoken (optional): More accurate (~90-95%), requires: pip install tiktoken
"""
import json
import os
import sys
import tempfile

# 설정
CONTEXT_LIMIT = 1000000  # Opus 5, Sonnet 5, Opus 4.8, Sonnet 4.6은 1M, Haiku 4.5는 200000(모델에 맞춰 조정)
USE_TIKTOKEN = False    # tiktoken이 설치되어 있으면 True로 바꿔 정확도 향상


def get_state_file(session_id: str) -> str:
    """메시지 전 토큰 수를 저장할 임시 파일 경로를 가져옵니다(세션별로 분리)."""
    return os.path.join(tempfile.gettempdir(), f"claude-context-{session_id}.json")


def count_tokens(text: str) -> int:
    """
    텍스트의 토큰 수를 셉니다.

    tiktoken을 사용할 수 있으면 p50k_base 인코딩을 사용하고(약 90~95% 정확도),
    그렇지 않으면 글자 수 기반 추정으로 대체합니다(약 80~90% 정확도).
    """
    if USE_TIKTOKEN:
        try:
            import tiktoken
            enc = tiktoken.get_encoding("p50k_base")
            return len(enc.encode(text))
        except ImportError:
            pass  # 추정으로 대체

    # 글자 기반 추정: 영어의 경우 약 4글자가 1토큰
    return len(text) // 4


def read_transcript(transcript_path: str) -> str:
    """트랜스크립트 파일에서 모든 내용을 읽어 연결합니다."""
    if not transcript_path or not os.path.exists(transcript_path):
        return ""

    content = []
    with open(transcript_path, "r") as f:
        for line in f:
            try:
                entry = json.loads(line.strip())
                # 다양한 메시지 형식에서 텍스트 내용을 추출
                if "message" in entry:
                    msg = entry["message"]
                    if isinstance(msg.get("content"), str):
                        content.append(msg["content"])
                    elif isinstance(msg.get("content"), list):
                        for block in msg["content"]:
                            if isinstance(block, dict) and block.get("type") == "text":
                                content.append(block.get("text", ""))
            except json.JSONDecodeError:
                continue

    return "\n".join(content)


def handle_user_prompt_submit(data: dict) -> None:
    """메시지 전 훅: 요청 전의 현재 토큰 수를 저장합니다."""
    session_id = data.get("session_id", "unknown")
    transcript_path = data.get("transcript_path", "")

    transcript_content = read_transcript(transcript_path)
    current_tokens = count_tokens(transcript_content)

    # 나중에 비교하기 위해 임시 파일에 저장
    state_file = get_state_file(session_id)
    with open(state_file, "w") as f:
        json.dump({"pre_tokens": current_tokens}, f)


def handle_stop(data: dict) -> None:
    """응답 후 훅: 토큰 차이를 계산해 보고합니다."""
    session_id = data.get("session_id", "unknown")
    transcript_path = data.get("transcript_path", "")

    transcript_content = read_transcript(transcript_path)
    current_tokens = count_tokens(transcript_content)

    # 메시지 전 카운트를 읽어 들임
    state_file = get_state_file(session_id)
    pre_tokens = 0
    if os.path.exists(state_file):
        try:
            with open(state_file, "r") as f:
                state = json.load(f)
                pre_tokens = state.get("pre_tokens", 0)
        except (json.JSONDecodeError, IOError):
            pass

    # 차이를 계산
    delta_tokens = current_tokens - pre_tokens
    remaining = CONTEXT_LIMIT - current_tokens
    percentage = (current_tokens / CONTEXT_LIMIT) * 100

    # 사용량을 보고
    method = "tiktoken" if USE_TIKTOKEN else "estimated"
    print(f"Context ({method}): ~{current_tokens:,} tokens ({percentage:.1f}% used, ~{remaining:,} remaining)", file=sys.stderr)
    if delta_tokens > 0:
        print(f"This request: ~{delta_tokens:,} tokens", file=sys.stderr)


def main():
    data = json.load(sys.stdin)
    event = data.get("hook_event_name", "")

    if event == "UserPromptSubmit":
        handle_user_prompt_submit(data)
    elif event == "Stop":
        handle_stop(data)

    sys.exit(0)


if __name__ == "__main__":
    main()
```

**설정:**
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/context-tracker.py\""
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/context-tracker.py\""
          }
        ]
      }
    ]
  }
}
```

**동작 방식:**
1. `UserPromptSubmit`이 프롬프트 처리 전에 발생해 현재 토큰 수를 저장
2. `Stop`이 Claude의 응답 후에 발생해 차이를 계산하고 사용량을 보고
3. 각 세션은 임시 파일 이름 안의 `session_id`로 분리

**토큰 카운트 방식:**

| 방식 | 정확도 | 의존성 | 속도 |
|------|------|------|------|
| 글자 수 추정 | 약 80~90% | 없음 | 1ms 미만 |
| tiktoken(p50k_base) | 약 90~95% | `pip install tiktoken` | 10ms 미만 |

> **참고:** Anthropic은 공식 오프라인 토크나이저를 공개하지 않았습니다. 두 방식 모두 근사치입니다. 트랜스크립트에는 사용자 프롬프트, Claude의 응답, 도구 출력이 포함됩니다. v2.1.300부터는 각 API 요청의 시스템 프롬프트, 도구, 파라미터도 기록됩니다.

### 예제 7: 자동 모드 권한 시드(1회성 설정 스크립트)

`~/.claude/settings.json`에 Claude Code의 자동 모드 기준선에 해당하는 안전한 권한 규칙(기본 37개, 모든 카테고리 플래그를 켜면 최대 63개)을 심어 주는 1회성 설정 스크립트입니다. 훅은 없고, 이후의 선택을 기억하지도 않습니다. 한 번 실행하면 되고, 다시 실행해도 안전합니다(기존 규칙은 건너뜁니다).

**파일:** `09-advanced-features/setup-auto-mode-permissions.py`

```bash
# 추가될 내용을 미리 보기
python3 09-advanced-features/setup-auto-mode-permissions.py --dry-run

# 적용
python3 09-advanced-features/setup-auto-mode-permissions.py
```

**추가되는 항목:**

| 카테고리 | 예 |
|----------|-----|
| 내장 도구 | `Read(*)`, `Grep(*)`, `Agent(*)`, `WebSearch(*)` |
| 선택적 편집(--include-edits) | `Edit(*)` |
| Git 읽기 | `Bash(git status:*)`, `Bash(git log:*)`, `Bash(git diff:*)` |
| Git 쓰기(로컬) | `Bash(git add:*)`, `Bash(git commit:*)`, `Bash(git checkout:*)` |
| 패키지 관리자 | `Bash(npm ci:*)`, `Bash(npm install:*)`, `Bash(pip install:*)`, `Bash(pip3 install:*)` |
| 빌드·테스트 | `Bash(make:*)`, `Bash(pytest:*)`, `Bash(go test:*)` |
| 일반 셸 | `Bash(ls:*)`, `Bash(cat:*)`, `Bash(find:*)` |
| GitHub CLI | `Bash(gh pr view:*)`, `Bash(gh pr create:*)`, `Bash(gh issue list:*)` |

**의도적으로 제외되는 항목**(이 스크립트에서는 추가되지 않음):
- `rm -rf`, `sudo`, force push, `git reset --hard`
- `DROP TABLE`, `kubectl delete`, `terraform destroy`
- `npm publish`, `curl | bash`, 프로덕션 배포

### 예제 8: 학습 진행 로거(SessionEnd)

각 Claude Code 세션이 끝날 때 어떤 모듈을 학습했는지 로그로 남깁니다. 진행 상황은
`~/.claude-howto-progress.json`에 저장됩니다. 이 파일은 저장소 밖에 있으므로 `git pull` 뒤에도
덮어써지지 않고 유지됩니다.

**왜 `Stop`이 아니라 `SessionEnd`를 사용하나요?**
`Stop`은 Claude의 *모든* 응답 뒤에 발생합니다. `SessionEnd`는 세션 종료 시에
1번만 발생합니다. 세션 종료 시의 일지 항목에는 바로 이것이 필요합니다.

**왜 대화형 프롬프트를 사용하지 않나요?**
훅은 제어 터미널 없이 실행되므로 `/dev/tty`를 쓸 수 없고, 훅에서 사용자에게 입력을 요청할 수 없습니다.
모듈(과 선택적인 메모)은 Claude Code를 시작할 때 환경 변수로 넘깁니다(예: `CLAUDE_HOWTO_MODULES=06,07 claude`).

**파일:** `06-hooks/session-end.sh`

```bash
#!/usr/bin/env bash
# SessionEnd hook: records the modules worked on, then appends a session record
# to ~/.claude-howto-progress.json for persistent learning progress tracking.

PROGRESS_FILE="$HOME/.claude-howto-progress.json"

# 가드: 이 저장소 안에서만 실행
if [[ "$CLAUDE_PROJECT_DIR" != *"claude-howto"* ]] && [[ "$PWD" != *"claude-howto"* ]]; then
  exit 0
fi

if [ ! -f "$PROGRESS_FILE" ]; then
  echo '{"sessions":[]}' > "$PROGRESS_FILE"
fi

DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M")

# Modules worked on, e.g. launch with: CLAUDE_HOWTO_MODULES=06,07 claude
# 01=Slash  02=Memory  03=Skills  04=Subagents  05=MCP
# 06=Hooks  07=Plugins 08=Checkpoints 09=Advanced 10=CLI
INPUT="${CLAUDE_HOWTO_MODULES:-}"

if [ -z "$INPUT" ] || [ "$INPUT" = "skip" ]; then
  exit 0
fi

MODULES_JSON=$(echo "$INPUT" | tr ',' '\n' | tr -d ' ' | while read -r m; do
  case "$m" in
    01) echo '"01-slash-commands"' ;;
    02) echo '"02-memory"' ;;
    03) echo '"03-skills"' ;;
    04) echo '"04-subagents"' ;;
    05) echo '"05-mcp"' ;;
    06) echo '"06-hooks"' ;;
    07) echo '"07-plugins"' ;;
    08) echo '"08-checkpoints"' ;;
    09) echo '"09-advanced-features"' ;;
    10) echo '"10-cli"' ;;
    *)  echo "\"$m\"" ;;
  esac
done | paste -sd ',' -)

# Optional notes, e.g. CLAUDE_HOWTO_NOTES="tried the pre-commit example"
NOTES="${CLAUDE_HOWTO_NOTES:-}"

# NOTES를 별도 인자로 넘겨 Python이 JSON 이스케이프를 처리하게 합니다.
# 이렇게 하면 메모에 따옴표나 백슬래시가 들어 있어도 JSON이 깨지지 않습니다.
python3 - "$PROGRESS_FILE" "$DATE" "$TIME" "$MODULES_JSON" "$NOTES" <<'PYEOF'
import sys, json

path, date, time_str, modules_raw, notes = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5]

new_session = {
    "date": date,
    "time": time_str,
    "modules": json.loads(f"[{modules_raw}]") if modules_raw else [],
    "notes": notes,
}

with open(path, 'r') as f:
    data = json.load(f)

data.setdefault('sessions', []).append(new_session)

with open(path, 'w') as f:
    json.dump(data, f, indent=2)
PYEOF

echo " Saved to $PROGRESS_FILE"
```

**설치** — `settings.json` 안의 경로가 해석되도록 스크립트를 프로젝트의 훅 디렉터리에 복사합니다:

```bash
mkdir -p .claude/hooks
cp 06-hooks/session-end.sh .claude/hooks/
chmod +x .claude/hooks/session-end.sh
```

**설정**(`.claude/settings.json` 안):

```json
{
  "hooks": {
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR/.claude/hooks/session-end.sh\"",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
```

SessionEnd 훅의 기본 예산은 1.5초입니다. 훅마다 `"timeout"`(초)을 설정하면 예산이 그에 맞춰 늘어납니다(최대 60초). 자체 `timeout`이 없는 훅은 1.5초에 취소됩니다.

**출력 — `~/.claude-howto-progress.json`:**

```json
{
  "sessions": [
    {
      "date": "2026-04-18",
      "time": "14:32",
      "modules": ["06-hooks", "07-plugins"],
      "notes": "Installed first hook, tried pre-commit example"
    }
  ]
}
```

**보여 주는 주요 패턴:**

| 패턴 | 왜 중요한가 |
|---------|-----------|
| `SessionEnd` 이벤트 | 종료 시 1번만 발생 — `Stop`처럼 매 응답 뒤에 발생하지 않음 |
| `INPUT="${CLAUDE_HOWTO_MODULES:-}"` | 훅에는 터미널이 없으므로(`/dev/tty`를 쓸 수 없음) 입력은 환경 변수로 받음 |
| `"timeout": 10` | SessionEnd 훅은 자체 `timeout`이 없으면 1.5초에 취소됨 |
| `$CLAUDE_PROJECT_DIR` | 이식 가능한 경로 — `/Users/yourname/...`을 절대 하드코딩하지 않음 |
| 첫머리의 가드 절 | 전역으로 설정된 경우 무관한 프로젝트에서 훅이 동작하는 것을 방지 |
| 저장소 밖에 저장 | `~/` 경로는 `git pull`로 데이터가 덮어써지지 않고 유지됨 |

**함께 쓰는 도구: 시각적 진행 트래커**

10개 모듈 전체를 다루는 체크박스 기반의 완전한 UI를 브라우저에서 열 수 있습니다.

```bash
open local-progress/index.html
```

진행 상황은 브라우저의 `localStorage`에 저장됩니다(저장소 안의 디스크에는 쓰지 않습니다).
**Export** 버튼으로 스냅샷을 JSON으로 저장하고, **Import**로 복원할 수 있습니다.

## 플러그인 훅

플러그인은 `hooks/hooks.json` 파일에 훅을 포함할 수 있습니다.

**파일:** `plugins/hooks/hooks.json`

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "\"${CLAUDE_PLUGIN_ROOT}\"/scripts/validate.sh"
          }
        ]
      }
    ]
  }
}
```

**플러그인 훅 안의 환경 변수:**
- `${CLAUDE_PLUGIN_ROOT}` - 플러그인 디렉터리의 경로
- `${CLAUDE_PLUGIN_DATA}` - 플러그인 데이터 디렉터리의 경로

이를 통해 플러그인이 사용자 지정 검증이나 자동화 훅을 포함할 수 있게 됩니다.

## MCP 도구 훅

MCP 도구는 `mcp__<server>__<tool>` 패턴을 따릅니다.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "mcp__memory__.*",
        "hooks": [
          {
            "type": "command",
            "command": "echo '{\"systemMessage\": \"Memory operation logged\"}'"
          }
        ]
      }
    ]
  }
}
```

## 보안 고려 사항

### 면책 조항

**자기 책임하에 사용하세요:** 훅은 임의의 셸 명령을 실행합니다. 다음에 대해서는 사용자가 단독으로 책임을 집니다.
- 설정한 명령
- 파일 접근/변경 권한
- 데이터 손실이나 시스템 장애 가능성
- 프로덕션 운영 전에 안전한 환경에서 훅을 테스트할 것

### 보안상 주의점

- **워크스페이스 신뢰가 필요:** `statusLine`과 `fileSuggestion`의 훅 출력 명령은 활성화 전에 워크스페이스 신뢰를 수락해야 합니다.
- **HTTP 훅과 환경 변수:** HTTP 훅은 헤더 값에서 환경 변수 보간을 사용하려면 명시적인 `allowedEnvVars` 목록이 필요합니다. 이로써 민감한 환경 변수가 원격 엔드포인트로 의도치 않게 유출되는 것을 막습니다.
- **관리 대상 설정의 계층:** `disableAllHooks` 설정은 관리 대상 설정의 계층을 따르게 되었습니다. 즉, 조직 수준 설정에서 훅 비활성화를 강제할 수 있고 개별 사용자가 덮어쓸 수 없습니다.
- **PowerShell 자동 승인(v2.1.119):** PowerShell 도구 명령은 권한 모드에서 Bash와 마찬가지로 자동 승인이 가능해졌습니다. Windows 사용자가 PowerShell 백엔드의 셸 도구로 Claude Code를 실행할 때의 동등성이 확보되었습니다.

### 모범 사례

| 권장 | 비권장 |
|------|-------|
| 모든 입력을 검증·정제 | 입력 데이터를 무조건 신뢰 |
| 셸 변수를 따옴표로 감싸기: `"$VAR"` | 따옴표 없이: `$VAR` |
| 경로 탐색(`..`)을 차단 | 임의의 경로를 허용 |
| `$CLAUDE_PROJECT_DIR`를 사용한 절대 경로 | 경로 하드코딩 |
| 민감한 파일(`.env`, `.git/`, 키)을 건너뛰기 | 모든 파일을 처리 |
| 먼저 훅을 단독으로 테스트 | 테스트하지 않은 훅을 배포 |
| HTTP 훅에는 명시적인 `allowedEnvVars`를 사용 | 웹훅에 모든 환경 변수를 노출 |

## 디버깅

### 디버그 모드 활성화

상세한 훅 로그를 얻기 위해 Claude를 디버그 플래그와 함께 실행합니다.

```bash
claude --debug
```

### Verbose 모드

Claude Code 안에서 `Ctrl+O`를 눌러 verbose 모드를 활성화하고 훅 실행 진행 상황을 확인합니다.

### 훅을 단독으로 테스트

```bash
# 샘플 JSON 입력으로 테스트
echo '{"tool_name": "Bash", "tool_input": {"command": "ls -la"}}' | python3 .claude/hooks/validate-bash.py

# 종료 코드 확인
echo $?
```

## 완전한 설정 예시

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate-bash.py\"",
            "timeout": 10
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR/.claude/hooks/format-code.sh\"",
            "timeout": 30
          },
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/security-scan.py\"",
            "timeout": 10
          }
        ]
      }
    ],
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate-prompt.py\""
          }
        ]
      }
    ],
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR/.claude/hooks/session-init.sh\""
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Verify all tasks are complete before stopping.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

## 훅 실행 세부 사항

| 항목 | 동작 |
|------|------|
| **타임아웃** | command/http/mcp_tool은 기본 600초(prompt는 30초, agent는 60초), 훅마다 설정 가능 |
| **병렬화** | 매칭된 훅은 모두 병렬 실행. v2.1.302부터 한 이벤트에서 동시에 실행되는 prompt/agent 훅은 최대 12개이며 나머지는 차례를 기다림 |
| **중복 제거** | 동일한 훅 명령은 중복이 제거됨 |
| **환경** | 현재 디렉터리에서 Claude Code의 환경으로 실행 |

## 문제 해결

### 훅이 실행되지 않음
- JSON 설정 문법이 올바른지 확인
- 매처 패턴이 도구 이름에 매칭되는지 확인
- 스크립트가 존재하고 실행 가능한지: `chmod +x script.sh`
- `claude --debug`로 훅 실행 로그 확인
- 훅이 (명령 인자가 아니라) stdin에서 JSON을 읽고 있는지 확인

### 훅이 예상 밖으로 차단함
- 샘플 JSON으로 훅을 테스트: `echo '{"tool_name": "Write", ...}' | ./hook.py`
- 종료 코드 확인: 허용은 0, 차단은 2
- stderr 출력 확인(종료 코드 2일 때 표시됨)

### JSON 파싱 에러
- 반드시 stdin에서 읽고 명령 인자를 사용하지 않음
- 적절한 JSON 파싱을 사용(문자열 조작이 아니라)
- 누락된 필드를 안전하게 처리

## 설치

### Step 1: 훅 디렉터리 생성
```bash
mkdir -p ~/.claude/hooks
```

### Step 2: 훅 예제 복사
```bash
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

### Step 3: 설정 파일에서 설정
`~/.claude/settings.json` 또는 `.claude/settings.json`을 위의 훅 설정으로 편집합니다.

## 관련 개념

- **[체크포인트와 되감기](../08-checkpoints/)** - 대화 상태의 저장과 복원
- **[슬래시 명령어](../01-slash-commands/)** - 사용자 지정 슬래시 명령어 만들기
- **[스킬](../03-skills/)** - 재사용 가능한 자율 기능
- **[서브에이전트](../04-subagents/)** - 위임 작업 실행
- **[플러그인](../07-plugins/)** - 확장 기능 번들 패키지
- **[고급 기능](../09-advanced-features/)** - 고급 Claude Code 기능 탐색

## 추가 자료

- **[Official Hooks Documentation](https://code.claude.com/docs/en/hooks)** - 완전한 훅 레퍼런스
- **[CLI Reference](https://code.claude.com/docs/en/cli-reference)** - 명령줄 인터페이스 문서
- **[메모리 가이드](../02-memory/)** - 영속 컨텍스트 설정

---

**최종 업데이트:** 2026년 10월 18일
**Claude Code 버전:** 2.1.302
**출처:**
- https://code.claude.com/docs/en/hooks
- https://code.claude.com/docs/en/plugins/manifest-reference#quoting-and-path-separators
- https://code.claude.com/docs/en/permissions
- https://code.claude.com/docs/en/tools-reference#task-tool-availability
- https://code.claude.com/docs/en/changelog
- https://github.com/anthropics/claude-code/releases/tag/v2.1.118
- https://github.com/anthropics/claude-code/releases/tag/v2.1.119
- https://code.claude.com/docs/en/hooks#pretooluse
- https://code.claude.com/docs/en/hooks#pretooluse-decision-control
- https://code.claude.com/docs/en/hooks#hook-lifecycle
- https://code.claude.com/docs/en/hooks#userpromptsubmit-input
- https://code.claude.com/docs/en/changelog#2-1-299
- https://code.claude.com/docs/en/changelog#2-1-300
**지원 모델:** Claude Fable 5, Claude Opus 5, Claude Sonnet 5, Claude Sonnet 4.6, Claude Opus 4.8, Claude Haiku 4.5
