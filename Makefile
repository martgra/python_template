# Makefile for uv with smart install + explicit updates

.DEFAULT_GOAL := install
.PHONY: install update-deps test lint format clean run help check all

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

install: uv.lock
	uv sync --frozen

uv.lock: pyproject.toml
	uv sync

update-deps:
	uv sync

test:
	uv run pytest tests/

lint:
	uv run ruff check python_package tests

format:
	uv run ruff format python_package tests

run:
	uv run python python_package/__main__.py

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	rm -rf .coverage htmlcov/ dist/ build/
