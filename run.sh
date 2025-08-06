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
mode="${1:-run}"
echo "mode is set to $mode"

if [[ "$mode" == "run" ]]; then
  echo "Building and running..."

  docker compose build
  docker compose up
elif [[ "$mode" == "build" ]]; then
  echo "Just building..."

  docker compose build
elif [[ "$mode" == "down" ]]; then
  echo "Shutting down..."

  docker compose down 
fi