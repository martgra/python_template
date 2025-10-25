# python-template

![CI](https://github.com/martgra/python_template/actions/workflows/ci.yaml/badge.svg?branch=main)
![Python](https://img.shields.io/badge/python-3.10%2B-blue?logo=python\&logoColor=white)
[![Copier](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/copier-org/copier/master/img/badge/badge-grayscale-inverted-border-orange.json)](https://github.com/copier-org/copier)

Modern Python project template for VS Code.

**Tools:** [uv](https://docs.astral.sh/uv/) · [Ruff](https://docs.astral.sh/ruff/) · [Pylint](https://pylint.readthedocs.io/en/stable/) · [prek](https://github.com/j178/prek) · [pytest](https://docs.pytest.org/en/stable/)

## Quick Start

**Prerequisites:** [uv](https://docs.astral.sh/uv/getting-started/installation/), [VS Code](https://code.visualstudio.com/), Docker (optional)

```bash
# 1. Generate project (if not already done)
uvx copier copy gh:martgra/python_template <destination> --trust

# 2. Install dependencies
cd <destination>
uv sync

# 3. Verify setup
make test
```

You're ready to code.

## Daily Workflows

**Development:**
```bash
make run            # Run your application
make test           # Run test suite
make format         # Auto-format code
```

**Before commit:**
```bash
make lint           # Check code quality
# Hooks run automatically on commit
```

**Maintenance:**
```bash
make update-deps    # Update dependencies
make help           # See all commands
```

**Direct tool access:**
```bash
uv run pytest tests/
uv run ruff check python_template
uv run python -m python_template
```

## Project Layout

```text
python_template/     # Your package
tests/                  # Test suite
pyproject.toml          # Dependencies & config
uv.lock                 # Locked versions
.pre-commit-config.yaml # Code quality hooks
.vscode/                # Editor config
.devcontainer/          # Docker setup (optional)
```

Python ≥ 3.10 required locally. Devcontainer uses Python 3.13.

## Tool Stack

Configuration in `pyproject.toml` and `.pre-commit-config.yaml`.

- **[uv](https://docs.astral.sh/uv/)** – dependency management
- **[Ruff](https://docs.astral.sh/ruff/)** – fast linting & formatting
- **[Pylint](https://pylint.readthedocs.io/en/stable/)** – deep static analysis
- **[prek](https://github.com/j178/prek)** – pre-commit hooks
- **[pytest](https://docs.pytest.org/en/stable/)** – testing framework
- **[Deptry](https://github.com/fpgmaas/deptry)** – dependency validation
- **[Vulture](https://github.com/jendrikseipp/vulture)** – dead code detection
- **[detect-secrets](https://github.com/Yelp/detect-secrets)** – secret scanning


## CI Pipeline

GitHub Actions runs on PRs and main branch pushes. Workflow: install deps → run all prek hooks (lint, format, test, security).

See [`.github/workflows/ci.yaml`](.github/workflows/ci.yaml).



## Devcontainer

For reproducible Docker-based development, reopen the project in a container (**Dev Containers: Reopen in Container** in VS Code). Pre-configures Python 3.13, uv, and all tools.

Docs: [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)


## Template Updates

Keep your project current with template improvements:

```bash
uvx copier update
```

Docs: [Copier Updates](https://copier.readthedocs.io/en/stable/updating/)

## License

Distributed under the **MIT License**.
