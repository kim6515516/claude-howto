<!-- i18n-source: .github/TESTING.md -->
<!-- i18n-source-sha: 728bd50 -->
<!-- i18n-date: 2026-10-26 -->
# 테스트 가이드

이 문서는 Claude How To의 테스트 기반에 대해 설명합니다.

## 개요

이 프로젝트는 GitHub Actions를 사용해 모든 푸시와 풀 리퀘스트에서 자동으로 테스트를 실행합니다. 테스트 내용:

- **유닛 테스트**: pytest를 이용한 Python 테스트
- **코드 품질**: Ruff를 이용한 린팅과 포맷팅
- **보안**: Bandit을 이용한 취약점 스캔
- **타입 체크**: mypy를 이용한 정적 타입 분석
- **빌드 검증**: EPUB 생성 테스트

## 로컬에서 테스트 실행하기

### 사전 요구 사항

```bash
# Install uv (fast Python package manager)
pip install uv

# Or on macOS with Homebrew
brew install uv
```

### 환경 설정

```bash
# Clone the repository
git clone https://github.com/luongnv89/claude-howto.git
cd claude-howto

# Create virtual environment
uv venv

# Activate it
source .venv/bin/activate  # macOS/Linux
# or
.venv\Scripts\activate     # Windows

# Install development dependencies
uv pip install -r requirements-dev.txt
```

### 테스트 실행

```bash
# Run all unit tests
pytest scripts/tests/ -v

# Run tests with coverage
pytest scripts/tests/ -v --cov=scripts --cov-report=html

# Run specific test file
pytest scripts/tests/test_build_epub.py -v

# Run specific test function
pytest scripts/tests/test_build_epub.py::test_function_name -v

# Run tests in watch mode (requires pytest-watch)
ptw scripts/tests/
```

### 린팅 실행

```bash
# Check code formatting
ruff format --check scripts/

# Auto-fix formatting issues
ruff format scripts/

# Run linter
ruff check scripts/

# Auto-fix linter issues
ruff check --fix scripts/
```

### 보안 스캔 실행

```bash
# Run Bandit security scan
bandit -c pyproject.toml -r scripts/ --exclude scripts/tests/

# Generate JSON report
bandit -c pyproject.toml -r scripts/ --exclude scripts/tests/ -f json -o bandit-report.json
```

### 타입 체크 실행

```bash
# Check types with mypy
mypy scripts/ --ignore-missing-imports --no-implicit-optional
```

## GitHub Actions 워크플로

### 트리거

- `main` 또는 `develop` 브랜치로의 **푸시**(scripts가 변경되었을 때)
- `main`으로의 **풀 리퀘스트**(scripts가 변경되었을 때)
- 수동 workflow dispatch

### 잡

#### 1. 유닛 테스트(pytest)

- **실행 환경**: Ubuntu latest
- **Python 버전**: 3.10, 3.11, 3.12
- **내용**:
  - `requirements-dev.txt`에서 의존성을 설치
  - 커버리지 리포트와 함께 pytest를 실행
  - 커버리지를 Codecov에 업로드
  - 테스트 결과와 커버리지 HTML을 아카이브

**결과**: 테스트가 하나라도 실패하면 워크플로 실패(치명적)

#### 2. 코드 품질(Ruff)

- **실행 환경**: Ubuntu latest
- **Python 버전**: 3.11
- **내용**:
  - `ruff format`으로 코드 포맷을 확인
  - `ruff check`로 린터를 실행
  - 문제를 보고하지만 워크플로를 실패시키지는 않음

**결과**: 비차단(경고만)

#### 3. 보안 스캔(Bandit)

- **실행 환경**: Ubuntu latest
- **Python 버전**: 3.11
- **내용**:
  - 보안 취약점을 스캔
  - JSON 리포트를 생성
  - 리포트를 아티팩트로 업로드

**결과**: 비차단(경고만)

#### 4. 타입 체크(mypy)

- **실행 환경**: Ubuntu latest
- **Python 버전**: 3.11
- **내용**:
  - 정적 타입 분석을 실행
  - 타입 불일치를 보고
  - 버그를 조기에 발견하는 데 도움이 됨

**결과**: 비차단(경고만)

#### 5. EPUB 빌드

- **실행 환경**: Ubuntu latest
- **의존 잡**: pytest, lint, security(모두 통과해야 함)
- **내용**:
  - `scripts/build_epub.py`를 사용해 EPUB 파일을 빌드
  - EPUB이 정상적으로 생성되었는지 검증
  - EPUB을 아티팩트로 업로드

**결과**: 빌드가 실패하면 워크플로 실패(치명적)

#### 6. 요약

- **실행 환경**: Ubuntu latest
- **의존 잡**: 위의 모든 잡
- **내용**:
  - 워크플로 요약을 생성
  - 모든 아티팩트를 목록으로 표시
  - 전체 상태를 보고

## 테스트 작성 방법

### 테스트 구조

테스트는 `scripts/tests/` 아래에 `test_*.py` 같은 이름으로 배치합니다:

