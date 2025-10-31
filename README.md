# python-template

![CI](https://github.com/martgra/python-template/actions/workflows/ci.yaml/badge.svg?branch=main)
![Python](https://img.shields.io/badge/python-3.11%2B-blue?logo=python&logoColor=white)
[![Copier](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/copier-org/copier/master/img/badge/badge-grayscale-inverted-border-orange.json)](https://github.com/copier-org/copier)

A solid project template for Python.

## ✨ Features

- **Modern Python** – Requires Python ≥ 3.11.
- **Dependency management with uv** – Fast dependency installation and lock file management.
- **Quality tools**
  - Ruff formats and lints code
  - Pylint performs deeper static analysis
  - Deptry detects unused, missing and transitive dependencies
  - Vulture finds dead code.
- **Secret scanning with detect-secrets** - Prevent secrets getting commited and pushed.
- **Git hooks with Prek** – Automated quality checks on every commit and push.
- **Automated CI/CD** – GitHub Actions run all Prek hooks on pull requests and pushes to ensure code quality.
- **Dev Container** – Devcontainer provides a reproducible environment with Python 3.13, uv and all tools preconfigured.

## Quick Start

Get started in seconds:

```bash
uvx copier copy gh:martgra/python_template <destination> --trust
```

## Project Layout

```
python_template/         # Your package
tests/                      # Test suite
pyproject.toml              # Dependencies & configuration
uv.lock                     # Locked versions
.pre-commit-config.yaml     # Git hook configuration (used by Prek)
.secrets.baseline           # detect-secrets baseline
Makefile                    # Common tasks (test, lint, format, etc.)
.vscode/                  # VSCode settings
.devcontainer/            # Dev container configuration
.github/workflows/       # CI/CD workflows
```

Python ≥ 3.11 is required locally. The dev container uses Python 3.13.

## Git Hooks (Prek)

[Prek](https://github.com/j178/prek) is a fast Rust‑based replacement for pre‑commit that uses the same configuration format. Install hooks with:

```bash
uvx prek install
```

### Fast Commit Hooks (run on every commit)

- **Ruff** – Lints and formats Python code (auto‑fix enabled)
- **File checks** – Trailing whitespace, end‑of‑file newlines, JSON/YAML/TOML validation
- **Security** – Detect private keys

### Slower Push Hooks (run on `git push`)

- **pytest** – Full test suite
- **Pylint** – Deep static analysis for code design issues
- **Deptry** – Checks for unused, missing, and transitive dependencies
- **Vulture** – Finds dead/unused code
- **detect‑secrets** – Scans for secrets against baseline
- **uv‑lock** – Validates `pyproject.toml` and lock file consistency

This two‑tier approach keeps commits fast while ensuring comprehensive quality checks before pushing.

## CI Pipeline

GitHub Actions run on pull requests and pushes to the main branch. The workflow uses the same Prek configuration, executing all hooks (both commit and push stages) to ensure code quality.

See [`.github/workflows/ci.yaml`](.github/workflows/ci.yaml).

## Devcontainer

For reproducible Docker‑based development, reopen the project in a container (**Dev Containers: Reopen in Container** in VS Code). The container pre‑configures Python 3.13, uv and all tools.

Docs: [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)

## Template Updates

Keep your project current with template improvements:

```bash
uvx copier update
```

Docs: [Copier Updates](https://copier.readthedocs.io/en/stable/updating/)

## License

Distributed under the **MIT License**.
