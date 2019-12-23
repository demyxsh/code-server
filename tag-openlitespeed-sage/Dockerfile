FROM codercom/code-server as demyx_cs
FROM demyx/openlitespeed:bedrock

LABEL sh.demyx.image demyx/code-server:openlitespeed-sage
LABEL sh.demyx.maintainer Demyx <info@demyx.sh>
LABEL sh.demyx.url https://demyx.sh
LABEL sh.demyx.github https://github.com/demyxco
LABEL sh.demyx.registry https://hub.docker.com/u/demyx

# Need to do root stuff
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
    php7.3 \
    php7.3-mbstring \
    php7.3-mysql \
    php7.3-xml \
    php7.3-zip \
    unzip \
    util-linux \
    zsh; \
    \
    npm -g install yarn; \
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
    chown -R demyx:demyx /home/demyx

# wp-cli
RUN set -ex; \
    curl -s https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp; \
    chmod +x /usr/local/bin/wp

# code-server
COPY --from=demyx_cs /usr/local/bin/code-server /usr/local/bin
# Copy files
COPY demyx.sh /usr/local/bin/demyx
COPY --chown=demyx:demyx demyx/. "$OPENLITESPEED_CONFIG"

# Finalize
RUN set -ex; \
    # Install blade extension
    code-server --extensions-dir="$OPENLITESPEED_CONFIG" --install-extension=cjhowe7.laravel-blade --force; \
    \
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/data/User; \
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/extensions; \
    \
    # Install scripts
    sudo sh -c "mv ${OPENLITESPEED_CONFIG}/sage.sh /usr/local/bin/sage; \
        mv ${OPENLITESPEED_CONFIG}/install.sh /usr/local/bin/demyx-install; \
        chmod +x /usr/local/bin/sage; \
        chmod +x /usr/local/bin/demyx-install; \
        chmod +x /usr/local/bin/demyx"

# Expose code-server port
EXPOSE 80 8080 8081

# Set back to demyx
USER demyx
