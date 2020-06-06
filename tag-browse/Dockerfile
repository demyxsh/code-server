FROM quay.io/vektorlab/ctop:0.7.1 as demyx_ctop
FROM docker as demyx_docker
FROM debian:buster-slim

LABEL sh.demyx.image        demyx/code-server:browse
LABEL sh.demyx.maintainer   Demyx <info@demyx.sh>
LABEL sh.demyx.url          https://demyx.sh
LABEL sh.demyx.github       https://github.com/demyxco
LABEL sh.demyx.registry     https://hub.docker.com/u/demyx

# Set default variables
ENV CODE_ROOT       /demyx
ENV CODE_CONFIG     /etc/demyx
ENV CODE_LOG        /var/log/demyx
ENV DOCKER_HOST     tcp://demyx_socket:2375
ENV PASSWORD        demyx
ENV TZ              America/Los_Angeles

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
    wget \
    zsh; \
    \
    rm -rf /var/lib/apt/lists/*

# Set up user
RUN set -ex; \
    sed -i "s|/home/demyx:/sbin/nologin|/home/demyx:/bin/zsh|g" /etc/passwd; \
    \
    # Oh My Zsh!
    su -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" -s /bin/sh demyx; \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/demyx/.oh-my-zsh/plugins/zsh-autosuggestions; \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' /home/demyx/.zshrc; \
    sed -i "s/(git)/(git zsh-autosuggestions)/g" /home/demyx/.zshrc; \
    \
    # gpg purposes
    echo 'export GPG_TTY=$(tty)' >> /home/demyx/.zshrc; \
    \
    # Copy .zshrc to config directory
    cp /home/demyx/.zshrc "$CODE_CONFIG"; \
    \
    # Symlink /demyx to user's home
    ln -s "$CODE_ROOT" /home/demyx/demyx

# Configure sudo
RUN set -ex; \
    echo "demyx ALL=(ALL) NOPASSWD: /usr/local/bin/demyx-chown" > /etc/sudoers.d/demyx; \
    \
    echo '#!/bin/bash' > /usr/local/bin/demyx-chown; \
    echo 'chown -R demyx:demyx /home/demyx' >> /usr/local/bin/demyx-chown; \
    chmod +x /usr/local/bin/demyx-chown; \
    \
    # Supresses the sudo warning for now
    echo "Set disable_coredump false" > /etc/sudo.conf

# Copy binaries
COPY src "$CODE_CONFIG"
COPY --from=demyx_ctop /ctop /usr/local/bin/ctop
COPY --from=demyx_docker /usr/local/bin/docker /usr/local/bin/docker

# Configure code-server
RUN set -ex; \
    # Get code-server
    CODE_VERSION=$(curl -sL https://api.github.com/repos/cdr/code-server/releases/latest | grep '"name"' | head -1 | awk -F '[:]' '{print $2}' | sed -e 's/"//g' | sed -e 's/,//g' | sed -e 's/ //g' | sed -e 's/\r//g'); \
    CODE_VERSION_NUMBER="$(echo "$CODE_VERSION" | sed 's|v||g')"; \
    curl -sL https://github.com/cdr/code-server/releases/download/"$CODE_VERSION"/code-server-"$CODE_VERSION_NUMBER"-linux-amd64.tar.gz -o /tmp/code-server-"$CODE_VERSION"-linux-amd64.tar.gz; \         
    tar -xzf /tmp/code-server-"$CODE_VERSION"-linux-amd64.tar.gz -C /tmp; \
    mv /tmp/code-server-"$CODE_VERSION_NUMBER"-linux-amd64 /usr/local/lib/code-server; \
    \
    # Create code-server directories
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/extensions; \
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/data/User; \
    \
    # Get settings.json
    curl -sL https://github.com/demyxco/code-server/raw/master/shared/settings.json -o /home/demyx/.code/data/User/settings.json; \
    \
    # Symlink code-server
    ln -s /usr/local/lib/code-server/bin/code-server /usr/local/bin/code-server; \
    \
    # Install default extensions
    code-server --extensions-dir=/home/demyx/.code/extensions \
    --install-extension=equinusocio.vsc-material-theme \
    --install-extension=pkief.material-icon-theme; \
    \
    # Set ownership
    chown -R demyx:demyx /home/demyx/.code; \
    chown -R demyx:demyx "$CODE_CONFIG"; \
    \
    # Make a copy to demyx config directory
    cp -rp /home/demyx/.code "$CODE_CONFIG"/code

# Finalize
RUN set -ex; \
    # demyx-entrypoint
    mv "$CODE_CONFIG"/entrypoint.sh /usr/local/bin/demyx-entrypoint; \
    chmod +x /usr/local/bin/demyx-entrypoint; \
    \
    # Support for demyx container
    echo '#!/bin/bash' >> /usr/local/bin/demyx; \
    echo 'docker exec -it demyx demyx "$@"' >> /usr/local/bin/demyx; \
    chmod +x /usr/local/bin/demyx; \
    \
    # Set ownership
    chown -R root:root /usr/local/bin

EXPOSE 8080

WORKDIR /home/demyx

USER demyx

ENTRYPOINT ["demyx-entrypoint"]
