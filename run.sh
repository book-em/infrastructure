#!/bin/bash

# Usage:
#
#
# run.sh
#
#   First argument is the command (run, build or down)
#
#   Second argument is the profile. Currently only default and `full` are
#   supported, where `full` builds the web app (otherwise, use npm run dev).
#
# run.sh run 
# run.sh build 
# run.sh down
#
# run.sh run   full 
# run.sh build full 
# run.sh down  full
#

set -e

# Create log directories

mkdir -p ./logs/user-service
mkdir -p ./logs/room-service
mkdir -p ./logs/reservation-service
mkdir -p ./logs/notification-service
mkdir -p ./logs/rating-service

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

# Generate env.js for web-app

if [[ "$profile" == "full" ]]; then
  cat <<EOF > ./temp/web-app-env.js
  window.__ENV__ = {
    VITE_USER_SERVICE_URL: "http://localhost:${USER_SERVICE_PORT}",
    VITE_ROOM_SERVICE_URL: "http://localhost:${ROOM_SERVICE_PORT}",
    VITE_ROOM_SERVICE_IMAGES_URL: "http://localhost:${ROOM_SERVICE_IMAGES_PORT}",
    VITE_RESERVATION_SERVICE_URL: "http://localhost:${RESERVATION_SERVICE_PORT}",
    VITE_NOTIFICATION_SERVICE_URL: "http://localhost:${NOTIFICATION_SERVICE_PORT}",
    VITE_RATING_SERVICE_URL: "http://localhost:${RATING_SERVICE_PORT}",
  };
EOF
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