FROM quay.io/vektorlab/ctop:0.7.1 as demyx_ctop
FROM alpine

LABEL sh.demyx.image demyx/code-server:alpine
LABEL sh.demyx.maintainer Demyx <info@demyx.sh>
LABEL sh.demyx.url https://demyx.sh
LABEL sh.demyx.github https://github.com/demyxco
LABEL sh.demyx.registry https://hub.docker.com/u/demyx

# Set default variables
ENV CODE_SERVER_ROOT=/demyx
ENV CODE_SERVER_CONFIG=/etc/demyx
ENV CODE_SERVER_LOG=/var/log/demyx
ENV PASSWORD=demyx
ENV TZ America/Los_Angeles

# Install custom packages
RUN set -ex; \
    apk add --update --no-cache \
    bash \
    bind-tools \
    curl \
    dumb-init \
    gcc \
    git \
    gnupg \
    htop \
    jq \
    nano \
    openssh \
    sudo \
    tzdata \
    util-linux \
    zsh

# Configure Demyx
RUN set -ex; \
    addgroup -g 1000 -S demyx; \
    adduser -u 1000 -D -S -G demyx demyx; \
    echo demyx:demyx | chpasswd; \
    sed -i "s|/home/demyx:/sbin/nologin|/home/demyx:/bin/zsh|g" /etc/passwd; \
    echo "demyx ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/demyx; \
    \
    install -d -m 0755 -o demyx -g demyx "$CODE_SERVER_ROOT"; \
    install -d -m 0755 -o demyx -g demyx "$CODE_SERVER_CONFIG"; \
    install -d -m 0755 -o demyx -g demyx "$CODE_SERVER_LOG"

# Oh-My-Zsh
RUN set -ex; \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"; \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git /root/.oh-my-zsh/plugins/zsh-autosuggestions; \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' /root/.zshrc; \
    sed -i "s/(git)/(git zsh-autosuggestions)/g" /root/.zshrc; \
    \
    su -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" -s /bin/sh demyx; \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/demyx/.oh-my-zsh/plugins/zsh-autosuggestions; \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' /home/demyx/.zshrc; \
    sed -i "s/(git)/(git zsh-autosuggestions)/g" /home/demyx/.zshrc; \
    \
    # Symlink demyx command history with root
    ln -s /home/demyx/.zsh_history /root; \
    \
    # gpg purposes
    echo 'export GPG_TTY=$(tty)' >> /root/.zshrc; \
    echo 'export GPG_TTY=$(tty)' >> /home/demyx/.zshrc; \
    \
    chown -R demyx:demyx /home/demyx

# Download Alpine binary of code-server
RUN set -ex; \
    export DEMYX_CODER_BINARY=$(curl -sL https://api.github.com/repos/cdr/code-server/releases/latest | grep '"name"' | head -n1 | awk -F '[:]' '{print $2}' | sed -e 's/"//g' | sed -e 's/,//g' | sed -e 's/ //g' | sed -e 's/\r//g'); \
    # Set fixed version as a fallback if curling fails
    if [ -z "$DEMYX_CODER_BINARY" ]; then export DEMYX_CODER_BINARY=2.1650-vsc1.39.2; fi; \
    wget https://github.com/cdr/code-server/releases/download/"$DEMYX_CODER_BINARY"/code-server"$DEMYX_CODER_BINARY"-alpine-x86_64.tar.gz -qO /tmp/code-server"$DEMYX_CODER_BINARY"-alpine-x86_64.tar.gz; \
    tar -xzf /tmp/code-server"$DEMYX_CODER_BINARY"-alpine-x86_64.tar.gz -C /tmp; \
    mv /tmp/code-server"$DEMYX_CODER_BINARY"-alpine-x86_64/code-server /usr/local/bin; \
    rm -rf /tmp/*

# Download latest Docker client binary
RUN set -ex; \
    export DEMYX_DOCKER_BINARY=$(curl -sL https://api.github.com/repos/docker/docker-ce/releases/latest | grep '"name":' | awk -F '[:]' '{print $2}' | sed -e 's/"//g' | sed -e 's/,//g' | sed -e 's/ //g' | sed -e 's/\r//g'); \
    # Set fixed version as a fallback if curling fails
    if [ -z "$DEMYX_DOCKER_BINARY" ]; then export DEMYX_DOCKER_BINARY=18.09.9; fi; \
    wget https://download.docker.com/linux/static/stable/x86_64/docker-"$DEMYX_DOCKER_BINARY".tgz -qO /tmp/docker-"$DEMYX_DOCKER_BINARY".tgz; \
    tar -xzf /tmp/docker-"$DEMYX_DOCKER_BINARY".tgz -C /tmp; \
    mv /tmp/docker/docker /usr/local/bin/docker-bin; \
    # sudo wrapper for Docker binary
    echo '#!/bin/bash' >> /usr/local/bin/docker; \
    echo 'sudo /usr/local/bin/docker-bin "$@"' >> /usr/local/bin/docker; \
    chmod +x /usr/local/bin/docker; \
    rm -rf /tmp/*

# Set default code-server user setting
COPY --chown=demyx:demyx settings.json /home/demyx/.code/data/User/settings.json
# Copy entrypoint
COPY demyx.sh /usr/local/bin/demyx-cs
# ctop
COPY --from=demyx_ctop /ctop /usr/local/bin/ctop-bin

# Wrappers
RUN set -ex; \
    echo '#!/bin/bash' >> /usr/local/bin/demyx; \
    echo 'docker exec -it demyx demyx "$@"' >> /usr/local/bin/demyx; \
    chmod +x /usr/local/bin/demyx; \
    \
    echo '#!/bin/bash' >> /usr/local/bin/ctop; \
    echo 'sudo ctop-bin' >> /usr/local/bin/ctop; \
    chmod +x /usr/local/bin/ctop; \
    \
    chmod +x /usr/local/bin/demyx-cs

EXPOSE 8080

WORKDIR /home/demyx

USER demyx

ENTRYPOINT ["dumb-init", "demyx-cs"]
