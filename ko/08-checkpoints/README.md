<!-- i18n-source: 08-checkpoints/README.md -->
<!-- i18n-source-sha: d17d515 -->
<!-- i18n-date: 2026-10-26 -->

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../../resources/logos/claude-howto-logo.svg">
</picture>

# 체크포인트와 되돌리기

체크포인트는 Claude Code 세션의 대화 상태를 저장하고 과거 시점으로 되돌리기 위한 기능입니다. 여러 접근 방식을 비교하고 싶을 때, 실수에서 복구하고 싶을 때, 대안을 나란히 살펴보고 싶을 때 큰 위력을 발휘합니다.

## 개요

체크포인트를 사용하면 대화 상태를 저장하고 과거 시점으로 돌아갈 수 있으므로, 안전하게 시행착오를 거치며 여러 접근 방식을 탐색할 수 있습니다. 체크포인트는 대화 상태의 스냅숏이며 다음을 포함합니다:
- 주고받은 모든 메시지
- 적용된 파일 변경
- 도구 사용 이력
- 세션 컨텍스트

다른 접근 방식 시도, 실수에서의 복구, 대안 비교 같은 상황에서 위력을 발휘합니다.

## 핵심 개념

| 개념 | 설명 |
|------|------|
| **Checkpoint(체크포인트)** | 메시지·파일·컨텍스트를 포함한 대화 상태의 스냅숏 |
| **Rewind(되돌리기)** | 과거의 체크포인트로 돌아가 그 이후의 변경을 버리는 조작 |
| **Branch Point(분기점)** | 여러 접근 방식을 시도하기 위한 출발점이 되는 체크포인트 |

## 체크포인트에 접근하기

체크포인트에 접근하고 관리하는 주요 방법은 두 가지입니다.

### 키보드 단축키
`Esc` 키를 두 번(`Esc` + `Esc`) 누르면 체크포인트 인터페이스가 열리고 저장된 체크포인트를 둘러볼 수 있습니다.

### 슬래시 명령어
빠르게 접근하려면 `/rewind` 명령어(별칭: `/checkpoint`, `/undo`)를 사용합니다:

```bash
# 되돌리기 인터페이스 열기
/rewind

# 또는 별칭 사용
/checkpoint
```

## 되돌리기 옵션

되돌리기를 실행하면 6가지 옵션 메뉴가 표시됩니다:

1. **Restore code and conversation** -- 지정한 체크포인트의 상태로 파일과 메시지를 모두 되돌립니다
2. **Restore conversation** -- 메시지만 되돌리고 현재 코드는 그대로 둡니다
3. **Restore code** -- 파일 변경만 되돌리고 대화 이력은 완전히 유지합니다
4. **Summarize from here** -- 그 지점 이후의 대화를 AI가 생성한 요약으로 압축해 컨텍스트 윈도우를 확보합니다. 선택 지점보다 앞선 메시지는 그대로 남습니다. 디스크의 파일은 변경되지 않습니다. 원본 메시지는 세션 트랜스크립트에 보존됩니다. 요약을 특정 주제에 집중시키기 위한 지시를 선택적으로 줄 수 있습니다.
5. **Summarize up to here** -- 반대 방향의 대응 기능입니다. 선택 지점보다 *앞선* 모든 내용을 AI가 생성한 요약으로 압축하고, 그 이후의 메시지는 그대로 남깁니다. "Summarize from here"와 함께 쓰면 컨텍스트 윈도우를 양방향으로, 원하는 범위만 압축할 수 있습니다. 디스크의 파일은 변경되지 않으며, 원본 메시지는 세션 트랜스크립트에 보존됩니다.
6. **Never mind** -- 조작을 취소하고 현재 상태로 돌아갑니다

> **참고**: 대화를 복원한 뒤 또는 "Summarize from here"를 선택한 뒤에는, 선택한 메시지의 원래 프롬프트가 입력란에 복원되어 다시 보내거나 편집할 수 있는 상태가 됩니다. "Summarize up to here"를 선택한 경우에는 대화의 끝으로 돌아가고 입력란은 비어 있습니다.

## 자동 체크포인트

Claude Code는 자동으로 체크포인트를 만듭니다:

