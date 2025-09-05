#!/bin/bash

function is_root {
  [ "${EUID:-$(id -u)}" -eq 0 ];
}

if ! is_root; then
  echo -e "\x1B[31m[ERROR] This script requires root privileges."
  exit 1
fi

GITHUB_SOURCE_CONTENT_PREFIX="https://raw.githubusercontent.com/robocin/scripts-ubuntu-common/main"

function exec_from_git_source_repository() {
  local name="$1"
  local args="${*:2}"

  local script="$GITHUB_SOURCE_CONTENT_PREFIX/$name.sh"

  echo "Downloading $script"

  if ! wget -q --spider "$script"; then
    echo -e "\x1B[31m[ERROR] Script '$name' not found."
    exit 1
  fi

  bash -c "$(wget -O - $script)" "" "$args"
}

if [ "$#" -eq 0 ]; then
  echo -e "\x1B[31m[ERROR] No arguments provided."
  exit 1
fi

for ARG in "$@"; do
  exec_from_git_source_repository $(echo "$ARG")
  if [ $? -ne 0 ]; then
    echo -e "\x1B[31m[ERROR] Script '$ARG' failed."
    exit 1
  fi
done