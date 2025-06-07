FROM alpine:latest

# Install essential tools for a bastion host
RUN apk add --no-cache \
    bash \
    curl \
    wget \
    git \
    vim \
    htop \
    ncurses \
    openssh-client \
    netcat-openbsd \
    bind-tools \
    jq \
    tmux \
    ripgrep \
    fd \
    bat \
    exa \
    fish \
    zsh \
    shadow

# Create a non-root user (optional, Railway SSH already provides root)
RUN adduser -D -s /bin/bash bastion && \
    echo "bastion:bastion" | chpasswd

# Set up a nice shell prompt
RUN echo 'export PS1="\[\033[01;32m\]\u@bastion\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ "' >> /root/.bashrc && \
    echo 'export PS1="\[\033[01;32m\]\u@bastion\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ "' >> /home/bastion/.bashrc

# Keep container running
CMD ["tail", "-f", "/dev/null"]