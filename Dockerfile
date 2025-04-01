# Use Ubuntu 22.04 as the base image
FROM docker:dind

# Install system dependencies + Docker + your tools
RUN apt update && \
    apt install -y \
      wget curl nano git neofetch \
      docker.io docker-compose \
      uidmap fuse-overlayfs && \
    # Install rootless Docker tools (optional, but safer)
    curl -fsSL https://get.docker.com/rootless | sh && \
    # Install sshx
    curl -sSf https://sshx.io/get | sh

# Set up Docker environment variables
ENV DOCKER_HOST=unix:///var/run/docker.sock
ENV PATH=/home/rootless/bin:$PATH

# Create a non-root user (recommended for Railway)
RUN adduser -D user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to non-root user (if Railway allows it)
USER appuser

# Start Docker daemon + SSHX web terminal
CMD ["sh", "-c", "sudo dockerd & sshx"]
