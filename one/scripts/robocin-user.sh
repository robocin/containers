#!/bin/bash

function is_root {
  [ "${EUID:-$(id -u)}" -eq 0 ];
}

if ! is_root; then
  echo -e "\x1B[31m[ERROR] This script requires root privileges."
  exit 1
fi

USERNAME="robocin"
USER_UID=1000
USER_GID=1000

# Get existing user with the target UID
EXISTING_USER="$(getent passwd "${USER_UID}" | cut -d: -f1 || true)"

# If an existing user with the target UID exists and it's not the desired username, delete it
if [ -n "$EXISTING_USER" ] && [ "$EXISTING_USER" != "$USERNAME" ]; then
    echo "[INFO] Deleting user '${EXISTING_USER}' with UID ${USER_UID}"
    userdel -r "$EXISTING_USER" 2>/dev/null || true
fi

# Get existing group with the target GID
EXISTING_GROUP="$(getent group "${USER_GID}" | cut -d: -f1 || true)"

if [ -n "$EXISTING_GROUP" ] && [ "$EXISTING_GROUP" != "$USERNAME" ]; then
    echo "[INFO] Deleting group '${EXISTING_GROUP}' with GID ${USER_GID}"
    groupdel "$EXISTING_GROUP" 2>/dev/null || true
fi

# Create group if it doesn't exist
if ! getent group "$USERNAME" >/dev/null; then
    echo "[INFO] Creating group ${USERNAME} (GID=${USER_GID})"
    groupadd -g "$USER_GID" "$USERNAME" 2>/dev/null || true
fi

# Create user if it doesn't exist
if ! id -u "$USERNAME" >/dev/null 2>&1; then
    echo "[INFO] Creating user ${USERNAME} (UID=${USER_UID})"
    useradd \
        -u "$USER_UID" \
        -g "$USER_GID" \
        -m \
        -s /bin/bash \
        "$USERNAME" \
        2>/dev/null || true # silent failure
    usermod -aG sudo "$USERNAME"
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
else
    echo "[INFO] User ${USERNAME} already exists."
fi

# Ensure home directory exists
if [ ! -d "/home/${USERNAME}" ]; then
    echo "[INFO] Creating home directory for ${USERNAME}"
    mkdir -p "/home/${USERNAME}"
    chown "${USERNAME}:${USERNAME}" "/home/${USERNAME}"
fi

echo "[INFO] Finished setting up user ${USERNAME} (UID=${USER_UID} GID=${USER_GID})"
