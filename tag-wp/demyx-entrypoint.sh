#!/bin/bash
# Demyx
# https://demyx.sh

# Enable/disable password authentication
if [[ "$CODER_AUTH" = false ]]; then
    CODER_AUTH_FLAG=
else
    CODER_AUTH_FLAG="--auth=password"
fi

# Demyx use

if [[ "$DEMYX" = true ]]; then
    echo '// AUTO GENERATED
    module.exports={
        ui: false,
        open: false,
        files: '"$DEMYX_BS_FILES"',
        proxy: '\"$DEMYX_APP_WP_CONTAINER\"',
        rewriteRules:[{
            match: /'$DEMYX_APP_DOMAIN'/g,
            fn: function (e,r,t) {
                return '\"$DEMYX_APP_DOMAIN/demyx-bs\"'
            }
        }],
        scriptPath: function (path) {
            return "/demyx-bs" + path;
        },
        socket: {
            domain: '\"$DEMYX_APP_DOMAIN\"'
        }
    };' > /tmp/bs.js
    CODER_BASE_PATH="--base-path=/demyx-cs"
fi

echo "
[supervisord]
nodaemon=true

[program:code]
command=code-server /var/www/html --user-data-dir=/home/www-data/.code/data --extensions-dir=/home/www-data/.code/extensions --disable-telemetry "$CODER_AUTH_FLAG" "$CODER_BASE_PATH"
stdout_logfile=/dev/fd/1
stdout_logfile_maxbytes=0
redirect_stderr=true

[program:bs]
command=browser-sync start --config=/tmp/bs.js
stdout_logfile=/dev/fd/1
stdout_logfile_maxbytes=0
redirect_stderr=true
" > /tmp/supervisord.conf

supervisord -c /tmp/supervisord.conf -j /tmp/supervisord.pid -l /tmp/supervisord.log
