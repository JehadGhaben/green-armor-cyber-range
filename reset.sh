#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
docker compose down -v --remove-orphans
docker compose up -d --build --wait
printf 'Lab reset complete.\n'
