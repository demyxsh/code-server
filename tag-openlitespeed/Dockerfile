FROM koalaman/shellcheck as demyx_shellcheck
FROM debian:buster-slim

LABEL sh.demyx.image                            demyx/code-server:openlitespeed
LABEL sh.demyx.maintainer                       Demyx <info@demyx.sh>
LABEL sh.demyx.url                              https://demyx.sh
LABEL sh.demyx.github                           https://github.com/demyxsh
LABEL sh.demyx.registry                         https://hub.docker.com/u/demyx

# Set default variables
ENV DEMYX                                       /demyx
ENV DEMYX_ADMIN                                 /demyx/ols
ENV DEMYX_ADMIN_EMAIL                           info@localhost
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
ENV DEMYX_DB_HOST                               localhost
ENV DEMYX_DB_NAME                               demyx
ENV DEMYX_DB_PASSWORD                           demyx
ENV DEMYX_DB_USER                               demyx
ENV DEMYX_DOMAIN                                localhost
ENV DEMYX_LOG                                   /var/log/demyx
ENV DEMYX_LSPHP_VERSION                         lsphp74
ENV DEMYX_PHP_LSAPI_CHILDREN                    2000
ENV DEMYX_PHP_MAX_EXECUTION_TIME                300
ENV DEMYX_PHP_MEMORY                            256M
ENV DEMYX_PHP_OPCACHE                           true
ENV DEMYX_PHP_UPLOAD_LIMIT                      128M
ENV DEMYX_RECAPTCHA_CONNECTION_LIMIT            500
ENV DEMYX_RECAPTCHA_ENABLE                      1
ENV DEMYX_RECAPTCHA_TYPE                        2
ENV DEMYX_TUNING_CONNECTION_TIMEOUT             300
ENV DEMYX_TUNING_KEEP_ALIVE_TIMEOUT             300
ENV DEMYX_TUNING_MAX_CONNECTIONS                20000
ENV DEMYX_TUNING_MAX_KEEP_ALIVE                 1000
ENV DEMYX_TUNING_SMART_KEEP_ALIVE               1000
ENV DEMYX_WP_CONFIG                             "${DEMYX}/wp-config.php"
ENV DEMYX_XMLRPC                                false
ENV PATH                                        "${PATH}:/usr/local/lsws/${DEMYX_LSPHP_VERSION}/bin"
ENV TERM                                        xterm-256color
ENV TZ                                          America/Los_Angeles
# Support for old variables
ENV CODE_ROOT                                   "$DEMYX"
ENV CODE_CONFIG                                 "$DEMYX_CONFIG"
ENV CODE_LOG                                    "$DEMYX_LOG"

# Packages
RUN set -ex; \
    apt-get update && apt-get install -y --no-install-recommends \
        apt-transport-https \
        bash \
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
        lsb-release \
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

# OpenLiteSpeed
RUN set -ex; \
    DEMYX_OLS_VERSION="$(wget -qO- https://api.github.com/repos/litespeedtech/openlitespeed/tags 2>&1 | jq -r '.[].name' | grep v1.6 | head -n 1 | sed 's|v||g' || true)"; \
    if [ "$DEMYX_OLS_VERSION" = 1.6.20.1 ]; then DEMYX_OLS_VERSION=1.6.21; fi; \
    if [ -z "$DEMYX_OLS_VERSION" ]; then DEMYX_OLS_VERSION=1.6.21; fi; \
    wget https://openlitespeed.org/packages/openlitespeed-"$DEMYX_OLS_VERSION".tgz -qO /tmp/openlitespeed-"$DEMYX_OLS_VERSION".tgz; \
    tar -xzf /tmp/openlitespeed-"$DEMYX_OLS_VERSION".tgz -C /tmp; \
    cd /tmp/openlitespeed && ./install.sh; \
    \
    wget -O - https://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | bash; \
    \
    apt-get update && apt-get install -y \
        "$DEMYX_LSPHP_VERSION" \
        "$DEMYX_LSPHP_VERSION"-curl \
        "$DEMYX_LSPHP_VERSION"-imagick \
        "$DEMYX_LSPHP_VERSION"-json \
        "$DEMYX_LSPHP_VERSION"-mysql; \
    \
    ln -sf /usr/local/lsws/"$DEMYX_LSPHP_VERSION"/bin/lsphp /usr/local/lsws/fcgi-bin/lsphp5; \
    \
    # Create directory for lsadm user
    install -d -m 0755 -o lsadm -g lsadm "$DEMYX_CONFIG"/ols; \
    \
    # Symlink configs to lsws
    ln -sf "$DEMYX_CONFIG"/ols/httpd_config.conf /usr/local/lsws/conf/httpd_config.conf; \
    ln -sf "$DEMYX_CONFIG"/ols/admin_config.conf /usr/local/lsws/admin/conf/admin_config.conf; \
    ln -s "$DEMYX_CONFIG"/ols /usr/local/lsws/conf/vhosts

# Composer
RUN set -ex; \
    curl -sL https://getcomposer.org/installer -o /tmp/composer-setup.php; \
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# PHP CodeSniffer & WPCS
RUN set -ex; \
    su -c "mkdir \"$DEMYX_CONFIG\"/phpcs && cd \"$DEMYX_CONFIG\"/phpcs; \
    composer require \"squizlabs/php_codesniffer=*\"; \
    cd .. && git clone -b master https://github.com/WordPress/WordPress-Coding-Standards.git wpcs; \
    \"$DEMYX_CONFIG\"/phpcs/vendor/bin/phpcs --config-set installed_paths ${DEMYX_CONFIG}/wpcs" -s /bin/sh demyx; \
    ln -s "$DEMYX_CONFIG"/phpcs/vendor/bin/phpcs /usr/local/bin/phpcs

# Xdebug
RUN set -ex; \
    apt-get install -y "$DEMYX_LSPHP_VERSION"-pear; \
    \
    ln -s /bin/sed /usr/bin/sed; \
    \
    pecl install xdebug; \
    \
    DEMYX_FIND_XDEBUG="$(find /usr/local/lsws -name "xdebug.so")"; \
    DEMYX_FIND_INI="$(find /usr/local/lsws -name "php.ini" 2>&1 | grep lsphp)"; \
    \
    echo "[XDebug]\nzend_extension = ${DEMYX_FIND_XDEBUG}\nxdebug.client_port = 9001\nxdebug.mode = debug\nxdebug.start_with_request = trigger\nxdebug.trigger_value = 1" >> "$DEMYX_FIND_INI"; \
    \
    apt-get purge -y "$DEMYX_LSPHP_VERSION"-pear; \
    apt-get autoremove -y

# WordPress
RUN set -ex; \
    su -c "wget https://wordpress.org/latest.tar.gz -qO /tmp/latest.tar.gz; \
        \
        tar -xzf /tmp/latest.tar.gz -C /tmp; \
        \
        mv /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php; \
        \
        cp -r /tmp/wordpress/* ${DEMYX}; \
        \
        tar -czf ${DEMYX_CONFIG}/wordpress.tgz -C /tmp/wordpress ." -s /bin/sh demyx

# wp-cli
RUN set -ex; \
    curl -sL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp; \
    chmod +x /usr/local/bin/wp

# Imports
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
    echo "demyx ALL=(ALL) NOPASSWD:SETENV: /usr/local/lsws/bin/lswsctrl, /usr/local/bin/demyx-admin, /usr/local/bin/demyx-config, /usr/local/bin/demyx-htpasswd, /usr/local/bin/demyx-lsws" > /etc/sudoers.d/demyx; \
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
