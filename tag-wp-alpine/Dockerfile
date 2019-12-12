FROM php:7.3.12-fpm-alpine

LABEL sh.demyx.image demyx/code-server:wp-alpine
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

# Packages
RUN set -ex; \
    apk add --update --no-cache \
    bash \
    curl \
    dumb-init \
    gcc \
    git \
    gnupg \
    htop \
    jq \
    libpng-dev \
    mysql-client \
    nano \
    openssh \
    sudo \
    tzdata \
    util-linux \
    zsh

# Compile
RUN set -ex; \
    apk add --no-cache --virtual .phpize-deps \
        autoconf \
        dpkg-dev dpkg \
        file \
        g++ \
        gcc \
        libc-dev \
        make \
        pkgconf \
        re2c; \
    \
    git clone https://github.com/xdebug/xdebug.git /tmp/xdebug; \
    cd /tmp/xdebug; \
    ./rebuild.sh; \
    rm -rf /tmp/xdebug; \
    \
    # Install additional extensions
    docker-php-ext-install gd mysqli mbstring sockets; \
    \
    apk del --no-network .phpize-deps; \
    rm -vrf /var/cache/apk/*

# Configure Demyx
RUN set -ex; \
    addgroup -g 1000 -S demyx; \
    adduser -u 1000 -D -S -G demyx demyx; \
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
    su -c  "git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/demyx/.oh-my-zsh/plugins/zsh-autosuggestions" -s /bin/sh demyx; \
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

# wp-cli
RUN set -ex; \
    curl -s https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp; \
    chmod +x /usr/local/bin/wp

# Copy files
COPY demyx.sh /usr/local/bin/demyx
COPY --chown=demyx:demyx demyx/. "$CODE_SERVER_CONFIG"

# WordPress
RUN set -ex; \
    curl -sL https://wordpress.org/latest.tar.gz -o /latest.tar.gz; \
    tar -xzf /latest.tar.gz -C "$CODE_SERVER_CONFIG"; \
    rm -f /latest.tar.gz; \
    chown -R demyx:demyx "$CODE_SERVER_CONFIG"

# Finalize
RUN set -ex; \
    # Configure code-server for user
    su -c 'code-server --extensions-dir /home/demyx/.code/extensions --install-extension felixfbecker.php-debug --force' -s /bin/sh demyx; \
    \
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/data/User; \
    mv "$CODE_SERVER_CONFIG"/settings.json /home/demyx/.code/data/User; \
    \
    # Remove php-fpm configs
    rm -f /usr/local/etc/php-fpm.d/*; \
    \
    # Use our php-fpm configs
    ln -s "$CODE_SERVER_CONFIG"/php.ini /usr/local/etc/php/php.ini; \
    ln -sf "$CODE_SERVER_CONFIG"/www.conf /usr/local/etc/php-fpm.d/www.conf; \
    ln -sf "$CODE_SERVER_CONFIG"/docker.conf /usr/local/etc/php-fpm.d/docker.conf; \
    \
    mv "$CODE_SERVER_CONFIG"/config.sh /usr/local/bin/demyx-config && chmod +x /usr/local/bin/demyx-config; \
    mv "$CODE_SERVER_CONFIG"/install.sh /usr/local/bin/demyx-install && chmod +x /usr/local/bin/demyx-install; \
    \
    chmod +x /usr/local/bin/demyx

EXPOSE 8080 9000 9001

WORKDIR "$CODE_SERVER_ROOT"

USER demyx

ENTRYPOINT ["dumb-init", "demyx"]
