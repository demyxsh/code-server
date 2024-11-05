FROM koalaman/shellcheck as demyx_shellcheck
FROM php:8.3-cli-bullseye

LABEL sh.demyx.image                            demyx/code-server:openlitespeed
LABEL sh.demyx.maintainer                       Demyx <info@demyx.sh>
LABEL sh.demyx.url                              https://demyx.sh
LABEL sh.demyx.github                           https://github.com/demyxsh
LABEL sh.demyx.registry                         https://hub.docker.com/u/demyx

# Set default variables
ENV DEMYX                                       /demyx
ENV DEMYX_BEDROCK                               false
ENV DEMYX_ADMIN                                 /demyx/ols
ENV DEMYX_ADMIN_IP                              ALL
ENV DEMYX_ADMIN_PASSWORD                        demyx
ENV DEMYX_ADMIN_PREFIX                          true
ENV DEMYX_ADMIN_USERNAME                        demyx
ENV DEMYX_BASIC_AUTH_PASSWORD                   demyx
ENV DEMYX_BASIC_AUTH_USERNAME                   demyx
ENV DEMYX_BASIC_AUTH_WP                         false
ENV DEMYX_CACHE                                 false
ENV DEMYX_CLIENT_THROTTLE_BANDWIDTH_IN          0
ENV DEMYX_CLIENT_THROTTLE_BANDWIDTH_OUT         0
ENV DEMYX_CLIENT_THROTTLE_BAN_PERIOD            60
ENV DEMYX_CLIENT_THROTTLE_BLOCK_BAD_REQUEST     1
ENV DEMYX_CLIENT_THROTTLE_DYNAMIC               1000
ENV DEMYX_CLIENT_THROTTLE_GRACE_PERIOD          30
ENV DEMYX_CLIENT_THROTTLE_HARD_LIMIT            2000
ENV DEMYX_CLIENT_THROTTLE_SOFT_LIMIT            1500
ENV DEMYX_CLIENT_THROTTLE_STATIC                1000
ENV DEMYX_CODE_AUTH                             password
ENV DEMYX_CODE_BIND_ADDR                        0.0.0.0:8080
ENV DEMYX_CODE_CONFIG                           /home/demyx/.config/code-server
ENV DEMYX_CODE_PASSWORD                         demyx
ENV DEMYX_CONFIG                                /etc/demyx
ENV DEMYX_CRAWLER_LOAD_LIMIT                    5.2
ENV DEMYX_CRAWLER_USLEEP                        1000
ENV DEMYX_CRON                                  true
ENV DEMYX_CRON_LOGROTATE_INTERVAL               "0 0 * * *"
ENV DEMYX_CRON_WP_INTERVAL                      "*/5 * * * *"
ENV DEMYX_DB_HOST                               localhost
ENV DEMYX_DB_NAME                               demyx
ENV DEMYX_DB_PASSWORD                           demyx
ENV DEMYX_DB_USERNAME                           demyx
ENV DEMYX_DOMAIN                                localhost
ENV DEMYX_LOG                                   /var/log/demyx
ENV DEMYX_LOGROTATE                             daily
ENV DEMYX_LOGROTATE_INTERVAL                    7
ENV DEMYX_LOGROTATE_SIZE                        10M
ENV DEMYX_LSAPI_AVOID_FORK                      0
ENV DEMYX_LSAPI_CHILDREN                        35
ENV DEMYX_LSAPI_MAX_IDLE                        300
ENV DEMYX_LSAPI_MAX_PROCESS_TIME                3600
ENV DEMYX_LSAPI_MAX_REQS                        10000
ENV DEMYX_LSPHP                                 lsphp82
ENV DEMYX_MAX_EXECUTION_TIME                    300
ENV DEMYX_MEMORY                                256M
ENV DEMYX_OPCACHE                               true
ENV DEMYX_PROTO                                 http
ENV DEMYX_RECAPTCHA_CONNECTION_LIMIT            500
ENV DEMYX_RECAPTCHA_ENABLE                      1
ENV DEMYX_RECAPTCHA_TYPE                        2
ENV DEMYX_TUNING_CONNECTION_TIMEOUT             300
ENV DEMYX_TUNING_KEEP_ALIVE_TIMEOUT             300
ENV DEMYX_TUNING_MAX_CONNECTIONS                20000
ENV DEMYX_TUNING_MAX_KEEP_ALIVE                 1000
ENV DEMYX_TUNING_SMART_KEEP_ALIVE               1000
ENV DEMYX_UPLOAD_LIMIT                          256M
ENV DEMYX_WP_CONFIG                             "${DEMYX}/wp-config.php"
ENV DEMYX_WP_EMAIL                              info@domain.tld
ENV DEMYX_WP_PASSWORD                           demyx
ENV DEMYX_WP_USERNAME                           demyx
ENV DEMYX_XMLRPC                                false
ENV PATH                                        "${PATH}:/usr/local/lsws/${DEMYX_LSPHP}/bin"
ENV TERM                                        xterm-256color
ENV TZ                                          America/Los_Angeles

# Packages
RUN set -ex; \
    apt-get update && apt-get install -y --no-install-recommends \
        bc \
        bsdmainutils \
        ca-certificates \
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
        mariadb-client \
        nano \
        net-tools \
        openssh-client \
        procps \
        ruby \
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
    pecl install ssh2

# Enable extensions
RUN set -ex; \
    docker-php-ext-enable ssh2

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

