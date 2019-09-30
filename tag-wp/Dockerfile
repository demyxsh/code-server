FROM alpine

LABEL sh.demyx.image demyx/code-server:wp
LABEL sh.demyx.maintainer Demyx <info@demyx.sh>
LABEL sh.demyx.url https://demyx.sh
LABEL sh.demyx.github https://github.com/demyxco/demyx
LABEL sh.demyx.registry https://hub.docker.com/u/demyx

ENV TZ America/Los_Angeles
ENV PASSWORD demyx

USER root

# Download Alpine binary of code-server
RUN set -ex; \
    wget https://github.com/cdr/code-server/releases/download/2.1523-vsc1.38.1/code-server2.1523-vsc1.38.1-alpine-x86_64.tar.gz -qO /tmp/code-server2.1523-vsc1.38.1-alpine-x86_64.tar.gz; \
    tar -xzf /tmp/code-server2.1523-vsc1.38.1-alpine-x86_64.tar.gz -C /tmp; \
    mv /tmp/code-server2.1523-vsc1.38.1-alpine-x86_64/code-server /usr/local/bin; \
    rm -rf /tmp/*

# Install custom packages
RUN set -ex; \
    apk add --update --no-cache \
    gcc \
    bash \
    zsh \
    jq \
    htop \
    nano \
    tzdata \
    gnupg \
    git \
    sudo \
    curl \
    composer \
    npm; \
    npm install -g browser-sync

# Create and configure www-data user
RUN set -ex; \
    addgroup -g 82 -S www-data; \
    adduser -u 82 -D -S -G www-data www-data; \
    \
    sed -i "s|/root:/bin/bash|/root:/bin/zsh|g" /etc/passwd; \
    sed -i "s|/home/www-data:/bin/sh|/home/www-data:/bin/zsh|g" /etc/passwd; \
    \
    mkdir -p /home/www-data/.code/data/User; \
    echo "{\n    \"terminal.integrated.shell.linux\": \"/bin/zsh\"\n}" > /home/www-data/.code/data/User/settings.json; \
    \
    # No password when using sudo
    echo "www-data ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd
    
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
    # gpg purposes
    echo 'export GPG_TTY=$(tty)' >> /root/.zshrc; \
    echo 'export GPG_TTY=$(tty)' >> /home/www-data/.zshrc; \
    \
    chown -R www-data:www-data /home/www-data

# wp-cli
RUN set -ex; \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    chmod +x wp-cli.phar; \
    mv wp-cli.phar /usr/local/bin/wp

# s6-overlay
RUN set -ex; \
    export DEMYX_S6_VERSION=$(curl -sL https://api.github.com/repos/just-containers/s6-overlay/releases/latest | grep '"name"' | head -n1 | awk -F '[:]' '{print $2}' | sed -e 's/"//g' | sed -e 's/,//g' | sed -e 's/ //g' | sed -e 's/\r//g'); \
    wget https://github.com/just-containers/s6-overlay/releases/download/${DEMYX_S6_VERSION}/s6-overlay-amd64.tar.gz -qO /tmp/s6-overlay-amd64.tar.gz; \
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C /; \
    rm -rf /tmp/*

COPY s6-overlay/00-init /etc/cont-init.d/00-init
COPY s6-overlay/run-code-server /etc/services.d/code-server/run
COPY s6-overlay/run-browser-sync /etc/services.d/browser-sync/run

EXPOSE 8080 3000

WORKDIR /var/www/html

ENTRYPOINT ["/init"]
