FROM codercom/code-server:v2

LABEL sh.demyx.image demyx/code-server:wp
LABEL sh.demyx.maintainer Demyx <info@demyx.sh>
LABEL sh.demyx.url https://demyx.sh
LABEL sh.demyx.github https://github.com/demyxco/demyx
LABEL sh.demyx.registry https://hub.docker.com/u/demyx

ENV DEBIAN_FRONTEND noninteractive
ENV TZ America/Los_Angeles
ENV PASSWORD demyx

USER root

# Install custom packages
RUN set -ex; \
    apt-get update && apt-get install -y software-properties-common; \
    add-apt-repository ppa:ondrej/php; \
    apt-get update && apt-get install -y php7.3 php7.3-mysqli zsh jq htop nano tzdata composer

# Oh My Zsh
RUN set -ex; \
    userdel coder; \
    userdel www-data; \
    # Match Alpine Linux's www-data UID:GID
    groupadd -g 82 www-data; \
    useradd -u 82 -g 82 www-data; \
    sed -i "s|/root:/bin/bash|/root:/bin/zsh|g" /etc/passwd; \
    sed -i "s|/home/www-data:/bin/sh|/home/www-data:/bin/zsh|g" /etc/passwd; \
    echo "www-data ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd; \
    mkdir -p /home/www-data/.code/data/User; \
    echo "{\n    \"terminal.integrated.shell.linux\": \"/bin/zsh\"\n    \"terminal.integrated.rendererType\": \"dom\"}" > /home/www-data/.code/data/User/settings.json; \
    chown -R www-data:www-data /home/www-data

RUN set -ex; \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"; \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git /root/.oh-my-zsh/plugins/zsh-autosuggestions; \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' /root/.zshrc; \
    sed -i "s/(git)/(git zsh-autosuggestions)/g" /root/.zshrc

RUN set -ex; \
    su -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" -s /bin/sh www-data; \
    su -c  "git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/www-data/.oh-my-zsh/plugins/zsh-autosuggestions" -s /bin/sh www-data; \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' /home/www-data/.zshrc; \
    sed -i "s/(git)/(git zsh-autosuggestions)/g" /home/www-data/.zshrc; \
    ln -s /home/www-data/.zsh_history /root

# nvm npm browser-sync
RUN set -ex; \
    su -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | zsh" -s /bin/zsh www-data; \
    su -c "source ~/.zshrc; nvm install --lts; npm -g install browser-sync" -s /bin/zsh www-data; \
    # BrowserSync shortcut command
    echo "#!/bin/bash\nbrowser-sync start --config=/home/www-data/bs.js" > /usr/local/bin/demyx-bs; \
    chmod +x /usr/local/bin/demyx-bs

# wp-cli
RUN set -ex; \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    chmod +x wp-cli.phar; \
    mv wp-cli.phar /usr/local/bin/wp

COPY demyx-entrypoint.sh /usr/local/bin/demyx-entrypoint

RUN chmod +x /usr/local/bin/demyx-entrypoint

USER www-data

WORKDIR /var/www/html

ENTRYPOINT ["dumb-init", "demyx-entrypoint"]
