#!/bin/bash
set -e

# Load data from env files, they're both optional, although it won't work if
# neither is present because the compose files expects some env vars that are
# defined in those env files.

ENV_FILES=(
  "./default.env"
  "./override.env"
)

for file in "${ENV_FILES[@]}"; do
  if [[ -f "$file" ]]; then
    echo "Loading env vars from $file"
    export $(grep -v '^#' "$file" | xargs)
  else
    echo "Skipping missing optional env file: $file"
  fi
done

# Run

docker compose build "$@"
docker compose up "$@"