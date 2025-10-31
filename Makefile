# Makefile for uv with smart install + explicit updates
SHELL := /bin/bash
.DEFAULT_GOAL := install
.PHONY: install update-deps test lint format clean run help check all secrets check-tools

# Help target
help:
	@echo "Available targets:"
	@echo "  install      - Install dependencies (frozen)"
	@echo "  update-deps  - Update and sync dependencies"
	@echo "  test         - Run tests with pytest"
	@echo "  lint         - Check code with ruff"
	@echo "  format       - Format code with ruff"
	@echo "  run          - Run the main application"
	@echo "  clean        - Remove cache and temporary files"
	@echo "  secrets      - Scan for secrets using detect-secrets"
	@echo "  check-tools  - Check if required tools are installed"


install: uv.lock
	uv sync --frozen

uv.lock: pyproject.toml
	uv sync

update-deps:
	uv sync

test:
	uv run pytest tests/

lint:
	uv run ruff check python_template tests

format:
	uv run ruff format python_template tests

run:
	uv run python python_template/__main__.py

secrets: .secrets.baseline
	uv run detect-secrets scan --baseline .secrets.baseline

.secrets.baseline:
	uv run detect-secrets scan > .secrets.baseline

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	rm -rf .coverage htmlcov/ dist/ build/

check-tools:
	@echo "🔍 Checking required tools..."
	@echo ""
	@printf "%-20s" "uv:"; \
	if command -v uv &> /dev/null; then \
		echo "✅ $(shell uv --version)"; \
	else \
		echo "❌ Not installed - https://docs.astral.sh/uv/getting-started/installation/"; \
	fi
	@printf "%-20s" "git:"; \
	if command -v git &> /dev/null; then \
		echo "✅ $(shell git --version)"; \
	else \
		echo "❌ Not installed"; \
	fi
	@printf "%-20s" "docker:"; \
	if command -v docker &> /dev/null; then \
		echo "✅ $(shell docker --version)"; \
	else \
		echo "❌ Not installed - https://docs.docker.com/get-docker/"; \
	fi
	@printf "%-20s" "prek:"; \
	if command -v prek &> /dev/null; then \
		echo "✅ $(shell prek --version)"; \
	else \
		echo "⚠️  Not installed - Run: uvx prek install"; \
	fi
	@echo ""
	@echo "💡 Install missing tools using the links above"
