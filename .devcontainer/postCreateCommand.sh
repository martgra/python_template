#!/bin/bash

set -e

sudo chown -R vscode:vscode /workspace/.venv

echo "Upgrading pip..."
pip install --upgrade pip > /dev/null 2>&1

echo "Installing pre-commit..."
uv tool install pre-commit
pre-commit install

echo "Postcreate success"
