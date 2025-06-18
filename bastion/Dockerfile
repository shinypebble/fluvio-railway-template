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

# Set up shell prompt
RUN echo 'export PS1="\[\033[01;32m\]\u@bastion\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ "' >> /root/.bashrc

# Keep container running
CMD ["tail", "-f", "/dev/null"]