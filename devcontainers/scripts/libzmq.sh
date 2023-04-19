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

LIBZMQ_DIR="${PARENT_DIR}/libzmq"
TMP_LIBZMQ="/tmp/libzmq"

rm -rf "${TMP_LIBZMQ}"
mkdir -p "${TMP_LIBZMQ}"

git clone https://github.com/zeromq/libzmq.git -o libzmq "${TMP_LIBZMQ}"

mkdir -p "${TMP_LIBZMQ}/build"

pushd "${TMP_LIBZMQ}/build" || exit 1
cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DZMQ_BUILD_TESTS=OFF \
  -DCMAKE_INSTALL_PREFIX="${LIBZMQ_DIR}"

make -j "$(nproc)"
make install
popd || exit 1

rm -rf "${TMP_LIBZMQ}"

chown -R "${CURRENT_USER}:${CURRENT_USER}" "${LIBZMQ_DIR}"
