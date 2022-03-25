FROM quay.io/vektorlab/ctop as demyx_ctop
FROM docker as demyx_docker
FROM koalaman/shellcheck as demyx_shellcheck
FROM debian:buster-slim

LABEL sh.demyx.image        demyx/code-server
LABEL sh.demyx.maintainer   Demyx <info@demyx.sh>
LABEL sh.demyx.url          https://demyx.sh
LABEL sh.demyx.github       https://github.com/demyxsh
LABEL sh.demyx.registry     https://hub.docker.com/u/demyx

# Set default variables
ENV DEMYX                   /demyx
ENV DEMYX_CODE_AUTH         password
ENV DEMYX_CODE_BIND_ADDR    0.0.0.0:8080
ENV DEMYX_CODE_CONFIG       /home/demyx/.config/code-server
ENV DEMYX_CODE_PASSWORD     demyx
ENV DEMYX_CONFIG            /etc/demyx
ENV DEMYX_LOG               /var/log/demyx
ENV DOCKER_HOST             tcp://demyx_socket:2375
ENV TERM                    xterm-256color
ENV TZ                      America/Los_Angeles
# Support for old variables
ENV CODE_ROOT               "$DEMYX"
ENV CODE_CONFIG             "$DEMYX_CONFIG"
ENV CODE_LOG                "$DEMYX_LOG"

# Packages
RUN set -ex; \
    apt-get update && apt-get install -y --no-install-recommends \
    bash \
    build-essential \
    bsdmainutils \
    ca-certificates \
    curl \
    dnsutils \
    git \
    gnupg \
    htop \
    iputils-ping \
    jq \
    less \
    nano \
    net-tools \
    openssh-client \
    procps \
    sudo \
    tzdata \
    unzip \
    util-linux \
    wget \
    zsh

# Configure Demyx
RUN set -ex; \
    # Create demyx user
    adduser --gecos '' --disabled-password demyx; \
    \
    # Update .bashrc
    echo 'PS1="$(whoami)@\h:\w \$ "' > /home/demyx/.bashrc; \
    echo 'PS1="$(whoami)@\h:\w \$ "' > /root/.bashrc; \
    \
    # Create demyx directories
    install -d -m 0755 -o demyx -g demyx "$DEMYX"; \
    install -d -m 0755 -o demyx -g demyx "$DEMYX_CONFIG"; \
    install -d -m 0755 -o demyx -g demyx "$DEMYX_LOG"; \
    \
    # Oh-My-Zsh
    su -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" -s /bin/sh demyx; \
    su -c "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/demyx/.oh-my-zsh/custom/themes/powerlevel10k" -s /bin/sh demyx; \
    su -c "git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/demyx/.oh-my-zsh/custom/plugins/zsh-autosuggestions" -s /bin/sh demyx; \
    su -c "git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins.git /home/demyx/.oh-my-zsh/custom/plugins/autoupdate" -s /bin/sh demyx; \
    sed -i 's|source $ZSH/oh-my-zsh.sh|source "$DEMYX_CONFIG"/.demyxrc\nsource $ZSH/oh-my-zsh.sh|g' /home/demyx/.zshrc; \
    \
    # Change user shell
    sed -i "s|/home/demyx.*|/home/demyx:/bin/zsh|g" /etc/passwd

# Imports
COPY --from=demyx_ctop /ctop /usr/local/bin/ctop
COPY --from=demyx_docker /usr/local/bin/docker /usr/local/bin/docker
COPY --from=demyx_shellcheck /bin/shellcheck /usr/local/bin/shellcheck
COPY --chown=root:root bin /usr/local/bin
COPY --chown=demyx:demyx config "$DEMYX_CONFIG"

# Configure code-server
RUN set -ex; \
    # Get code-server
    CODE_VERSION="$(curl -sL https://api.github.com/repos/cdr/code-server/releases/latest | jq -r .tag_name)"; \
    CODE_VERSION_NUMBER="$(echo "$CODE_VERSION" | sed 's|v||g')"; \
    curl -sL https://github.com/cdr/code-server/releases/download/"$CODE_VERSION"/code-server-"$CODE_VERSION_NUMBER"-linux-amd64.tar.gz -o /tmp/code-server-"$CODE_VERSION"-linux-amd64.tar.gz; \
    tar -xzf /tmp/code-server-"$CODE_VERSION"-linux-amd64.tar.gz -C /tmp; \
    mv /tmp/code-server-"$CODE_VERSION_NUMBER"-linux-amd64 /usr/local/lib/code-server; \
    \
    # Create code-server directories
    install -d -m 0755 -o demyx -g demyx "$DEMYX_CODE_CONFIG"/data/User; \
    install -d -m 0755 -o demyx -g demyx "$DEMYX_CODE_CONFIG"/extensions; \
    \
    # Copy settings.json
    cp "$DEMYX_CONFIG"/settings.json "$DEMYX_CODE_CONFIG"/data/User/settings.json; \
    \
    # Symlink code-server
    ln -s /usr/local/lib/code-server/bin/code-server /usr/local/bin/code-server; \
    \
    # Install default extensions
    code-server --extensions-dir="$DEMYX_CODE_CONFIG"/extensions \
        --install-extension=equinusocio.vsc-material-theme \
        --install-extension=pkief.material-icon-theme \
        --install-extension=remisa.shellman \
        --install-extension=timonwong.shellcheck; \
    \
    # Custom fonts
    cd /usr/local/lib/code-server/src/browser/pages; \
    curl -O "https://demyx.sh/fonts/{meslolgs-nf-regular.woff,meslolgs-nf-bold.woff,meslolgs-nf-italic.woff,meslolgs-nf-bold-italic.woff}"; \
    \
    CODE_WORKBENCH="$(find /usr/local/lib/code-server -name "*workbench.html")"; \
    sed -i "s|</head>|\
    <style> \n\
        @font-face { \n\
        font-family: 'MesloLGS NF'; \n\
        font-style: normal; \n\
        src: url('_static/src/browser/pages/meslolgs-nf-regular.woff') format('woff'), \n\
        url('_static/src/browser/pages/meslolgs-nf-bold.woff') format('woff'), \n\
        url('_static/src/browser/pages/meslolgs-nf-italic.woff') format('woff'), \n\
        url('_static/src/browser/pages/meslolgs-nf-bold-italic.woff') format('woff'); \n\
    } \n\
    \n\</style></head>|g" "$CODE_WORKBENCH"; \
    \
    # Finalize code-server
    chown -R demyx:demyx "$DEMYX_CODE_CONFIG"; \
    chown -R demyx:demyx "$DEMYX_CONFIG"; \
    cp -rp "$DEMYX_CODE_CONFIG" "$DEMYX_CONFIG"

# Finalize
RUN set -ex; \
    # ctop 
    cp "$DEMYX_CONFIG"/ctop /home/demyx/.ctop; \
    \
    # sudo
    echo "demyx ALL=(ALL) NOPASSWD: /usr/bin/apt" > /etc/sudoers.d/demyx; \
    \
    # Set ownership
    chown -R root:root /usr/local/bin; \
    \
    # Cleanup
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/*

EXPOSE 8080

WORKDIR /home/demyx

USER demyx

ENTRYPOINT ["demyx-entrypoint"]
