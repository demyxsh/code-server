#!/bin/bash
# Demyx
# https://demyx.sh

# Auto install WordPress if it's not installed already
if [[ "$(wp core is-installed; echo $?)" = 1 ]]; then
    sleep 5
    
    wp core install \
    --url="$WORDPRESS_INSTALL_URL" \
    --title="$WORDPRESS_INSTALL_TITLE" \
    --admin_user="$WORDPRESS_INSTALL_USER" \
    --admin_password="$WORDPRESS_INSTALL_PASSWORD" \
    --admin_email="$WORDPRESS_INSTALL_EMAIL" \
    --skip-email; \
    \
    wp rewrite structure '/%category%/%postname%/'
fi

# Install demyx helper plugin
[[ ! -d /var/www/html/wp-content/mu-plugins ]] && mkdir -p /var/www/html/wp-content/mu-plugins
cp /usr/src/bs.php /var/www/html/wp-content/mu-plugins

# Set prefix
[[ -z "$CODER_BASE_PREFIX" ]] && CODER_BASE_PREFIX=/cs
[[ "$CODER_BASE_PREFIX" = false ]] && CODER_BASE_PREFIX=

# Set base path
[[ -z "$CODER_BASE_PATH" ]] && CODER_BASE_PATH=/demyx
[[ "$CODER_BASE_PATH" = false ]] && CODER_BASE_PATH=

code-server /var/www/html --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry --base-path="${CODER_BASE_PATH}${CODER_BASE_PREFIX}"
