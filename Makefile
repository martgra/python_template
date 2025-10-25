SHELL := /bin/bash
.PHONY: test build clean

test:
	@set -euo pipefail; \
	tmpdir=$$(mktemp -d); \
	echo "🔧 Generating template into: $$tmpdir"; \
	uvx copier copy --vcs-ref=HEAD . "$$tmpdir" --defaults --force --trust; \
	cd "$$tmpdir"; \
	echo "🌀 Initializing git repo..."; \
	git add -A >/dev/null; \
	uvx prek install >/dev/null; \
	echo "🚀 Running pre-commit hooks..."; \
	uvx prek run --all-files; \
	cd - >/dev/null; \
	rm -rf "$$tmpdir"; \
	echo "✅ All checks passed and temp folder cleaned up."

build:
	@echo "🔧 Generating template into: build_output/"
	@rm -rf build_output
	@uvx copier copy --vcs-ref=HEAD . build_output --defaults --force --trust --data skip_git_init=true
	@echo "🚀 Running pre-commit hooks on build output..."
	@cd build_output && uvx prek install && uvx prek run --files $$(find . -type f -not -path '*/\.git/*')
	@echo "✅ Template generated and validated successfully!"
	@echo "📁 Check the output in: build_output/"

clean:
	@echo "🧹 Cleaning build output..."
	@rm -rf build_output
	@echo "✅ Cleaned!"
