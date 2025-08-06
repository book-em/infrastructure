#!/bin/bash

# run.sh [just_build]
#
# - just_build: If set to "true", docker compose will only build.

set -e

# Load env vars safely
ENV_FILES=(
  "./default.env"
  "./override.env"
)

for file in "${ENV_FILES[@]}"; do
  if [[ -f "$file" ]]; then
    echo "Loading env vars from $file"
    set -o allexport
    source "$file"
    set +o allexport
  else
    echo "Skipping missing optional env file: $file"
  fi
done

# Parse argument
just_build="${1:-false}"

# Build
docker compose build

# Run
if [[ "$just_build" == "true" ]]; then
  echo "just_build is set to true, not running..."
else
  echo "just_build is not set, running..."
  docker compose up
fi