FROM demyx/code-server:wp

LABEL sh.demyx.image                    demyx/code-server:bedrock
LABEL sh.demyx.maintainer               Demyx <info@demyx.sh>
LABEL sh.demyx.url                      https://demyx.sh
LABEL sh.demyx.github                   https://github.com/demyxsh
LABEL sh.demyx.registry                 https://hub.docker.com/u/demyx

# Default bedrock to production
ENV DEMYX_BEDROCK               true
ENV DEMYX_BEDROCK_MODE          production
ENV DEMYX_SSL                   false
ENV DEMYX_WP_CONFIG             "${DEMYX}/web/wp-config.php"
# Support for old variables
ENV CODE_ROOT                                   "$DEMYX"
ENV CODE_CONFIG                                 "$DEMYX_CONFIG"
ENV CODE_LOG                                    "$DEMYX_LOG"

# Packages
RUN set -ex; \
    apt-get update && apt-get install -y --no-install-recommends \
        bash \
        build-essential \
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
    pecl install imagick ssh2 xdebug

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
    su -c "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/demyx/.oh-my-zsh/custom/themes/powerlevel10k" -s /bin/sh demyx; \
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
    su -c "mkdir \"$DEMYX_CONFIG\"/phpcs && cd \"$DEMYX_CONFIG\"/phpcs; \
    composer require \"squizlabs/php_codesniffer=*\"; \
    cd .. && git clone -b master https://github.com/WordPress/WordPress-Coding-Standards.git wpcs; \
    \"$DEMYX_CONFIG\"/phpcs/vendor/bin/phpcs --config-set installed_paths ${DEMYX_CONFIG}/wpcs" -s /bin/sh demyx; \
    ln -s "$DEMYX_CONFIG"/phpcs/vendor/bin/phpcs /usr/local/bin/phpcs

# NPM & Yarn
RUN set -ex; \
    su -c "curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh -o install.sh; \
        bash install.sh; \
        source /home/demyx/.nvm/nvm.sh; \
        nvm install --lts; \
        nvm use --lts; \
        npm install --global yarn; \
        tar -czf ${DEMYX_CONFIG}/nvm.tgz -C /home/demyx .nvm" -s /bin/bash demyx; \
    rm install.sh

# Bedrock
RUN set -ex; \
    su -c "composer create-project roots/bedrock /tmp/bedrock" -s /bin/sh demyx; \
    \
    # Upgrade WordPress to latest version
    sed -i 's|"roots/wordpress": .*|"roots/wordpress": ">5",|g' /tmp/bedrock/composer.json; \
    \
    su -c "cd /tmp/bedrock && composer require roots/acorn; \
        \
        cp -r . ${DEMYX}; \
        \
        tar -czf ${DEMYX_CONFIG}/bedrock.tgz -C /tmp/bedrock ." -s /bin/sh demyx

# wp-cli
RUN set -ex; \
    curl -sL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp; \
    chmod +x /usr/local/bin/wp

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
        --install-extension=shufo.vscode-blade-formatter \
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
    # Remove php-fpm configs
    rm -f /usr/local/etc/php-fpm.d/*; \
    \
    # Use our php-fpm configs
    ln -s "$DEMYX_CONFIG"/php.ini /usr/local/etc/php/php.ini; \
    ln -s "$DEMYX_CONFIG"/www.conf /usr/local/etc/php-fpm.d/www.conf; \
    ln -s "$DEMYX_CONFIG"/docker.conf /usr/local/etc/php-fpm.d/docker.conf; \
    \
    # Set ownership
    chown -R root:root /usr/local/bin; \
    \
    # Cleanup
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/*

EXPOSE 3000 8080 9000 9001

WORKDIR "$DEMYX"

USER demyx

ENTRYPOINT ["demyx-entrypoint"]
