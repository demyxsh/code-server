FROM koalaman/shellcheck as demyx_shellcheck
FROM php:8.3-fpm-bookworm

LABEL sh.demyx.image                    demyx/code-server:wp
LABEL sh.demyx.maintainer               Demyx <info@demyx.sh>
LABEL sh.demyx.url                      https://demyx.sh
LABEL sh.demyx.github                   https://github.com/demyxsh
LABEL sh.demyx.registry                 https://hub.docker.com/u/demyx

# Set default variables
ENV DEMYX                               /demyx
ENV DEMYX_BEDROCK                       false
ENV DEMYX_CODE_AUTH                     password
ENV DEMYX_CODE_BIND_ADDR                0.0.0.0:8080
ENV DEMYX_CODE_CONFIG                   /home/demyx/.config/code-server
ENV DEMYX_CODE_PASSWORD                 demyx
ENV DEMYX_CONFIG                        /etc/demyx
ENV DEMYX_CRON                          true
ENV DEMYX_CRON_LOGROTATE_INTERVAL       "0 0 * * *"
ENV DEMYX_CRON_WP_INTERVAL              "*/5 * * * *"
ENV DEMYX_DB_HOST                       localhost
ENV DEMYX_DB_NAME                       demyx
ENV DEMYX_DB_PASSWORD                   demyx
ENV DEMYX_DB_USERNAME                   demyx
ENV DEMYX_DOMAIN                        localhost
ENV DEMYX_EMERGENCY_RESTART_INTERVAL    1m
ENV DEMYX_EMERGENCY_RESTART_THRESHOLD   5
ENV DEMYX_LOG                           /var/log/demyx
ENV DEMYX_LOGROTATE                     daily
ENV DEMYX_LOGROTATE_INTERVAL            7
ENV DEMYX_LOGROTATE_SIZE                10M
ENV DEMYX_MAX_EXECUTION_TIME            300
ENV DEMYX_MEMORY                        256M
ENV DEMYX_OPCACHE                       true
ENV DEMYX_OPCACHE_ENABLE                1
ENV DEMYX_OPCACHE_ENABLE_CLI            1
ENV DEMYX_PHP                           8.2
ENV DEMYX_PM_AVERAGE                    100000
ENV DEMYX_PM_MAX_REQUESTS               5000
ENV DEMYX_PROCESS_CONTROL_TIMEOUT       10s
ENV DEMYX_PROTO                         http
ENV DEMYX_UPLOAD_LIMIT                  256M
ENV DEMYX_WP_CONFIG                     "${DEMYX}/wp-config.php"
ENV DEMYX_WP_EMAIL                      info@domain.tld
ENV DEMYX_WP_PASSWORD                   demyx
ENV DEMYX_WP_USERNAME                   demyx
ENV TERM                                xterm-256color
ENV TZ                                  America/Los_Angeles

# Packages
RUN set -ex; \
    apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        bsdmainutils \
        ca-certificates \
        cron \
        curl \
        default-mysql-client \
        dnsutils \
        ed \
        git \
        gnupg \
        htop \
        iputils-ping \
        jq \
        less \
        libpng-dev \
        libssh2-1-dev \
        libssh2-1 \
        libzip-dev \
        libmagickwand-dev \
        libmagickcore-dev \
        logrotate \
        nano \
        net-tools \
        openssh-client \
        procps \
        sudo \
        tzdata \
        unzip \
        util-linux \
        wget \
        zlib1g-dev \
        zsh

# PHP extensions
RUN set -ex; \
    docker-php-ext-install \
        exif \
        gd \
        mysqli \
        opcache \
        pdo_mysql \
        sockets \
        zip

# PECL
RUN set -ex; \
    pecl install ssh2 xdebug

