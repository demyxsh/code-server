FROM demyx/code-server:openlitespeed

LABEL sh.demyx.image                            demyx/code-server:openlitespeed-bedrock
LABEL sh.demyx.maintainer                       Demyx <info@demyx.sh>
LABEL sh.demyx.url                              https://demyx.sh
LABEL sh.demyx.github                           https://github.com/demyxsh
LABEL sh.demyx.registry                         https://hub.docker.com/u/demyx

# Default bedrock to production
ENV DEMYX_BEDROCK               true
ENV DEMYX_SSL                   false
ENV DEMYX_WP_CONFIG             "${DEMYX}/web/wp-config.php"

# Need root stuff
USER root

# Bedrock
RUN set -ex; \
    # Remove old files
    rm -f "$DEMYX_CONFIG"/wordpress.tgz; \
    rm -f /usr/local/bin/demyx-install; \
    rm -rf "$DEMYX"/*; \
    \
    # Configure Bedrock
    su -c "composer create-project roots/bedrock /tmp/bedrock; \
        \
        cd /tmp/bedrock && composer require roots/acorn; \
        \
        mv .env.example .env; \
        \
        cp -r /tmp/bedrock/. ${DEMYX}; \
        \
        tar -czf ${DEMYX_CONFIG}/bedrock.tgz -C /tmp/bedrock ." -s /bin/sh demyx

# Imports
COPY bin /usr/local/bin

# Finalize
RUN set -ex; \
    # sudoers
    echo "demyx ALL=(ALL) NOPASSWD:SETENV: /usr/local/lsws/bin/lswsctrl, /usr/local/bin/demyx-admin, /usr/local/bin/demyx-config, /usr/local/bin/demyx-htpasswd, /usr/local/bin/demyx-lsws, /usr/local/bin/demyx-sudo" > /etc/sudoers.d/demyx; \
    \
    # Set ownership
    chown -R root:root /usr/local/bin; \
    \
    # Cleanup
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/*

USER demyx
