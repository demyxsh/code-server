FROM php:fpm-alpine

LABEL sh.demyx.image demyx/code-server:wp-alpine
LABEL sh.demyx.maintainer Demyx <info@demyx.sh>
LABEL sh.demyx.url https://demyx.sh
LABEL sh.demyx.github https://github.com/demyxsh
LABEL sh.demyx.registry https://hub.docker.com/u/demyx

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

# Packages
RUN set -ex; \
    apk add --update --no-cache \
    bash \
    curl \
    dumb-init \
    git \
    gnupg \
    htop \
    less \
    jq \
    nano \
    openssh \
    sudo \
    unzip \
    util-linux \
    tzdata \
    zsh
# Install php extensions
RUN set -ex; \
    curl -sL https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions -o /usr/local/bin/install-php-extensions; \
    chmod uga+x /usr/local/bin/install-php-extensions; \
    sync; \
    install-php-extensions exif gd imagick mysqli opcache pdo_mysql ssh2 sockets xdebug zip

# Set up user
RUN set -ex; \
    sed -i "s|/home/demyx:/sbin/nologin|/home/demyx:/bin/zsh|g" /etc/passwd; \
    echo "demyx ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/demyx; \
    \
    # Oh-My-Zsh
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
    # Copy .zshrc to config directory
    cp /home/demyx/.zshrc "$CODE_CONFIG"; \
    \
    # Disable sudo warnings for now
    echo "Set disable_coredump false" > /etc/sudo.conf

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
    \
    # Get remote files
    curl -sL https://github.com/demyxsh/code-server/raw/master/shared/bs.php -o "$CODE_CONFIG"/bs.php; \
    curl -sL https://github.com/demyxsh/code-server/raw/master/shared/launch.json -o "$CODE_CONFIG"/launch.json; \
    curl -sL https://github.com/demyxsh/code-server/raw/master/shared/shevaua.phpcs-1.0.8.vsix -o "$CODE_CONFIG"/shevaua.phpcs-1.0.8.vsix; \
    curl -sL https://github.com/demyxsh/code-server/raw/master/shared/settings-wp.json -o /home/demyx/.code/data/User/settings.json; \
    \
    # Install default extensions
    code-server --extensions-dir=/home/demyx/.code/extensions \
    --install-extension=equinusocio.vsc-material-theme \
    --install-extension=pkief.material-icon-theme \
    --install-extension="$CODE_CONFIG"/shevaua.phpcs-1.0.8.vsix \
    --install-extension=felixfbecker.php-debug; \
    \
    # Set ownership
    chown -R demyx:demyx /home/demyx/.code; \
    chown -R demyx:demyx "$CODE_CONFIG"; \
    \
    # Make a copy to demyx config directory
    cp -rp /home/demyx/.code "$CODE_CONFIG"/code

# Composer
RUN set -ex; \
    curl -sL https://getcomposer.org/installer -o /tmp/composer-setup.php; \
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# PHP CodeSniffer & WPCS
RUN set -ex; \
    su -c "mkdir \"$CODE_CONFIG\"/phpcs && cd \"$CODE_CONFIG\"/phpcs; \
    composer require \"squizlabs/php_codesniffer=*\"; \
    cd .. && git clone https://github.com/WordPress/WordPress-Coding-Standards; \
    \"$CODE_CONFIG\"/phpcs/vendor/bin/phpcs --config-set installed_paths ${CODE_CONFIG}/WordPress-Coding-Standards" -s /bin/sh demyx; \
    ln -s "$CODE_CONFIG"/phpcs/vendor/bin/phpcs /usr/local/bin/phpcs

# wp-cli
RUN set -ex; \
    curl -sL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp; \
    chmod +x /usr/local/bin/wp

# WordPress
RUN set -ex; \
    curl -sL https://wordpress.org/latest.tar.gz -o /latest.tar.gz; \
    tar -xzf /latest.tar.gz -C "$CODE_CONFIG"; \
    rm -f /latest.tar.gz; \
    chown -R demyx:demyx "$CODE_CONFIG"

# Finalize
RUN set -ex; \
    # Remove php-fpm configs
    rm -f /usr/local/etc/php-fpm.d/*; \
    \
    # Use our php-fpm configs
    ln -s "$CODE_CONFIG"/php.ini /usr/local/etc/php/php.ini; \
    ln -s "$CODE_CONFIG"/www.conf /usr/local/etc/php-fpm.d/www.conf; \
    ln -s "$CODE_CONFIG"/docker.conf /usr/local/etc/php-fpm.d/docker.conf; \
    \
    # demyx-config
    curl -sL https://github.com/demyxsh/code-server/raw/master/shared/config-wp.sh -o /usr/local/bin/demyx-config; \
    chmod +x /usr/local/bin/demyx-config; \
    # demyx-install
    curl -sL https://github.com/demyxsh/code-server/raw/master/shared/install-wp.sh -o /usr/local/bin/demyx-install; \
    chmod +x /usr/local/bin/demyx-install; \
    \
    # demyx-entrypoint
    curl -sL https://github.com/demyxsh/code-server/raw/master/shared/entrypoint-wp.sh -o /usr/local/bin/demyx-entrypoint; \
    chmod +x /usr/local/bin/demyx-entrypoint; \
    \
    # Set ownership
    chown -R root:root /usr/local/bin

EXPOSE 8080 9000 9001

WORKDIR "$CODE_ROOT"

USER demyx

ENTRYPOINT ["demyx-entrypoint"]
