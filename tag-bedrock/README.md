# code-server:bedrock
[![Code Size](https://img.shields.io/github/languages/code-size/demyxsh/code-server?style=flat&color=blue)](https://github.com/demyxsh/code-server)
[![Repository Size](https://img.shields.io/github/repo-size/demyxsh/code-server?style=flat&color=blue)](https://github.com/demyxsh/code-server)
[![Watches](https://img.shields.io/github/watchers/demyxsh/code-server?style=flat&color=blue)](https://github.com/demyxsh/code-server)
[![Stars](https://img.shields.io/github/stars/demyxsh/code-server?style=flat&color=blue)](https://github.com/demyxsh/code-server)
[![Forks](https://img.shields.io/github/forks/demyxsh/code-server?style=flat&color=blue)](https://github.com/demyxsh/code-server)
[![Architecture](https://img.shields.io/badge/linux-amd64-important?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Debian](https://img.shields.io/badge/debian-10.10-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![code-server](https://img.shields.io/badge/code--server-3.12.0-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Buy Me A Coffee](https://img.shields.io/badge/buy_me_coffee-$5-informational?style=flat&color=blue)](https://www.buymeacoffee.com/VXqkQK5tb)

code-server optimized for WordPress development. Example YAML comes with pre-configured development tools: BrowserSync, phpMyAdmin, PHP_CodeSniffer, WordPress Coding Standard, and Xdebug.

<p align="center" style="max-width: 1024px"><img src="screenshot.png" width="100%"></p>

DEMYX | CODE-SERVER:BEDROCK
--- | ---
PORT | 3000 8080 9000 9001
USER | demyx
WORKDIR | /demyx
CONFIG | /etc/demyx
ENTRYPOINT | demyx-entrypoint
SHELL | zsh
SHELL THEME | powerlevel10k
WORDPRESS | https://domain.tld
CODE-SERVER | https://domain.tld/demyx/cs/
BROWSER-SYNC | https://domain.tld/demyx/bs/
PHPMYADMIN | https://domain.tld/demyx/pma/

## Usage

`code-server:sage` comes with a helper script that wraps yarn commands and also does other things.

```
demyx-sage <arg>        Sage helper script

           init         Initializes fixes for webpack
                        Ex: sage -t <theme> init

           help         Help menu for sage helper script
                        Ex: sage help

           new          Executes composer create-project, yarn, and sage -t <theme> init
                        Ex: sage -t <theme> new

           -t           Set the theme
                        Ex: sage -t <theme> add <package>
```

When you run `docker-compose up -d`, it will probably take up to 10 seconds or less on the first time to initialize the container. You can see the output in real time by running `docker logs demyx_sage -f` to see what's installing in that moment.

```
# docker logs demyx_sage -f
Creating demyx_cs    ... done
Success: WordPress installed successfully.
Success: Rewrite structure set.
Success: Rewrite rules flushed.
"[demyx] installing Sage..."
Success: Switched to 'Sage Starter Theme' theme.
info  Server listening on http://localhost:8080
info    - Using custom password for authentication
info    - Not serving HTTPS
```

* Configured for remote VPS
* Ports 80 and 443 must be open when using Traefik
* TLS/SSL enabled by default

```
# Demyx
# https://demyx.sh
#
# This docker-compose.yml is designed for VPS use with SSL/TLS first.
# Traefik requires no additional configurations and is ready to go.
# Be sure to change all the domain.tld domains and credentials before running docker-compose up -d.
#
networks:
  demyx:
    name: demyx
  demyx_socket:
    name: demyx_socket
services:
  demyx_db:
    container_name: demyx_db
    depends_on:
      - demyx_traefik
    environment:
      - DEMYX=/demyx
      - DEMYX_CHARACTER_SET_SERVER=utf8
      - DEMYX_COLLATION_SERVER=utf8_general_ci
      - DEMYX_CONFIG=/etc/demyx
      - DEMYX_DATABASE=demyx
      - DEMYX_DEFAULT_CHARACTER_SET=utf8
      - DEMYX_DOMAIN=domain.tld
      - DEMYX_INNODB_BUFFER_POOL_SIZE=16M
      - DEMYX_INNODB_DATA_FILE_PATH=ibdata1:10M:autoextend
      - DEMYX_INNODB_FILE_PER_TABLE=1
      - DEMYX_INNODB_FLUSH_LOG_AT_TRX_COMMIT=1
      - DEMYX_INNODB_LOCK_WAIT_TIMEOUT=50
      - DEMYX_INNODB_LOG_BUFFER_SIZE=8M
      - DEMYX_INNODB_LOG_FILE_SIZE=5M
      - DEMYX_INNODB_USE_NATIVE_AIO=1
      - DEMYX_KEY_BUFFER_SIZE=20M
      - DEMYX_LOG=/var/log/demyx
      - DEMYX_MAX_ALLOWED_PACKET=16M
      - DEMYX_MAX_CONNECTIONS=1000
      - DEMYX_MYISAM_SORT_BUFFER_SIZE=8M
      - DEMYX_NET_BUFFER_SIZE=8K
      - DEMYX_PASSWORD=demyx
      - DEMYX_READ_BUFFER=2M
      - DEMYX_READ_BUFFER_SIZE=256K
      - DEMYX_READ_RND_BUFFER_SIZE=512K
      - DEMYX_ROOT_PASSWORD=demyx_root  # Mandatory
      - DEMYX_SERVER_ID=1
      - DEMYX_SORT_BUFFER_SIZE=20M
      - DEMYX_TABLE_OPEN_CACHE=64
      - DEMYX_USERNAME=demyx
      - DEMYX_WRITE_BUFFER=2M
      - TZ=America/Los_Angeles
    image: demyx/mariadb
    networks:
      - demyx
    restart: unless-stopped
    volumes:
      - demyx_db:/demyx
      - demyx_log:/var/log/demyx
  demyx_nx:
    container_name: demyx_nx
    depends_on:
      - demyx_wp
    environment:
      - DEMYX=/demyx
      - DEMYX_BASIC_AUTH=false
      - DEMYX_BASIC_AUTH_HTPASSWD=false
      - DEMYX_BEDROCK=true
      - DEMYX_CACHE=false
      - DEMYX_CONFIG=/etc/demyx
      - DEMYX_DOMAIN=domain.tld
      - DEMYX_LOG=/var/log/demyx
      - DEMYX_RATE_LIMIT=false
      - DEMYX_UPLOAD_LIMIT=128M
      - DEMYX_WHITELIST=false
      - DEMYX_WHITELIST_IP=false
      - DEMYX_WHITELIST_TYPE=false
      - DEMYX_WORDPRESS=true
      - DEMYX_WORDPRESS_CONTAINER=demyx_wp
      - DEMYX_WORDPRESS_CONTAINER_PORT=9000
      - DEMYX_XMLRPC=false
      - TZ=America/Los_Angeles
    image: demyx/nginx
    labels:
      - "traefik.enable=true"
      - "traefik.http.middlewares.demyx-nx-redirect.redirectregex.permanent=true"
      - "traefik.http.middlewares.demyx-nx-redirect.redirectregex.regex=^https?:\/\/(?:www\\.)?(.+)"
      - "traefik.http.middlewares.demyx-nx-redirect.redirectregex.replacement=https://$${1}"
      - "traefik.http.routers.demyx-nx-http.entrypoints=http"
      - "traefik.http.routers.demyx-nx-http.middlewares=demyx-nx-redirect"
      - "traefik.http.routers.demyx-nx-http.rule=Host(`domain.tld`) || Host(`www.domain.tld`)"
      - "traefik.http.routers.demyx-nx-http.service=demyx-nx-http-port"
      - "traefik.http.routers.demyx-nx-https.entrypoints=https"
      - "traefik.http.routers.demyx-nx-https.rule=Host(`domain.tld`) || Host(`www.domain.tld`)" # WordPress https://domain.tld
      - "traefik.http.routers.demyx-nx-https.service=demyx-nx-https-port"
      - "traefik.http.routers.demyx-nx-https.tls.certresolver=demyx"
      - "traefik.http.services.demyx-nx-http-port.loadbalancer.server.port=80"
      - "traefik.http.services.demyx-nx-https-port.loadbalancer.server.port=80"
    networks:
      - demyx
    restart: unless-stopped
    volumes:
      - demyx_log:/var/log/demyx
      - demyx_wp:/demyx
  demyx_pma:
    container_name: demyx_pma
    environment:
      - MYSQL_ROOT_PASSWORD=demyx_root
      - PMA_ABSOLUTE_URI=https://domain.tld/demyx/pma/
      - PMA_HOST=demyx_db
    image: phpmyadmin/phpmyadmin
    networks:
      - demyx
    restart: unless-stopped
    depends_on:
      - demyx_wp
    labels:
      - "traefik.enable=true"
      - "traefik.http.middlewares.demyx-pma-prefix.stripprefix.prefixes=/demyx/pma/"
      - "traefik.http.routers.demyx-pma.entrypoints=https"
      - "traefik.http.routers.demyx-pma.middlewares=demyx-pma-prefix"
      - "traefik.http.routers.demyx-pma.priority=99"
      - "traefik.http.routers.demyx-pma.rule=Host(`domain.tld`) && PathPrefix(`/demyx/pma/`)" # phpMyAdmin https://domain.tld/demyx/pma/
      - "traefik.http.routers.demyx-pma.service=demyx-pma-port"
      - "traefik.http.routers.demyx-pma.tls.certresolver=demyx"
      - "traefik.http.services.demyx-pma-port.loadbalancer.server.port=80"
  demyx_socket:
    container_name: demyx_socket
    environment:
      - CONTAINERS=1
    image: demyx/docker-socket-proxy
    networks:
      - demyx_socket
    # Uncomment below if your host OS is CentOS/RHEL/Fedora
    #privileged: true
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
  demyx_traefik:
    container_name: demyx_traefik
    depends_on:
      - demyx_socket
    environment:
      # Uncomment below for Cloudflare DNS challenge
      #- CF_API_EMAIL=info@domain.tld
      #- CF_API_KEY=123456
      - DEMYX_ACME_EMAIL=info@domain.tld
      - DEMYX_TRAEFIK_LOG=INFO
      - TRAEFIK_PROVIDERS_DOCKER_ENDPOINT=tcp://demyx_socket:2375
    image: demyx/traefik
    labels:
      - "traefik.enable=true"
      - "traefik.http.middlewares.demyx-traefik-auth.basicauth.users=demyx:$$apr1$$L91z3CIR$$m/BKZcnQGBP.Uo2cJm8I0/" # Basic auth password: demyx
      - "traefik.http.middlewares.demyx-traefik-redirect.redirectscheme.scheme=https"
      - "traefik.http.routers.demyx-traefik-http.entrypoints=http"
      - "traefik.http.routers.demyx-traefik-http.middlewares=demyx-traefik-redirect"
      - "traefik.http.routers.demyx-traefik-http.rule=Host(`traefik.domain.tld`)"
      - "traefik.http.routers.demyx-traefik-http.service=demyx-traefik-http-port"
      - "traefik.http.routers.demyx-traefik-https.entrypoints=https"
      - "traefik.http.routers.demyx-traefik-https.middlewares=demyx-traefik-auth"
      - "traefik.http.routers.demyx-traefik-https.rule=Host(`traefik.domain.tld`)" # Traefik dashboard https://traefik.domain.tld
      - "traefik.http.routers.demyx-traefik-https.service=api@internal"
      - "traefik.http.routers.demyx-traefik-https.service=demyx-traefik-https-port"
      - "traefik.http.routers.demyx-traefik-https.tls.certresolver=demyx"
      - "traefik.http.services.demyx-traefik-http-port.loadbalancer.server.port=8080"
      - "traefik.http.services.demyx-traefik-https-port.loadbalancer.server.port=8080"
    networks:
      - demyx
      - demyx_socket
    ports:
      - 80:8081
      - 443:8082
    restart: unless-stopped
    volumes:
      - demyx_log:/var/log/demyx
      - demyx_traefik:/demyx
  demyx_wp:
    container_name: demyx_wp
    depends_on:
      - demyx_db
    environment:
      - DEMYX=/demyx
      - DEMYX_ADMIN_EMAIL=info@domain.tld
      - DEMYX_ADMIN_PASSWORD=demyx
      - DEMYX_ADMIN_USERNAME=demyx
      - DEMYX_BEDROCK=true
      - DEMYX_BEDROCK_MODE=development
      - DEMYX_CODE_AUTH=password
      - DEMYX_CODE_BIND_ADDR=0.0.0.0:8080
      - DEMYX_CODE_CONFIG=/home/demyx/.config/code-server
      - DEMYX_CODE_PASSWORD=demyx
      - DEMYX_CONFIG=/etc/demyx
      - DEMYX_DB_HOST=demyx_db
      - DEMYX_DB_NAME=demyx
      - DEMYX_DB_PASSWORD=demyx
      - DEMYX_DB_USER=demyx
      - DEMYX_DOMAIN=domain.tld
      - DEMYX_EMERGENCY_RESTART_INTERVAL=1m
      - DEMYX_EMERGENCY_RESTART_THRESHOLD=5
      - DEMYX_LOG=/var/log/demyx
      - DEMYX_MAX_EXECUTION_TIME=300
      - DEMYX_MEMORY=256M
      - DEMYX_OPCACHE=true
      - DEMYX_PM=ondemand
      - DEMYX_PM_MAX_CHILDREN=25
      - DEMYX_PM_MAX_REQUESTS=25000
      - DEMYX_PM_MAX_SPARE_SERVERS=20
      - DEMYX_PM_MIN_SPARE_SERVERS=5
      - DEMYX_PM_PROCESS_IDLE_TIMEOUT=3s
      - DEMYX_PM_START_SERVERS=5
      - DEMYX_PROCESS_CONTROL_TIMEOUT=10s
      - DEMYX_PROXY=demyx_nx
      - DEMYX_SSL=true
      - DEMYX_UPLOAD_LIMIT=128M
      - TZ=America/Los_Angeles
    hostname: demyx-wp
    image: demyx/code-server:bedrock
    labels:
      - "traefik.enable=true"
      - "traefik.http.middlewares.demyx-wp-bs-prefix.stripprefix.prefixes=/demyx/bs/"
      - "traefik.http.middlewares.demyx-wp-hotupdate-js-prefix.stripprefix.prefixes=/demyx/bs/app/themes/[a-z0-9]/dist/[a-z.0-9].hot-update.js"
      - "traefik.http.middlewares.demyx-wp-hotupdate-json-prefix.stripprefix.prefixes=/demyx/bs/app/themes/[a-z0-9]/dist/[a-z0-9].hot-update.json"
      - "traefik.http.middlewares.demyx-wp-prefix.stripprefix.prefixes=/demyx/cs/"
      - "traefik.http.middlewares.demyx-wp-socket-prefix.stripprefix.prefixes=/demyx/bs/browser-sync/socket.io/"
      - "traefik.http.middlewares.demyx-wp-webpack-prefix.stripprefix.prefixes=/demyx/bs/__webpack_hmr"
      - "traefik.http.routers.demyx-wp-bs.entrypoints=https"
      - "traefik.http.routers.demyx-wp-bs.middlewares=demyx-wp-bs-prefix"
      - "traefik.http.routers.demyx-wp-bs.priority=99"
      - "traefik.http.routers.demyx-wp-bs.rule=Host(`domain.tld`) && PathPrefix(`/demyx/bs/`)" # browsersync https://domain.tld/demyx/bs/
      - "traefik.http.routers.demyx-wp-bs.service=demyx-wp-bs"
      - "traefik.http.routers.demyx-wp-bs.tls.certresolver=demyx"
      - "traefik.http.routers.demyx-wp-hotupdate-js.entrypoints=https"
      - "traefik.http.routers.demyx-wp-hotupdate-js.middlewares=demyx-wp-hotupdate-js-prefix"
      - "traefik.http.routers.demyx-wp-hotupdate-js.priority=99"
      - "traefik.http.routers.demyx-wp-hotupdate-js.rule=Host(`domain.tld`) && PathPrefix(`/app/themes/{path:[a-z0-9]+}/dist/{hash:[a-z.0-9]+}.hot-update.js`)"
      - "traefik.http.routers.demyx-wp-hotupdate-js.service=demyx-wp-hotupdate-js"
      - "traefik.http.routers.demyx-wp-hotupdate-js.tls.certresolver=demyx"
      - "traefik.http.routers.demyx-wp-hotupdate-json.entrypoints=https"
      - "traefik.http.routers.demyx-wp-hotupdate-json.middlewares=demyx-wp-hotupdate-json-prefix"
      - "traefik.http.routers.demyx-wp-hotupdate-json.priority=99"
      - "traefik.http.routers.demyx-wp-hotupdate-json.rule=Host(`domain.tld`) && PathPrefix(`/app/themes/{path:[a-z0-9]+}/dist/{hash:[a-z0-9]+}.hot-update.json`)"
      - "traefik.http.routers.demyx-wp-hotupdate-json.service=demyx-wp-hotupdate-json"
      - "traefik.http.routers.demyx-wp-hotupdate-json.tls.certresolver=demyx"
      - "traefik.http.routers.demyx-wp-socket.entrypoints=https"
      - "traefik.http.routers.demyx-wp-socket.middlewares=demyx-wp-socket-prefix"
      - "traefik.http.routers.demyx-wp-socket.priority=99"
      - "traefik.http.routers.demyx-wp-socket.rule=Host(`domain.tld`) && PathPrefix(`/browser-sync/socket.io/`)"
      - "traefik.http.routers.demyx-wp-socket.service=demyx-wp-socket"
      - "traefik.http.routers.demyx-wp-socket.tls.certresolver=demyx"
      - "traefik.http.routers.demyx-wp-webpack.entrypoints=https"
      - "traefik.http.routers.demyx-wp-webpack.middlewares=demyx-wp-webpack-prefix"
      - "traefik.http.routers.demyx-wp-webpack.priority=99"
      - "traefik.http.routers.demyx-wp-webpack.rule=Host(`domain.tld`) && PathPrefix(`/__webpack_hmr`)"
      - "traefik.http.routers.demyx-wp-webpack.service=demyx-wp-webpack"
      - "traefik.http.routers.demyx-wp-webpack.tls.certresolver=demyx"
      - "traefik.http.routers.demyx-wp.entrypoints=https"
      - "traefik.http.routers.demyx-wp.middlewares=demyx-wp-prefix"
      - "traefik.http.routers.demyx-wp.priority=99"
      - "traefik.http.routers.demyx-wp.rule=Host(`domain.tld`) && PathPrefix(`/demyx/cs/`)" # code-server https://domain.tld/demyx/cs/
      - "traefik.http.routers.demyx-wp.service=demyx-wp-port"
      - "traefik.http.routers.demyx-wp.tls.certresolver=demyx"
      - "traefik.http.services.demyx-wp-bs.loadbalancer.server.port=3000"
      - "traefik.http.services.demyx-wp-hotupdate-js.loadbalancer.server.port=3000"
      - "traefik.http.services.demyx-wp-hotupdate-json.loadbalancer.server.port=3000"
      - "traefik.http.services.demyx-wp-port.loadbalancer.server.port=8080"
      - "traefik.http.services.demyx-wp-socket.loadbalancer.server.port=3000"
      - "traefik.http.services.demyx-wp-webpack.loadbalancer.server.port=3000"
    networks:
      - demyx
    restart: unless-stopped
    volumes:
      - demyx_code:/home/demyx
      - demyx_log:/var/log/demyx
      - demyx_wp:/demyx
version: "2.4"
volumes:
  demyx_code:
    name: demyx_code
  demyx_db:
    name: demyx_db
  demyx_log:
    name: demyx_log
  demyx_traefik:
    name: demyx_traefik
  demyx_wp:
    name: demyx_wp
```

## Updates & Support
* Auto built weekly on Saturdays (America/Los_Angeles)
* Rolling release updates
* For support: [#demyx](https://web.libera.chat/?channel=#demyx)
