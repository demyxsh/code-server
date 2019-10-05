FROM alpine

LABEL sh.demyx.image demyx/code-server
LABEL sh.demyx.maintainer Demyx <info@demyx.sh>
LABEL sh.demyx.url https://demyx.sh
LABEL sh.demyx.github https://github.com/demyxco/demyx
LABEL sh.demyx.registry https://hub.docker.com/u/demyx

ENV TZ America/Los_Angeles
ENV PASSWORD=demyx

# Install custom packages
RUN set -ex; \
    apk add --update --no-cache \
    gcc \
    bash \
    zsh \
    jq \
    htop \
    nano \
    tzdata \
    gnupg \
    git \
    sudo \
    curl \
    openssh \
    util-linux \
    dumb-init

# Download Alpine binary of code-server
RUN set -ex; \
    wget https://github.com/cdr/code-server/releases/download/2.1523-vsc1.38.1/code-server2.1523-vsc1.38.1-alpine-x86_64.tar.gz -qO /tmp/code-server2.1523-vsc1.38.1-alpine-x86_64.tar.gz; \
    tar -xzf /tmp/code-server2.1523-vsc1.38.1-alpine-x86_64.tar.gz -C /tmp; \
    mv /tmp/code-server2.1523-vsc1.38.1-alpine-x86_64/code-server /usr/local/bin; \
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

# Create and configure demyx user
RUN set -ex; \
    addgroup -g 1000 -S demyx; \
    adduser -u 1000 -D -S -G demyx demyx; \
    echo demyx:demyx | chpasswd; \
    sed -i "s|/home/demyx:/sbin/nologin|/home/demyx:/bin/zsh|g" /etc/passwd; \
    mkdir -p /home/demyx/.code/data/User; \
    echo -e "{\n    \"terminal.integrated.shell.linux\": \"/bin/zsh\"\n}" > /home/demyx/.code/data/User/settings.json; \
    echo "demyx ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

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

COPY demyx-entrypoint.sh /usr/local/bin/demyx-entrypoint

# Sudo wrapper for demyx executable so demyx user doesn't have to type sudo on each demyx command
RUN set -ex; \
    echo '#!/bin/bash' >> /usr/local/bin/demyx; \
    echo 'sudo /demyx/etc/demyx.sh "$@"' >> /usr/local/bin/demyx; \
    chmod +x /usr/local/bin/demyx; \
    \
    chmod +x /usr/local/bin/demyx-entrypoint

EXPOSE 8080

USER demyx

WORKDIR /home/demyx

ENTRYPOINT ["dumb-init", "demyx-entrypoint"]