# OpenLiteSpeed
RUN set -ex; \
    apt-get install -y --no-install-recommends tidy; \
    \
    DEMYX_OLS_VERSION="$(wget -qO- https://openlitespeed.org/downloads/ | tidy -i 2>&1 | grep "<h6>" | head -1 | awk -F '[V]' '{print $2}' | sed 's| ||g' | sed 's|<.*||g')"; \
    curl -sL https://openlitespeed.org/packages/openlitespeed-"$DEMYX_OLS_VERSION".tgz -o /tmp/openlitespeed-"$DEMYX_OLS_VERSION".tgz; \
    tar -xzf /tmp/openlitespeed-"$DEMYX_OLS_VERSION".tgz -C /tmp; \
    cd /tmp/openlitespeed && ./install.sh; \
    \
    wget -O - https://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | bash; \
    \
    apt-get update && apt-get install -y \
        "$DEMYX_LSPHP" \
        "$DEMYX_LSPHP"-curl \
        "$DEMYX_LSPHP"-imagick \
        "$DEMYX_LSPHP"-intl \
        "$DEMYX_LSPHP"-mysql \
        "$DEMYX_LSPHP"-redis \
        \
        lsphp83 \
        lsphp83-curl \
        lsphp83-imagick \
        lsphp83-intl \
        lsphp83-mysql \
        lsphp83-redis; \
    \
    ln -sf /usr/local/lsws/"$DEMYX_LSPHP"/bin/lsphp /usr/local/lsws/fcgi-bin/lsphp5; \
    \
    # Create directory for lsadm user
    install -d -m 0755 -o lsadm -g lsadm "$DEMYX_CONFIG"/ols; \
    \
    # Symlink configs to lsws
    ln -sf "$DEMYX_CONFIG"/ols/httpd_config.conf /usr/local/lsws/conf/httpd_config.conf; \
    ln -sf "$DEMYX_CONFIG"/ols/admin_config.conf /usr/local/lsws/admin/conf/admin_config.conf; \
    ln -s "$DEMYX_CONFIG"/ols /usr/local/lsws/conf/vhosts; \
    \
    # Remove one time use package
    apt-get purge tidy -y

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

# Xdebug
RUN set -ex; \
    DEMYX_XDEBUG_DEPS="build-essential autoconf"; \
    \
    apt-get install -y --no-install-recommends $DEMYX_XDEBUG_DEPS; \
    \
    ln -s /bin/sed /usr/bin/sed; \
    \
    pecl install xdebug; \
    \
    apt-get purge -y build-essential $DEMYX_XDEBUG_DEPS; \
    apt-get autoremove -y

# Configure Xdebug
RUN set -ex; \
    DEMYX_FIND_XDEBUG="$(find /usr/local/lib/php/extensions -name 'xdebug.so')"; \
    DEMYX_FIND_SO="$(find /usr/local/lsws/lsphp* -name 'opcache.so' 2>/dev/null)"; \
    DEMYX_FIND_INI="$(find /usr/local/lsws/lsphp* -name 'php.ini' 2>/dev/null)"; \
    DEMYX_FIND_MODS="$(find /usr/local/lsws/lsphp*/etc/php/*/mods-available -name 'opcache.ini' 2>/dev/null)"; \
    \
    DEMYX_ECHO_XDEBUG="[XDebug]\nzend_extension = ${DEMYX_FIND_XDEBUG}\nxdebug.client_port = 9001\nxdebug.mode = debug\nxdebug.start_with_request = trigger\nxdebug.trigger_value = 1"; \
    \
    for i in $DEMYX_FIND_SO; do DEMYX_SED="$(echo "$i" | sed 's|opcache.so||g')" && cp "$DEMYX_FIND_XDEBUG" "$DEMYX_SED"; done; \
    for i in $DEMYX_FIND_INI; do echo "$DEMYX_ECHO_XDEBUG" >> "$i"; done; \
    for i in $DEMYX_FIND_MODS; do DEMYX_SED="$(echo "$i" | sed 's|opcache.ini||g')" && echo "zend_extension=xdebug" > "$DEMYX_SED"/xdebug.ini; done

# WordPress
RUN set -ex; \
    \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -qO /usr/local/bin/wp; \
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
        --install-extension=equinusocio.vsc-material-theme \
        --install-extension=pkief.material-icon-theme \
        --install-extension=remisa.shellman \
        --install-extension=timonwong.shellcheck; \
    \
    # Tag specifc extensions
    code-server --extensions-dir="$DEMYX_CODE_CONFIG"/extensions \
        --install-extension="$DEMYX_CONFIG"/shevaua.phpcs-1.0.8.vsix \
        --install-extension=felixfbecker.php-debug; \
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
    # sudoers
    echo "demyx ALL=(ALL) NOPASSWD:SETENV: /usr/local/bin/demyx-admin, /usr/local/bin/demyx-config, /usr/local/bin/demyx-htpasswd, /usr/local/bin/demyx-lsws, /usr/local/bin/demyx-sudo" > /etc/sudoers.d/demyx; \
    \
    # Set ownership
    chown -R root:root /usr/local/bin; \
    \
    # Cleanup
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/*

EXPOSE 80 8080 8081 9000 9001
WORKDIR "$DEMYX"
USER demyx
ENTRYPOINT ["demyx-entrypoint"]
CMD [ "code-server", "/demyx" ]
