#!/bin/bash

set -euo pipefail

sudo chown -R vscode:vscode /workspace/.venv

# Install/update PreK tool (idempotent)
echo "Ensuring prek installed (pinned via uv tool cache)..."
uv tool install prek >/dev/null 2>&1 || true
prek install

# Sync dependencies only if environment missing or manifests changed (safety net; main pre-warm is in image layer)
if [ ! -d .venv ] || [ ! -f uv.lock ] || [ pyproject.toml -nt .venv ] || [ uv.lock -nt .venv ]; then
	echo "Performing uv sync (post-create)..."
	uv sync
else
	echo "uv sync skipped (environment up-to-date)."
fi

echo "PostCreate complete"
