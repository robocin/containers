#!/bin/bash

function is_root {
  [ "${EUID:-$(id -u)}" -eq 0 ];
}

if ! is_root; then
  echo -e "\x1B[31m[ERROR] This script requires root privileges."
  exit 1
fi

INSTALL_DIR="${1}"
CURRENT_USER=$(who | awk 'NR==1{print $1}')

if [ -z "${INSTALL_DIR}" ]; then
  INSTALL_DIR="/usr"
fi

TMP_DIR="/tmp/protoc"

rm -rf "${TMP_DIR}"
mkdir -p "${TMP_DIR}"

pushd "${TMP_DIR}" || exit 1

curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v23.3/protoc-23.3-linux-x86_64.zip
unzip -o protoc-23.3-linux-x86_64.zip -d "${INSTALL_DIR}"

popd || exit 1