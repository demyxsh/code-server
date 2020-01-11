FROM quay.io/vektorlab/ctop:0.7.1 as demyx_ctop
FROM docker as demyx_docker
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
ENV TERM=linux
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
    libc-dev \
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

# Set default code-server user setting
COPY --chown=demyx:demyx settings.json /home/demyx/.code/data/User/settings.json
# Copy entrypoint
COPY demyx.sh /usr/local/bin/demyx-cs
# ctop
COPY --from=demyx_ctop /ctop /usr/local/bin/ctop-bin
# docker
COPY --from=demyx_docker /usr/local/bin/docker /usr/local/bin/docker-bin

# Finalize
RUN set -ex; \
    # Setup code-server
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/extensions; \
    su -c 'code-server --extensions-dir=/home/demyx/.code/extensions \
        --install-extension=equinusocio.vsc-material-theme \
        --install-extension=pkief.material-icon-theme \
        --force' -s /bin/sh demyx; \
    \
    # ctop
    echo '#!/bin/bash' >> /usr/local/bin/ctop; \
    echo 'sudo ctop-bin' >> /usr/local/bin/ctop; \
    chmod +x /usr/local/bin/ctop; \
    \
    # docker
    echo '#!/bin/bash' >> /usr/local/bin/docker; \
    echo 'sudo docker-bin "$@"' >> /usr/local/bin/docker; \
    chmod +x /usr/local/bin/docker; \
    \
    # Disable sudo warnings for now
    echo "Set disable_coredump false" > /etc/sudo.conf; \
    \
    chmod +x /usr/local/bin/demyx-cs

EXPOSE 8080

WORKDIR /home/demyx

USER demyx

ENTRYPOINT ["dumb-init", "demyx-cs"]

CMD ["code-server", "/home/demyx", "--user-data-dir=/home/demyx/.code/data", "--extensions-dir=/home/demyx/.code/extensions", "--disable-telemetry"]
