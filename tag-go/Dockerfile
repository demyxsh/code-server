FROM codercom/code-server:3.2.0 as demyx_cs
FROM quay.io/vektorlab/ctop:0.7.1 as demyx_ctop
FROM golang:buster as demyx_go
FROM docker as demyx_docker
FROM debian:buster-slim

LABEL sh.demyx.image        demyx/code-server:go
LABEL sh.demyx.maintainer   Demyx <info@demyx.sh>
LABEL sh.demyx.url          https://demyx.sh
LABEL sh.demyx.github       https://github.com/demyxco
LABEL sh.demyx.registry     https://hub.docker.com/u/demyx

# Set default variables
ENV CODE_ROOT    /demyx
ENV CODE_CONFIG  /etc/demyx
ENV CODE_LOG     /var/log/demyx
ENV PASSWORD            demyx
ENV PATH                "$PATH":/usr/local/go/bin
ENV TZ                  America/Los_Angeles

# Configure Demyx
RUN set -ex; \
    adduser --gecos '' --disabled-password demyx; \
    \
    install -d -m 0755 -o demyx -g demyx "$CODE_ROOT"; \
    install -d -m 0755 -o demyx -g demyx "$CODE_CONFIG"; \
    install -d -m 0755 -o demyx -g demyx "$CODE_LOG"

# Install dependencies 
RUN set -ex; \
    apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    dumb-init \
    gcc \
    git \
    gnupg \
    htop \
    jq \
    less \
    nano \
    net-tools \
    openssh-client \
    sudo \
    tzdata \
    util-linux \
    zsh; \
    \
    rm -rf /var/lib/apt/lists/*

# Set up user
RUN set -ex; \
    sed -i "s|/home/demyx:/sbin/nologin|/home/demyx:/bin/zsh|g" /etc/passwd; \
    echo "demyx ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/demyx; \
    \
    # Oh My Zsh!
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
    # Change root shell
    sed -i "s|/root:/bin/bash|/root:/bin/zsh|g" /etc/passwd; \
    \
    # gpg purposes
    echo 'export GPG_TTY=$(tty)' >> /root/.zshrc; \
    echo 'export GPG_TTY=$(tty)' >> /home/demyx/.zshrc; \
    \
    # Disable sudo warnings for now
    echo "Set disable_coredump false" > /etc/sudo.conf

# Copy binaries
COPY --from=demyx_ctop /ctop /usr/local/bin/ctop-bin
COPY --from=demyx_cs /usr/local/lib/code-server /usr/local/lib/code-server
COPY --from=demyx_docker /usr/local/bin/docker /usr/local/bin/docker-bin
COPY --from=demyx_go /usr/local/go /usr/local/go

# Configure code-server
RUN set -ex; \
    # Create code-server directories
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/extensions; \
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/data/User; \
    \
    # Get settings.json
    curl -sL https://github.com/demyxco/code-server/raw/master/shared/settings.json -o /home/demyx/.code/data/User/settings.json; \
    \
    # Symlink code-server
    ln -s /usr/local/lib/code-server/code-server /usr/local/bin/code-server; \
    \
    # Install default extensions
    code-server --extensions-dir=/home/demyx/.code/extensions \
    --install-extension=equinusocio.vsc-material-theme \
    --install-extension=pkief.material-icon-theme \
    --install-extension=ms-vscode.go; \
    \
    # Set ownership
    chown -R demyx:demyx /home/demyx/.code

# Finalize
RUN set -ex; \
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
    # demyx-entrypoint
    curl -sL https://github.com/demyxco/code-server/raw/master/shared/entrypoint.sh -o /usr/local/bin/demyx-entrypoint; \
    chmod +x /usr/local/bin/demyx-entrypoint; \
    \
    # Set ownership
    chown -R root:root /usr/local/bin

EXPOSE 8080

WORKDIR /home/demyx

USER demyx

ENTRYPOINT ["demyx-entrypoint"]

CMD ["code-server", "/home/demyx", "--bind-addr=0.0.0.0:8080", "--user-data-dir=/home/demyx/.code/data", "--extensions-dir=/home/demyx/.code/extensions", "--disable-telemetry", "--disable-updates"]
