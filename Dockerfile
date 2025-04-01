FROM ubuntu:20.04

# Install dependencies (Use proper line continuation with \)
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    git \
    nano \
    neofetch \
    sudo \
    docker.io \ 
    docker-compose 
    && rm -rf /var/lib/apt/lists/*

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
CMD ["sh", "-c", "sudo service docker start && sshx"]
