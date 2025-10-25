# Python Template

![CI](https://github.com/martgra/python_template/actions/workflows/ci.yaml/badge.svg?branch=main)
[![Copier](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/copier-org/copier/master/img/badge/badge-grayscale-inverted-border-orange.json)](https://github.com/copier-org/copier)

A [Copier](https://copier.readthedocs.io/) template for modern Python projects using [uv](https://docs.astral.sh/uv/), [Ruff](https://docs.astral.sh/ruff/), [pytest](https://docs.pytest.org/), and optional VSCode devcontainer support.

## Features

- 🚀 **Modern tooling**: uv for dependency management, Ruff for linting/formatting
- 🧪 **Testing ready**: pytest with coverage support
- 🔒 **Quality checks**: Pylint, Deptry, Vulture, detect-secrets via prek hooks
- 🐳 **Optional devcontainer**: reproducible development environment with Docker
- ⚙️ **VSCode integration**: pre-configured settings and extensions
- 🤖 **GitHub Actions**: CI/CD workflow included

## Usage

Generate a new project using Copier:

```bash
uvx copier copy gh:martgra/python_template <destination>
```

## Development

This repository contains the Copier template itself. To test the template:

```bash
make test
```

This will:

1. Generate a project from the template in a temp directory
2. Initialize git and pre-commit hooks
3. Run all quality checks
4. Clean up the temp directory

## Template Structure

```
template/                    # Template files (what gets copied)
├── README.md.jinja          # Generated project README
├── pyproject.toml.jinja     # Project configuration
├── uv.lock                  # Dependency lock file
├── {{ package_name }}/      # Python package
├── tests/                   # Test files
├── includes/                # Jinja macros and utilities
└── {% if ... %}/            # Conditional directories

copier.yaml                  # Template configuration
Makefile                     # Template testing
```

## Requirements

- [Copier](https://copier.readthedocs.io/) 9.0.0+
- [uv](https://docs.astral.sh/uv/getting-started/installation/)

## License

MIT License
