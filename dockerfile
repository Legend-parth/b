# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

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
RUN useradd -m appuser && \
    usermod -aG docker appuser

# Switch to non-root user (if Railway allows it)
USER appuser

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set the startup command
CMD ["/start.sh"]
