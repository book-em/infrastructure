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

# Parse arguments

mode="${1:-run}"
profile="${2:-''}"
echo "mode is set to: $mode"
echo "profile is: $profile"

# Create the proper command (with profile specified)

compose_cmd="docker compose"
if [[ -n "$profile" ]]; then
  compose_cmd+=" --profile $profile" 
fi

# Execute

if [[ "$mode" == "run" ]]; then
  echo "Building and running..."

  $compose_cmd build
  $compose_cmd up
elif [[ "$mode" == "build" ]]; then
  echo "Just building..."

  $compose_cmd build
elif [[ "$mode" == "down" ]]; then
  echo "Shutting down..."

  $compose_cmd down 
fi