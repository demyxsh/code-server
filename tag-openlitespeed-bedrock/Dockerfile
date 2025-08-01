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
RUN set -ex;\
    # Set ownership
    chown -R root:root /usr/local/bin; \
    \
    # Clear /tmp
    rm -rf /tmp/*

USER demyx
