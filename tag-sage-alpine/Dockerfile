FROM demyx/code-server:wp-alpine

LABEL sh.demyx.image demyx/code-server:sage
LABEL sh.demyx.maintainer Demyx <info@demyx.sh>
LABEL sh.demyx.url https://demyx.sh
LABEL sh.demyx.github https://github.com/demyxco
LABEL sh.demyx.registry https://hub.docker.com/u/demyx

# Set default variables
ENV WORDPRESS_BEDROCK_MODE=development

# Remove WordPress
RUN set -ex; \
    rm -rf "$CODE_SERVER_CONFIG"/wordpress

# Packages
RUN set -ex; \
    sudo sh -c "apk add --update --no-cache autoconf automake libtool nasm npm zlib-dev; \
        \
        sudo npm -g install yarn"

# Composer
RUN set -ex; \
    curl -sL https://getcomposer.org/installer -o /tmp/composer-setup.php; \
    sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Install Sage
RUN set ex; \
    composer create-project -n roots/sage "$CODE_SERVER_CONFIG"/sage; \
    \
    yarn --cwd="$CODE_SERVER_CONFIG"/sage; \
    yarn --cwd="$CODE_SERVER_CONFIG"/sage build; \
    yarn cache clean; \
    \
    composer clearcache; \
    \
    tar -czf "$CODE_SERVER_CONFIG"/sage.tgz -C "$CODE_SERVER_CONFIG" sage; \
    \
    rm -rf "$CODE_SERVER_CONFIG"/sage

# Install Bedrock
RUN set -ex; \
    composer create-project roots/bedrock "$CODE_SERVER_CONFIG"/bedrock; \
    composer clearcache; \
    \
    tar -czf "$CODE_SERVER_CONFIG"/bedrock.tgz -C "$CODE_SERVER_CONFIG" bedrock; \
    \
    rm -rf "$CODE_SERVER_CONFIG"/bedrock

# Copy files
COPY demyx.sh /usr/local/bin/demyx
COPY --chown=demyx:demyx demyx/. "$CODE_SERVER_CONFIG"

# Finalize
RUN set -ex; \
    # Install blade extension
    code-server --extensions-dir=/home/demyx/.code/extensions --install-extension=cjhowe7.laravel-blade --force; \
    \
    # Install scripts
    sudo sh -c "mv ${CODE_SERVER_CONFIG}/sage.sh /usr/local/bin/sage; \
        mv ${CODE_SERVER_CONFIG}/install.sh /usr/local/bin/demyx-install; \
        chmod +x /usr/local/bin/sage; \
        chmod +x /usr/local/bin/demyx-install; \
        chmod +x /usr/local/bin/demyx"
