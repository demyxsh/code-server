FROM quay.io/vektorlab/ctop:0.7.1 as demyx_ctop
FROM docker as demyx_docker
FROM alpine

LABEL sh.demyx.image        demyx/code-server:alpine
LABEL sh.demyx.maintainer   Demyx <info@demyx.sh>
LABEL sh.demyx.url          https://demyx.sh
LABEL sh.demyx.github       https://github.com/demyxsh
LABEL sh.demyx.registry     https://hub.docker.com/u/demyx

# Set default variables
ENV CODE_ROOT       /demyx
ENV CODE_CONFIG     /etc/demyx
ENV CODE_LOG        /var/log/demyx
ENV CODE_VERSION    2.1698
ENV CODE_BINARY     2.1698-vsc1.41.1
ENV PASSWORD        demyx
ENV TZ              America/Los_Angeles

# Configure Demyx
RUN set -ex; \
    addgroup -g 1000 -S demyx; \
    adduser -u 1000 -D -S -G demyx demyx; \
    \
    install -d -m 0755 -o demyx -g demyx "$CODE_ROOT"; \
    install -d -m 0755 -o demyx -g demyx "$CODE_CONFIG"; \
    install -d -m 0755 -o demyx -g demyx "$CODE_LOG"

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
    # Copy .zshrc to config directory
    cp /home/demyx/.zshrc "$CODE_CONFIG"

# Copy binaries
COPY --from=demyx_ctop /ctop /usr/local/bin/ctop-bin
COPY --from=demyx_docker /usr/local/bin/docker /usr/local/bin/docker-bin

# Configure code-server
RUN set -ex; \
    # Define layer variables
    #CODE_BINARY=$(curl -sL https://api.github.com/repos/cdr/code-server/releases/latest | grep '"name"' | head -n1 | awk -F '[:]' '{print $2}' | sed -e 's/"//g' | sed -e 's/,//g' | sed -e 's/ //g' | sed -e 's/\r//g'); \
    #CODE_VERSION="$(echo "$CODE_BINARY" | awk -F '[-]' '{print $1}')"; \
    # Set fixed version as a fallback if curling fails
    #if [ -z "$CODE_BINARY" ]; then CODE_BINARY=2.1698-vsc1.41.1; fi; \
    #\
    # Fetch code-server binary
    wget https://github.com/cdr/code-server/releases/download/"$CODE_VERSION"/code-server"$CODE_BINARY"-alpine-x86_64.tar.gz -qO /tmp/code-server"$CODE_BINARY"-alpine-x86_64.tar.gz; \
    tar -xzf /tmp/code-server"$CODE_BINARY"-alpine-x86_64.tar.gz -C /tmp; \
    mv /tmp/code-server"$CODE_BINARY"-alpine-x86_64/code-server /usr/local/bin; \
    \
    # Create code-server user directories
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/extensions; \
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/data/User; \
    \
    # Get settings.json
    curl -sL https://github.com/demyxsh/code-server/raw/master/shared/settings.json -o /home/demyx/.code/data/User/settings.json; \
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
    \
    # Clean /tmp
    rm -rf /tmp/*

# Finalize
RUN set -ex; \
    # Support for demyx container
    echo '#!/bin/bash' >> /usr/local/bin/demyx; \
    echo 'docker exec -it demyx demyx "$@"' >> /usr/local/bin/demyx; \
    chmod +x /usr/local/bin/demyx; \
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
    # demyx-entrypoint
    curl -sL https://github.com/demyxsh/code-server/raw/master/shared/entrypoint.sh -o /usr/local/bin/demyx-entrypoint; \
    chmod +x /usr/local/bin/demyx-entrypoint; \
    \
    # Set ownership
    chown -R root:root /usr/local/bin

EXPOSE 8080

WORKDIR /home/demyx

USER demyx

ENTRYPOINT ["demyx-entrypoint"]

CMD ["code-server", "/home/demyx", "--user-data-dir=/home/demyx/.code/data", "--extensions-dir=/home/demyx/.code/extensions", "--disable-telemetry"]
