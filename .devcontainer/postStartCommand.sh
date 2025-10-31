#!/bin/bash
set -euo pipefail

echo "Configuring git safe directory (idempotent)..."
git config --global --add safe.directory /workspace 2>/dev/null || true

echo "Adding copier as tool"
uv tool install copier

echo "PostStart complete"
