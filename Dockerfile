# Docker + NemoClaw Development Container
# Node.js 22 base with Docker CLI and NemoClaw pre-installed

FROM node:22-bookworm-slim

WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    gnupg \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    build-essential \
    python3-pip \
    socat \
    && rm -rf /var/lib/apt/lists/*

# Install Docker CLI
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli docker-compose-plugin && \
    rm -rf /var/lib/apt/lists/*

# Install NemoClaw CLI
RUN curl -fsSL https://www.nvidia.com/nemoclaw.sh | bash

# Set up Docker socket permissions at runtime
COPY docker-setup.sh /usr/local/bin/docker-setup.sh
RUN chmod +x /usr/local/bin/docker-setup.sh

EXPOSE 8080

CMD ["bash"]
