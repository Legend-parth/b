# Use official Docker-in-Docker (Dind) image
FROM docker:dind

# Install dependencies (Alpine uses apk, not apt)
RUN apk add --no-cache \
    bash \
    curl \
    git \
    nano \
    sudo \
    docker-compose \
    shadow  # For user management

# Install neofetch from community repo
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk add --no-cache neofetch

# Install SSHX terminal
RUN curl -sSf https://sshx.io/get | sh

# Create non-root user
RUN useradd -m user && \
    echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    adduser user docker

# Switch to non-root user
USER user
WORKDIR /home/user

# Start Docker daemon + SSHX web terminal
CMD ["sh", "-c", "sudo dockerd >/dev/null 2>&1 & sleep 5; sshx"]
