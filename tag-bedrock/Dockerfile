FROM demyx/code-server:wp

LABEL sh.demyx.image                    demyx/code-server:bedrock
LABEL sh.demyx.maintainer               Demyx <info@demyx.sh>
LABEL sh.demyx.url                      https://demyx.sh
LABEL sh.demyx.github                   https://github.com/demyxsh
LABEL sh.demyx.registry                 https://hub.docker.com/u/demyx

# Default bedrock to production
ENV DEMYX_BEDROCK               true
ENV DEMYX_BEDROCK_MODE          production
ENV DEMYX_SSL                   false
ENV DEMYX_WP_CONFIG             "${DEMYX}/web/wp-config.php"
# Support for old variables
ENV CODE_ROOT                                   "$DEMYX"
ENV CODE_CONFIG                                 "$DEMYX_CONFIG"
ENV CODE_LOG                                    "$DEMYX_LOG"

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

COPY bin /usr/local/bin

USER demyx
