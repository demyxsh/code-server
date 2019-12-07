#!/bin/bash
# Demyx
# https://demyx.sh

# Auto install WordPress if it's not installed already
if [[ ! -f /var/www/html/.env ]]; then
    sleep 5
    
    wp core install \
    --url="$WORDPRESS_INSTALL_URL" \
    --title="$WORDPRESS_INSTALL_TITLE" \
    --admin_user="$WORDPRESS_INSTALL_USER" \
    --admin_password="$WORDPRESS_INSTALL_PASSWORD" \
    --admin_email="$WORDPRESS_INSTALL_EMAIL" \
    --skip-email; \
    
    wp rewrite structure '/%category%/%postname%/'
    
    echo \"[demyx] installing Sage...\"
    tar -xzf /usr/src/sage.tgz -C /var/www/html/web/app/themes
    rm -rf /var/www/html/web/wp/wp-content/themes/twenty*
    rm -rf /var/www/html/web/wp/wp-content/plugins/hello.php
    wp theme activate sage/resources
    sage init
fi

# Install demyx helper plugin
cp /usr/src/bs.php /var/www/html/web/app/mu-plugins

# Set base path
if [[ -n "$CODER_BASE_PATH" ]]; then
    CODER_BASE_PATH="$CODER_BASE_PATH"/cs
fi

code-server /var/www/html --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry --base-path="$CODER_BASE_PATH"
