FROM demyx/nginx-php-wordpress

LABEL sh.demyx.image demyx/code-server:sage
LABEL sh.demyx.maintainer Demyx <info@demyx.sh>
LABEL sh.demyx.url https://demyx.sh
LABEL sh.demyx.github https://github.com/demyxco
LABEL sh.demyx.registry https://hub.docker.com/u/demyx

# Packages
RUN set -ex; \
    apk add --update --no-cache \
    composer \
    gcc \
    git \
    gnupg \
    htop \
    jq \
    mysql-client \
    nano \
    npm \
    openssh \
    sudo \
    util-linux \
    zsh; \
    \
    npm -g install yarn

# Bedrock
RUN set -ex; \
    su -c 'composer create-project roots/bedrock /tmp/bedrock; composer clearcache' -s /bin/sh www-data; \
    tar -czf /usr/src/bedrock.tgz -C /tmp/bedrock .; \
    rm -rf /usr/src/wordpress; \
    rm -rf /tmp/*; \
    \
    echo -e '# Prevent PHP scripts from being executed inside the uploads folder.\nlocation ~* /app/uploads/.*.php\$ {\n    deny all;\n}\nlocation ~* .(blade.php)$ {\n     deny all;\n}' > /etc/nginx/common/bedrock.conf; \
    sed -i "s|/var/www/html|/var/www/html/web|g" /etc/nginx/nginx.conf

# Sage
RUN set ex; \
    su -c 'composer create-project -n roots/sage /tmp/sage; \
        yarn --cwd=/tmp/sage; \
        yarn --cwd=/tmp/sage build; \
        yarn cache clean; \
        composer clearcache' -s /bin/sh www-data; \
    tar -czf /usr/src/sage.tgz -C /tmp sage; \
    rm -rf /tmp/*; \
    chown -R root:root /usr/src

# wp-cli
RUN set -ex; \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    chmod +x wp-cli.phar; \
    mv wp-cli.phar /usr/local/bin/wp

# Oh-My-Zsh
RUN set -ex; \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"; \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git /root/.oh-my-zsh/plugins/zsh-autosuggestions; \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' /root/.zshrc; \
    sed -i "s/(git)/(git zsh-autosuggestions)/g" /root/.zshrc; \
    \
    su -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" -s /bin/sh www-data; \
    su -c  "git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/www-data/.oh-my-zsh/plugins/zsh-autosuggestions" -s /bin/sh www-data; \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' /home/www-data/.zshrc; \
    sed -i "s/(git)/(git zsh-autosuggestions)/g" /home/www-data/.zshrc; \
    \
    # Symlink demyx command history with root
    ln -s /home/www-data/.zsh_history /root; \
    \
    # Change shell
    sed -i "s|/root:/bin/bash|/root:/bin/zsh|g" /etc/passwd; \
    sed -i "s|/home/www-data:/sbin/nologin|/home/www-data:/bin/zsh|g" /etc/passwd; \
    \
    # Create code-server directories and set default shell for code-server
    mkdir -p /home/www-data/.code/extensions; \
    mkdir -p /home/www-data/.code/data/User; \
    echo -e "{\n    \"terminal.integrated.shell.linux\": \"/bin/zsh\"\n}" > /home/www-data/.code/data/User/settings.json; \
    \
    # No password when using sudo
    echo "www-data ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd; \
    \
    # gpg purposes
    echo 'export GPG_TTY=$(tty)' >> /root/.zshrc; \
    echo 'export GPG_TTY=$(tty)' >> /home/www-data/.zshrc; \
    \
    chown -R www-data:www-data /home/www-data

# Download Alpine binary of code-server
RUN set -ex; \
    export DEMYX_CODER_BINARY=$(curl -sL https://api.github.com/repos/cdr/code-server/releases/latest | grep '"name"' | head -n1 | awk -F '[:]' '{print $2}' | sed -e 's/"//g' | sed -e 's/,//g' | sed -e 's/ //g' | sed -e 's/\r//g'); \
    # Set fixed version as a fallback if curling fails
    if [ -z "$DEMYX_CODER_BINARY" ]; then export DEMYX_CODER_BINARY=2.1650-vsc1.39.2; fi; \
    wget https://github.com/cdr/code-server/releases/download/"$DEMYX_CODER_BINARY"/code-server"$DEMYX_CODER_BINARY"-alpine-x86_64.tar.gz -qO /tmp/code-server"$DEMYX_CODER_BINARY"-alpine-x86_64.tar.gz; \
    tar -xzf /tmp/code-server"$DEMYX_CODER_BINARY"-alpine-x86_64.tar.gz -C /tmp; \
    mv /tmp/code-server"$DEMYX_CODER_BINARY"-alpine-x86_64/code-server /usr/local/bin; \
    rm -rf /tmp/*

# Install code-server Laravel Blade extension
RUN set -ex; \
    su -c 'code-server --extensions-dir /home/www-data/.code/extensions --install-extension cjhowe7.laravel-blade --force' -s /bin/sh www-data

COPY 00-init /etc/cont-init.d/00-init
COPY run-code-server /etc/services.d/code-server/run
COPY bs.js /usr/src/bs.js
# Sage helper for yarn
COPY sage.sh /usr/local/bin/sage
# A static homepage will redirect BrowserSync, this plugin disables that.
COPY demyx-browsersync.php /usr/src/demyx-browsersync.php

RUN chmod +x /usr/local/bin/sage

EXPOSE 80 3000 8080 9000

WORKDIR /var/www/html

ENTRYPOINT ["/init"]