- **사용자 입력마다** - 입력할 때마다 새 체크포인트가 생성됩니다
- **세션 간 보존** - 체크포인트는 대화와 함께 저장되므로 세션을 재개한 뒤에도 `/rewind`를 사용할 수 있습니다
- **자동 정리** - 30일이 지난 체크포인트는 자동으로 삭제됩니다

덕분에 몇 분 전부터 며칠 전까지, 대화의 어느 시점으로든 되돌릴 수 있습니다.

## 사용 사례

| 시나리오 | 워크플로 |
|----------|-------------|
| **접근 방식 탐색** | 저장 → 안 A 시도 → 저장 → 되돌리기 → 안 B 시도 → 비교 |
| **안전한 리팩터링** | 저장 → 리팩터링 → 테스트 → 실패하면 되돌리기 |
| **A/B 테스트** | 저장 → 설계 A → 저장 → 되돌리기 → 설계 B → 비교 |
| **실수에서 복구** | 문제 발견 → 직전의 정상 상태로 되돌리기 |

## 체크포인트 사용하기

### 목록 표시와 되돌리기

`Esc`를 두 번 누르거나 `/rewind`를 실행하면 체크포인트 브라우저가 열립니다. 타임스탬프가 붙은 목록에서 원하는 체크포인트를 고르면 그 상태로 되돌아갑니다.

### 체크포인트 세부 정보

각 체크포인트에는 다음이 표시됩니다:
- 생성 시각 타임스탬프
- 변경된 파일
- 대화 내 메시지 수
- 사용된 도구

## 실전 예제

### 예제 1: 다른 접근 방식 시도하기

```
User: Let's add a caching layer to the API

Claude: I'll add Redis caching to your API endpoints...
[Makes changes at checkpoint A]

User: Actually, let's try in-memory caching instead

Claude: I'll rewind to explore a different approach...
[User presses Esc+Esc and rewinds to checkpoint A]
[Implements in-memory caching at checkpoint B]

User: Now I can compare both approaches
```

### 예제 2: 실수에서 복구하기

```
User: Refactor the authentication module to use JWT

Claude: I'll refactor the authentication module...
[Makes extensive changes]

User: Wait, that broke the OAuth integration. Let's go back.

Claude: I'll help you rewind to before the refactoring...
[User presses Esc+Esc and selects the checkpoint before the refactor]

User: Let's try a more conservative approach this time
```

### 예제 3: 안전한 시행착오

```
User: Let's try rewriting this in a functional style
[Creates checkpoint before experiment]

Claude: [Makes experimental changes]

User: The tests are failing. Let's rewind.
[User presses Esc+Esc and rewinds to the checkpoint]

Claude: I've rewound the changes. Let's try a different approach.
```

### 예제 4: 접근 방식 분기하기

```
User: I want to compare two database designs
[Takes note of checkpoint - call it "Start"]

Claude: I'll create the first design...
[Implements Schema A]

User: Now let me go back and try the second approach
[User presses Esc+Esc and rewinds to "Start"]

Claude: Now I'll implement Schema B...
[Implements Schema B]

User: Great! Now I have both schemas to choose from
```

## 체크포인트 보존 기간

Claude Code는 체크포인트를 자동으로 관리합니다:

- 사용자 입력마다 체크포인트가 자동으로 생성됩니다
- 오래된 체크포인트는 최대 30일까지 보존됩니다
- 저장 공간이 무한히 늘어나지 않도록 자동으로 정리됩니다

## 워크플로 패턴

### 탐색을 위한 분기 전략

여러 접근 방식을 시도할 때:

```
1. 초기 구현 → 체크포인트 A
2. 접근 방식 1 시도 → 체크포인트 B
3. 체크포인트 A로 되돌리기
4. 접근 방식 2 시도 → 체크포인트 C
5. B와 C의 결과 비교
6. 가장 좋은 안을 골라 계속 진행
```

### 안전한 리팩터링 패턴

큰 변경을 가할 때:

```
1. 현재 상태 → 체크포인트 (자동)
2. 리팩터링 시작
3. 테스트 실행
4. 성공 → 계속 진행
5. 실패 → 되돌리고 다른 안 시도
```

## 모범 사례

체크포인트는 자동으로 생성되므로 상태 저장을 신경 쓰지 않고 작업에 집중할 수 있습니다. 다만 다음 포인트는 알아 두면 좋습니다.

