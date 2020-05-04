FROM codercom/code-server:3.2.0 as demyx_cs
FROM demyx/openlitespeed

LABEL sh.demyx.image        demyx/code-server:openlitespeed
LABEL sh.demyx.maintainer   Demyx <info@demyx.sh>
LABEL sh.demyx.url          https://demyx.sh
LABEL sh.demyx.github       https://github.com/demyxco
LABEL sh.demyx.registry     https://hub.docker.com/u/demyx

ENV CODE_PHP     php7.4

# Run as root for now
USER root

# Packages 
RUN set -ex; \
    apt-get update && apt-get install -y --no-install-recommends \
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
    util-linux \
    wget \
    zsh; \
    \
    apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    lsb-release; \
    \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg; \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list; \
    apt-get update && apt-get install -y --no-install-recommends \
    "$CODE_PHP" \
    "$CODE_PHP"-mysql; \
    \
    rm -rf /var/lib/apt/lists/*

# Oh-My-Zsh
RUN set -ex; \
    sed -i "s|/home/demyx:/sbin/nologin|/home/demyx:/bin/zsh|g" /etc/passwd; \
    echo "demyx ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/demyx; \
    \
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
    echo 'export GPG_TTY=$(tty)' >> /home/demyx/.zshrc

# wp-cli
RUN set -ex; \
    curl -s https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp; \
    chmod +x /usr/local/bin/wp

# Copy source & binary
COPY --chown=demyx:demyx src "$OPENLITESPEED_CONFIG"
COPY --from=demyx_cs /usr/local/lib/code-server /usr/local/lib/code-server

# Configure code-server
RUN set -ex; \
    # Create code-server directories
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/extensions; \
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/data/User; \
    \
    # Get remote files
    curl -sL https://github.com/demyxco/code-server/raw/master/shared/bs.php -o "$OPENLITESPEED_CONFIG"/bs.php; \
    curl -sL https://github.com/demyxco/code-server/raw/master/shared/settings-wp.json -o /home/demyx/.code/data/User/settings.json; \
    \
    # Symlink code-server
    ln -s /usr/local/lib/code-server/code-server /usr/local/bin/code-server; \
    \
    # Install default extensions
    code-server --extensions-dir=/home/demyx/.code/extensions \
    --install-extension=equinusocio.vsc-material-theme \
    --install-extension=pkief.material-icon-theme; \
    \
    # Set ownership
    chown -R demyx:demyx /home/demyx/.code

# Finalize
RUN set -ex; \
    # demyx-install
    chmod +x "$OPENLITESPEED_CONFIG"/install.sh; \
    mv "$OPENLITESPEED_CONFIG"/install.sh /usr/local/bin/demyx-install; \
    \
    # demyx-entrypoint
    chmod +x "$OPENLITESPEED_CONFIG"/entrypoint.sh; \
    mv "$OPENLITESPEED_CONFIG"/entrypoint.sh /usr/local/bin/demyx-entrypoint; \
    \
    # Set ownership
    chown -R root:root /usr/local/bin

# Expose code-server port
EXPOSE 80 8080 8081

# Set back to demyx
USER demyx
