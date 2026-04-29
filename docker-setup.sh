#!/bin/bash
# Match container docker group GID to host docker socket GID

if [ -S /var/run/docker.sock ]; then
    DOCKER_SOCK_GID=$(stat -c '%g' /var/run/docker.sock)
    echo "Docker socket found with GID: ${DOCKER_SOCK_GID}"

    if ! getent group "${DOCKER_SOCK_GID}" > /dev/null 2>&1; then
        groupadd -g "${DOCKER_SOCK_GID}" docker-host
    fi

    GROUP_NAME=$(getent group "${DOCKER_SOCK_GID}" | cut -d: -f1)
    echo "Docker group: ${GROUP_NAME} (GID ${DOCKER_SOCK_GID})"
else
    echo "Warning: Docker socket not found at /var/run/docker.sock"
fi