### 체크포인트를 효과적으로 사용하기

✅ **권장:**
- 되돌리기 전에 사용할 수 있는 체크포인트를 확인합니다
- 다른 방향을 시도하고 싶을 때 되돌리기를 사용합니다
- 여러 접근 방식을 비교하기 위해 체크포인트를 남겨 둡니다
- 각 되돌리기 옵션(코드와 대화 복원, 대화만 복원, 코드만 복원, 요약)의 동작을 이해합니다

❌ **비권장:**
- 코드 보존을 체크포인트에만 의존하기
- 파일 시스템에 대한 외부 변경까지 추적된다고 가정하기
- git 커밋 대신 체크포인트를 사용하기

## 설정

체크포인트는 Claude Code의 내장 기능이며 활성화를 위한 설정은 필요 없습니다. 사용자 입력마다 체크포인트가 자동으로 생성됩니다.

체크포인트의 동작은 두 가지 설정으로 제어합니다. 스냅숏을 찍을지 여부와 얼마나 보존할지입니다:

```json
{
  "fileCheckpointingEnabled": true,
  "cleanupPeriodDays": 30
}
```

| 설정 | 기본값 | 효과 |
|------|-----------|------|
| `fileCheckpointingEnabled` | `true` | 각 편집 전에 파일 스냅숏을 찍어 `/rewind`로 복원할 수 있게 합니다. v2.1.119 이상이 필요합니다. `/config`에서는 **Rewind code (checkpoints)**로 표시됩니다. 환경 변수로 같은 설정을 하려면 `CLAUDE_CODE_DISABLE_FILE_CHECKPOINTING`을 사용합니다 |
| `cleanupPeriodDays` | `30` | 세션 이력과 체크포인트의 보존 일수 |

Claude Code가 스냅숏을 보존하는 것은 **최근 100개의 체크포인트**까지이며, 그보다 오래된 것은 보존 기간 안이라도 삭제됩니다.

> **v2.1.117 업데이트**: `cleanupPeriodDays`가 체크포인트뿐 아니라 디스크의 여러 캐시 보존 기간을 통합적으로 제어하게 되었습니다 (아래는 그 일부입니다. 트랜스크립트, `file-history/`, `plans/`, `debug/`, `paste-cache/` 등도 대상입니다):
>
> - 세션 체크포인트
> - `~/.claude/tasks/` — 영속적인 작업 목록
> - `~/.claude/shell-snapshots/` — 캡처된 셸 환경 스냅숏
> - `~/.claude/backups/` — `~/.claude.json`의 이전 버전 (최신 5개 보존)
>
> 설정 하나로 이 디렉터리들이 같은 일수 기준으로 일괄 정리됩니다.

## 제한 사항

체크포인트에는 다음 제한이 있습니다:

- **bash 명령어로 인한 변경은 추적되지 않습니다** - `rm`, `mv`, `cp` 같은 파일 시스템 조작은 체크포인트에 포함되지 않습니다
- **외부 변경은 추적되지 않습니다** - 에디터나 터미널 등 Claude Code 밖에서 한 변경은 포착되지 않습니다
- **버전 관리를 대신하지 않습니다** - 영속적이고 감사 가능한 변경에는 git을 사용합니다

## 문제 해결

### 체크포인트를 찾을 수 없음

**문제**: 기대한 체크포인트가 존재하지 않습니다

**대처법**:
- 체크포인트가 삭제되지 않았는지 확인합니다
- 디스크 용량을 확인합니다
- `cleanupPeriodDays`를 충분히 크게 설정합니다 (기본값: 30일)

### 되돌리기 실패

**문제**: 체크포인트로 되돌릴 수 없습니다

**대처법**:
- 커밋되지 않은 변경이 충돌하지 않는지 확인합니다
- 체크포인트가 손상되지 않았는지 확인합니다
- 다른 체크포인트로 되돌려 봅니다

## Git과의 연계

체크포인트는 git을 보완하지만 대체하지는 않습니다:

| 항목 | Git | 체크포인트 |
|------|-----|----------------|
| 범위 | 파일 시스템 | 대화 + 파일 |
| 영속성 | 영구 | 세션 단위 |
| 단위 | 커밋 단위 | 임의의 지점 |
| 속도 | 비교적 느림 | 즉시 |
| 공유 | 가능 | 제한적 |

