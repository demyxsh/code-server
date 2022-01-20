FROM demyx/openlitespeed:bedrock

LABEL sh.demyx.image        demyx/code-server:openlitespeed-sage
LABEL sh.demyx.maintainer   Demyx <info@demyx.sh>
LABEL sh.demyx.url          https://demyx.sh
LABEL sh.demyx.github       https://github.com/demyxsh
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
    npm \
    net-tools \
    openssh-client \
    unzip \
    util-linux \
    wget \
    zsh; \
    \
    npm -g install yarn; \
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
    "$CODE_PHP"-mbstring \
    "$CODE_PHP"-mysql \
    "$CODE_PHP"-xml \
    "$CODE_PHP"-zip; \
    \
    rm -rf /var/lib/apt/lists/*

# Composer
RUN set -ex; \
    curl -sL https://getcomposer.org/installer -o /tmp/composer-setup.php; \
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Install Sage
RUN set ex; \
    su -c 'composer create-project -n roots/sage "$OPENLITESPEED_CONFIG"/sage; \
        \
        yarn --cwd="$OPENLITESPEED_CONFIG"/sage; \
        yarn --cwd="$OPENLITESPEED_CONFIG"/sage build; \
        yarn cache clean; \
        \
        composer clearcache; \
        \
        tar -czf "$OPENLITESPEED_CONFIG"/sage.tgz -C "$OPENLITESPEED_CONFIG" sage; \
        \
        rm -rf "$OPENLITESPEED_CONFIG"/sage' -s /bin/sh demyx

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
    echo 'export GPG_TTY=$(tty)' >> /home/demyx/.zshrc; \
    \
    # Copy .zshrc to config directory
    cp /home/demyx/.zshrc "$OPENLITESPEED_CONFIG"; \
    \
    # Disable sudo warnings for now
    echo "Set disable_coredump false" > /etc/sudo.conf

# wp-cli
RUN set -ex; \
    curl -s https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp; \
    chmod +x /usr/local/bin/wp

# Copy source & binary
COPY --chown=demyx:demyx src "$OPENLITESPEED_CONFIG"
# Add shared files
ADD --chown=demyx:demyx https://github.com/demyxsh/code-server/raw/master/shared/"$CODE_ICONS" "$OPENLITESPEED_CONFIG"
ADD --chown=demyx:demyx https://github.com/demyxsh/code-server/raw/master/shared/bs-sage.js "$OPENLITESPEED_CONFIG"/bs.js
ADD --chown=demyx:demyx https://github.com/demyxsh/code-server/raw/master/shared/bs-sage.php "$OPENLITESPEED_CONFIG"/bs.php
ADD --chown=demyx:demyx https://github.com/demyxsh/code-server/raw/master/shared/settings-sage.json "$OPENLITESPEED_CONFIG"/settings.json
ADD --chown=demyx:demyx https://github.com/demyxsh/code-server/raw/master/shared/sage.sh "$OPENLITESPEED_CONFIG"

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
    # Get remote files
    curl -sL https://github.com/demyxsh/code-server/raw/master/shared/bs-sage.js -o "$OPENLITESPEED_CONFIG"/bs.js; \
    curl -sL https://github.com/demyxsh/code-server/raw/master/shared/bs-sage.php -o "$OPENLITESPEED_CONFIG"/bs.php; \
    curl -sL https://github.com/demyxsh/code-server/raw/master/shared/settings-sage.json -o /home/demyx/.code/data/User/settings.json; \
    \
    # Symlink code-server
    ln -s /usr/local/lib/code-server/bin/code-server /usr/local/bin/code-server; \
    \
    # Install default extensions
    code-server --extensions-dir=/home/demyx/.code/extensions \
    --install-extension=cjhowe7.laravel-blade \
    --install-extension=equinusocio.vsc-material-theme \
    --install-extension=pkief.material-icon-theme; \
    \
    # Set ownership
    chown -R demyx:demyx /home/demyx/.code; \
    chown -R demyx:demyx "$OPENLITESPEED_CONFIG"; \
    \
    # Make a copy to demyx config directory
    cp -rp /home/demyx/.code "$OPENLITESPEED_CONFIG"/code

# Finalize
RUN set -ex; \
    # sage
    curl -sL https://github.com/demyxsh/code-server/raw/master/shared/sage.sh -o /usr/local/bin/sage.sh; \
    chmod +x /usr/local/bin/sage.sh; \
    \
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
