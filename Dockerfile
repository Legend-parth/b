FROM ubuntu:20.04

# Set timezone to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

# Install dependencies
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    git \
    nano \
    neofetch \
    sudo \
    docker.io \ 
    docker-compose

RUN rm -rf /var/lib/apt/lists/*

# Install sshx.io
RUN curl -sSf https://sshx.io/get | sh

# Configure non-root user
RUN adduser --disabled-password --gecos "" user && \
    echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    usermod -aG docker user

# Switch to non-root user
USER user
WORKDIR /home/user

# Start Docker service + SSHX terminal
CMD ["sh", "-c", "sudo dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 & sleep 5; sshx"]
CMD cd ~ && sshx -q