둘을 조합해 사용합니다:
1. 시행착오에는 체크포인트를 사용합니다
2. 확정된 변경에는 git 커밋을 사용합니다
3. git 조작 전에 체크포인트를 만듭니다
4. 양호한 체크포인트 상태를 git에 커밋합니다

## 빠른 시작 가이드

### 기본 워크플로

1. **평소처럼 작업합니다** - Claude Code가 자동으로 체크포인트를 만듭니다
2. **되돌리고 싶어지면** - `Esc`를 두 번 누르거나 `/rewind`를 사용합니다
3. **체크포인트를 고릅니다** - 목록에서 되돌릴 지점을 선택합니다
4. **복원 대상을 고릅니다** - 코드와 대화, 대화만, 코드만, 여기부터 요약, 여기까지 요약, 취소 중에서 선택합니다
5. **작업을 계속합니다** - 선택한 시점으로 돌아간 상태에서 재개합니다

### 키보드 단축키

- **`Esc` + `Esc`** - 체크포인트 브라우저 열기
- **`/rewind`** - 체크포인트에 접근하는 또 다른 수단
- **`/checkpoint`**, **`/undo`** - `/rewind`의 별칭

## 언제 되돌릴지 알기: 컨텍스트 모니터링

체크포인트로 돌아갈 수는 있지만, *언제* 돌아가야 할지는 어떻게 판단할까요? 대화가 길어질수록 Claude의 컨텍스트 윈도우는 소모되고 모델 품질은 조용히 떨어집니다. 알아채지 못한 사이에 반쯤 눈이 가려진 모델에게서 코드를 받고 있을지도 모릅니다.

**[cc-context-stats](https://github.com/luongnv89/cc-context-stats)**는 Claude Code의 상태 표시줄에 실시간 **컨텍스트 존**을 추가해 이 문제를 해결합니다. 컨텍스트 윈도우의 어느 위치에 있는지를 추적해 **Plan**(초록, 계획과 코딩이 안전함)부터 **Code**(노랑, 새 계획은 시작하지 않음), **Dump**(주황, 정리하고 되돌릴 때)까지 단계별로 표시합니다. 존이 바뀌면, 품질이 떨어진 출력으로 밀어붙이지 말고 체크포인트에서 새로 시작해야 할 타이밍임을 알 수 있습니다.

## 관련 개념

- **[고급 기능](../09-advanced-features/)** - 플랜 모드와 그 밖의 고급 기능
- **[메모리 관리](../02-memory/)** - 대화 이력과 컨텍스트 관리
- **[슬래시 명령어](../01-slash-commands/)** - 사용자가 실행하는 단축 명령
- **[훅](../06-hooks/)** - 이벤트 기반 자동화
- **[플러그인](../07-plugins/)** - 번들로 묶인 확장 패키지

## 추가 자료

- [체크포인트 공식 문서](https://code.claude.com/docs/en/checkpointing)
- [고급 기능 가이드](../09-advanced-features/) - 확장 사고 등의 기능

## 정리

체크포인트는 Claude Code의 자동 기능으로, 작업을 잃을 걱정 없이 다양한 접근 방식을 안전하게 시도할 수 있게 해 줍니다. 사용자 입력마다 새 체크포인트가 만들어지므로 세션의 어느 시점으로든 돌아갈 수 있습니다.

주요 이점:
- 여러 접근 방식을 두려움 없이 시도할 수 있습니다
- 실수에서 빠르게 복구할 수 있습니다
- 서로 다른 해결안을 나란히 비교할 수 있습니다
- 버전 관리와 안전하게 조합할 수 있습니다

참고: 체크포인트는 git을 대신하지 않습니다. 시행착오에는 체크포인트를, 영속적인 코드 변경에는 git을 사용합니다.

---

**최종 업데이트**: 2026년 10월 18일
**Claude Code 버전**: 2.1.302
**출처**:
- https://code.claude.com/docs/en/checkpointing
- https://code.claude.com/docs/en/settings
- https://github.com/anthropics/claude-code/releases/tag/v2.1.117
- https://code.claude.com/docs/en/commands
- https://code.claude.com/docs/en/claude-directory
**지원 모델**: Claude Sonnet 4.6, Claude Opus 4.7, Claude Haiku 4.5
