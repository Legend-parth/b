# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Install dependencies (use apt instead of apk)
RUN apt update && apt install -y \
    bash \
    curl \
    git \
    nano \
    neofetch \
    sudo \
    docker.io \  # Docker for Ubuntu
    docker-compose

# Install sshx.io
RUN curl -sSf https://sshx.io/get | sh

# Configure non-root user
RUN adduser --disabled-password --gecos "" user && \
    echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    usermod -aG docker user  # Add user to Docker group

# Switch to non-root user
USER user
WORKDIR /home/user

# Start Docker service + SSHX terminal
CMD ["sh", "-c", "sudo service docker start && sshx"]