```python
# scripts/tests/test_example.py
import pytest
from scripts.example_module import some_function

def test_basic_functionality():
    """Test that some_function works correctly."""
    result = some_function("input")
    assert result == "expected_output"

def test_error_handling():
    """Test that some_function handles errors gracefully."""
    with pytest.raises(ValueError):
        some_function("invalid_input")

@pytest.mark.asyncio
async def test_async_function():
    """Test async functions."""
    result = await async_function()
    assert result is not None
```

### 테스트 모범 사례

- **서술적인 이름을 사용**: `test_function_returns_correct_value()`
- **테스트 하나당 어서션 하나**(가능한 한): 실패 디버깅이 쉬워짐
- **재사용 가능한 설정에는 픽스처를 사용**: `scripts/tests/conftest.py` 참고
- **외부 서비스는 모킹**: `unittest.mock` 또는 `pytest-mock`을 사용
- **엣지 케이스를 테스트**: 빈 입력, None 값, 오류
- **테스트를 빠르게 유지**: sleep()과 외부 I/O를 피함
- **pytest 마커를 사용**: 느린 테스트에는 `@pytest.mark.slow`

### 픽스처

공통 픽스처는 `scripts/tests/conftest.py`에 정의합니다:

```python
# Use fixtures in your tests
def test_something(tmp_path):
    """tmp_path fixture provides temporary directory."""
    test_file = tmp_path / "test.txt"
    test_file.write_text("content")
    assert test_file.read_text() == "content"
```

## 커버리지 리포트

### 로컬 커버리지

```bash
# Generate coverage report
pytest scripts/tests/ --cov=scripts --cov-report=html

# Open the coverage report in your browser
open htmlcov/index.html
```

### 커버리지 목표

- **최소 커버리지**: 80%
- **브랜치 커버리지**: 활성화
- **중점 영역**: 핵심 기능과 오류 경로

## pre-commit 훅

이 프로젝트는 pre-commit 훅으로 커밋 전에 자동 검사를 실행합니다:

```bash
# Install pre-commit hooks
pre-commit install

# Run hooks manually
pre-commit run --all-files

# Skip hooks for a commit (not recommended)
git commit --no-verify
```

`.pre-commit-config.yaml`에 설정된 훅:
- Ruff 포매터
- Ruff 린터
- Bandit 보안 스캐너
- YAML 검증
- 파일 크기 검사
- 머지 충돌 감지

## 문제 해결

### 로컬에서는 통과하지만 CI에서 실패함

흔한 원인:
1. **Python 버전 차이**: CI는 3.10, 3.11, 3.12를 사용
2. **의존성 누락**: `requirements-dev.txt`를 업데이트
3. **플랫폼 차이**: 경로 구분자, 환경 변수
4. **불안정한 테스트**: 타이밍이나 순서에 의존하는 테스트

해결책:
```bash
# Test with the same Python versions
uv python install 3.10 3.11 3.12

# Test with clean environment
rm -rf .venv
uv venv
uv pip install -r requirements-dev.txt
pytest scripts/tests/
```

### Bandit이 오탐을 냄

보안 경고 중에는 오탐인 경우도 있습니다. `pyproject.toml`에서 설정합니다:

```toml
[tool.bandit]
exclude_dirs = ["scripts/tests"]
skips = ["B101"]  # Skip assert_used warning
```

### 타입 체크가 너무 엄격함

특정 파일에서 타입 체크를 완화합니다:

```python
# Add at the top of file
# type: ignore

# Or for specific lines
some_dynamic_code()  # type: ignore
```

## 지속적 통합 모범 사례

1. **테스트를 빠르게 유지**: 각 테스트는 1초 이내에 완료
2. **외부 API를 테스트하지 않음**: 외부 서비스를 모킹
3. **격리해서 테스트**: 각 테스트는 독립적이어야 함
4. **명확한 어서션을 사용**: `assert x`가 아니라 `assert x == 5`
5. **비동기 테스트를 다룸**: `@pytest.mark.asyncio`를 사용
6. **리포트를 생성**: 커버리지, 보안, 타입 체크

## 리소스

- [pytest Documentation](https://docs.pytest.org/)
- [Ruff Documentation](https://docs.astral.sh/ruff/)
- [Bandit Documentation](https://bandit.readthedocs.io/)
- [mypy Documentation](https://mypy.readthedocs.io/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## 테스트에 기여하기

PR을 제출할 때:

1. 새 기능에는 **테스트를 작성**
2. **로컬에서 테스트를 실행**: `pytest scripts/tests/ -v`
3. **커버리지를 확인**: `pytest scripts/tests/ --cov=scripts`
4. **린팅을 실행**: `ruff check scripts/`
5. **보안 스캔**: `bandit -r scripts/ --exclude scripts/tests/`
6. 테스트가 바뀌면 **문서를 업데이트**

모든 PR에는 테스트가 필요합니다! 🧪

---

테스트에 관한 질문이나 문제는 GitHub Issue 또는 Discussion을 열어 주세요.