# Temporary imagick fix for imagick
ARG IMAGICK_PHP83_FIX_COMMIT=9df92616f577e38625b96b7b903582a46c064739
RUN apt-get -q update && \
    apt-get -yq upgrade && \
    export PHP_DEV_DEPS='libmagickwand-dev' && \
    apt-get -yq install --no-install-recommends libmagickwand-6.q16-6 $PHP_DEV_DEPS && \
    \
    # Install Imagick from specific archive (PR's #616 code)
    curl -L "https://github.com/remicollet/imagick/archive/${IMAGICK_PHP83_FIX_COMMIT}.zip" -o /tmp/imagick-issue-php83.zip && \
    unzip /tmp/imagick-issue-php83.zip -d /tmp && \
    pecl install "/tmp/imagick-${IMAGICK_PHP83_FIX_COMMIT}/package.xml" && \
    \
    apt-get purge -y $PHP_DEV_DEPS $PHPIZE_DEPS && \
    apt-get autoremove -y --purge && \
    apt-get clean all && \
    rm -Rf /tmp/* && \
    echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini

# Enable extensions
RUN set -ex; \
    docker-php-ext-enable imagick xdebug ssh2

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
    su -c "git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/demyx/.oh-my-zsh/custom/plugins/zsh-autosuggestions" -s /bin/sh demyx; \
    su -c "git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins.git /home/demyx/.oh-my-zsh/custom/plugins/autoupdate" -s /bin/sh demyx; \
    sed -i 's|source $ZSH/oh-my-zsh.sh|source "$DEMYX_CONFIG"/.demyxrc\nsource $ZSH/oh-my-zsh.sh|g' /home/demyx/.zshrc; \
    \
    # Change user shell
    sed -i "s|/home/demyx.*|/home/demyx:/bin/zsh|g" /etc/passwd

# Composer
RUN set -ex; \
    curl -sL https://getcomposer.org/installer -o /tmp/composer-setup.php; \
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# PHP CodeSniffer & WPCS
RUN set -ex; \
    su -c "composer global config allow-plugins.dealerdirect/phpcodesniffer-composer-installer true; \
    composer global require --dev wp-coding-standards/wpcs:\"^3.0\"; \
    /home/demyx/.composer/vendor/bin/phpcs --config-set installed_paths /home/demyx/.composer/vendor/wp-coding-standards/wpcs --standard=WordPress" -s /bin/sh demyx; \
    ln -s /home/demyx/.composer/vendor/bin/phpcs /usr/local/bin/phpcs

# WordPress
RUN set -ex; \
    \
    # Install wp-cli with memory-aware wrapper
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -qO /home/demyx/wp; \
    chmod +x /home/demyx/wp; \
    \
    # Create memory-aware wp wrapper script
    echo "#!/bin/bash\nexec php -d memory_limit=\"\${DEMYX_MEMORY}\" /home/demyx/wp \"\$@\"" > /usr/local/bin/wp; \
    chmod +x /usr/local/bin/wp; \
    \
    su -c "wp package install aaemnnosttv/wp-cli-login-command; \
        wget https://raw.githubusercontent.com/aaemnnosttv/wp-cli-login-command/master/plugin/wp-cli-login-server.php -qO ${DEMYX_CONFIG}/wp-cli-login-server.php" -s /bin/sh demyx

# Imports
COPY --from=demyx_shellcheck /bin/shellcheck /usr/local/bin/shellcheck
COPY bin /usr/local/bin
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
        --install-extension=catppuccin.catppuccin-vsc \
        --install-extension=catppuccin.catppuccin-vsc-icons \
        --install-extension=shevaua.phpcs \
        --install-extension=felixfbecker.php-debug \
        --install-extension=remisa.shellman \
        --install-extension=timonwong.shellcheck; \
    \
    # Finalize code-server
    chown -R demyx:demyx "$DEMYX_CODE_CONFIG"; \
    chown -R demyx:demyx "$DEMYX_CONFIG"; \
    cp -rp "$DEMYX_CODE_CONFIG" "$DEMYX_CONFIG"

# Finalize
RUN set -ex; \
    \
    # Remove php-fpm configs
    rm -f /usr/local/etc/php-fpm.d/*; \
    \
    # Use our php-fpm configs
    ln -sf "${DEMYX_CONFIG}"/demyx.ini /usr/local/etc/php/php.ini; \
    ln -sf "${DEMYX_CONFIG}"/www.conf /usr/local/etc/php-fpm.d/www.conf; \
    echo "[XDebug]\nzend_extension = xdebug.so\nxdebug.client_port = 9001\nxdebug.mode = debug\nxdebug.start_with_request = trigger\nxdebug.trigger_value = 1" > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
    \
    # Configure sudo
    echo "demyx ALL=(ALL) NOPASSWD:SETENV: /usr/local/bin/demyx-sudo" > /etc/sudoers.d/demyx; \
    \
    # Set ownership
    chown -R root:root /usr/local/bin; \
    \
    # Cleanup
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/*

EXPOSE 8080 9000 9001
WORKDIR "$DEMYX"
USER demyx
ENTRYPOINT ["demyx-entrypoint"]
CMD [ "code-server", "/demyx" ]
