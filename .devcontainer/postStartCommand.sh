#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

echo "Configuring git safe directory..."
git config --global --add safe.directory /workspace &>/dev/null

uv sync

echo "Poststart success"
