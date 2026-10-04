#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
command -v docker >/dev/null || { echo 'ERROR: Docker is not installed or not in PATH.'; exit 1; }
docker compose version >/dev/null 2>&1 || { echo 'ERROR: Docker Compose v2 is required.'; exit 1; }
printf '\nGREEN ARMOR CYBER RANGE\nStarting lab...\n\n'
docker compose up -d --build --wait
printf '\nLab is ready.\nUse: ./shell.sh\nThen type: mission\n\nOptional instructor validation: ./tests/self-test.sh\n'
