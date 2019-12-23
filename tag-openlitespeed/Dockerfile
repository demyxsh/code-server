FROM demyx/openlitespeed

LABEL sh.demyx.image demyx/code-server:openlitespeed
LABEL sh.demyx.maintainer Demyx <info@demyx.sh>
LABEL sh.demyx.url https://demyx.sh
LABEL sh.demyx.github https://github.com/demyxco
LABEL sh.demyx.registry https://hub.docker.com/u/demyx

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
    net-tools \
    openssh-client \
    php7.3 \
    php7.3-mysql \
    util-linux \
    zsh; \
    \
    rm -rf /var/lib/apt/lists/*

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

# Download Alpine binary of code-server
RUN set -ex; \
    export DEMYX_CODER_BINARY=$(curl -sL https://api.github.com/repos/cdr/code-server/releases/latest | grep '"name"' | head -n1 | awk -F '[:]' '{print $2}' | sed -e 's/"//g' | sed -e 's/,//g' | sed -e 's/ //g' | sed -e 's/\r//g'); \
    # Set fixed version as a fallback if curling fails
    if [ -z "$DEMYX_CODER_BINARY" ]; then export DEMYX_CODER_BINARY=2.1650-vsc1.39.2; fi; \
    curl -sL https://github.com/cdr/code-server/releases/download/"$DEMYX_CODER_BINARY"/code-server"$DEMYX_CODER_BINARY"-linux-x86_64.tar.gz -o /tmp/code-server"$DEMYX_CODER_BINARY"-linux-x86_64.tar.gz; \
    tar -xzf /tmp/code-server"$DEMYX_CODER_BINARY"-linux-x86_64.tar.gz -C /tmp; \
    mv /tmp/code-server"$DEMYX_CODER_BINARY"-linux-x86_64/code-server /usr/local/bin; \
    rm -rf /tmp/*

# wp-cli
RUN set -ex; \
    curl -s https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp; \
    chmod +x /usr/local/bin/wp

# Copy files
COPY --chown=demyx:demyx demyx/. "$OPENLITESPEED_CONFIG"
COPY demyx.sh /usr/local/bin/demyx

# Finalize
RUN set -ex; \
    # Configure code-server for user
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/data/User; \
    install -d -m 0755 -o demyx -g demyx /home/demyx/.code/extensions; \
    \
    # Make scripts executable
    chmod +x "$OPENLITESPEED_CONFIG"/install.sh; \
    chmod +x /usr/local/bin/demyx; \
    \
    mv "$OPENLITESPEED_CONFIG"/settings.json /home/demyx/.code/data/User; \
    mv "$OPENLITESPEED_CONFIG"/install.sh /usr/local/bin/demyx-install

# Expose code-server port
EXPOSE 80 8080 8081

# Set back to demyx
USER demyx
