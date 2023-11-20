#!/bin/bash

function is_root {
  [ "${EUID:-$(id -u)}" -eq 0 ];
}

if ! is_root; then
  echo -e "\x1B[31m[ERROR] This script requires root privileges."
  exit 1
fi

PARENT_DIR="${1}"
CURRENT_USER=$(who | awk 'NR==1{print $1}')

if [ -z "${PARENT_DIR}" ]; then
  PARENT_DIR="/opt"
fi

CPPZMQ_DIR="${PARENT_DIR}/cppzmq"
TMP_CPPZMQ="/tmp/cppzmq"

rm -rf "${TMP_CPPZMQ}"
mkdir -p "${TMP_CPPZMQ}"

git clone https://github.com/zeromq/cppzmq.git -o cppzmq "${TMP_CPPZMQ}"

mkdir -p "${TMP_CPPZMQ}/build"

pushd "${TMP_CPPZMQ}/build" || exit 1
cmake .. \
  -DCMAKE_PREFIX_PATH="${PARENT_DIR}/libzmq" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX="${CPPZMQ_DIR}"

make -j "$(nproc)"
make install
popd || exit 1

rm -rf "${TMP_CPPZMQ}"

chown -R "${CURRENT_USER}:${CURRENT_USER}" "${CPPZMQ_DIR}"
