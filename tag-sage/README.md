# code-server:sage

[![Architecture](https://img.shields.io/badge/linux-amd64-important?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Debian](https://img.shields.io/badge/debian-10.4-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![code-server](https://img.shields.io/badge/code--server-3.4.1-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Buy Me A Coffee](https://img.shields.io/badge/buy_me_coffee-$5-informational?style=flat&color=blue)](https://www.buymeacoffee.com/VXqkQK5tb)

code-server optimized for WordPress development. Example YAML comes with pre-configured development tools: BrowserSync, phpMyAdmin, PHP_CodeSniffer, WordPress Coding Standard, and Xdebug.

<p align="center" style="max-width: 1024px"><img src="https://i.imgur.com/YylWFHJ.png" width="100%"></p>

DEMYX | CODE-SERVER:SAGE
--- | ---
PORT | 8080 9000 9001
USER | demyx
WORKDIR | /demyx
CONFIG | /etc/demyx
ENTRYPOINT | ["demyx-entrypoint"]
SHELL | zsh
SHELL THEME | Oh My Zsh "ys"
WORDPRESS | https://domain.tld
CODE-SERVER | https://domain.tld/demyx/cs/
BROWSER-SYNC | https://domain.tld/demyx/bs/
PHPMYADMIN | https://domain.tld/demyx/pma/

## Usage

`code-server:sage` comes with a helper script that wraps yarn commands and also does other things.

```
sage <arg>        Sage helper script

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
version: "3.7"
services:
  demyx_socket:
    # Uncomment below if your host OS is CentOS/RHEL/Fedora
    #privileged: true
    image: demyx/docker-socket-proxy
    container_name: demyx_socket
    restart: unless-stopped
    networks:
      - demyx_socket
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
    environment:
      - CONTAINERS=1
  demyx_traefik:
    image: demyx/traefik
    container_name: demyx_traefik
    restart: unless-stopped
    depends_on: 
      - demyx_socket
    networks:
      - demyx
      - demyx_socket
    ports:
      - 80:8081
      - 443:8082
    volumes:
      - demyx_traefik:/demyx
      - demyx_log:/var/log/demyx
    environment:
      - TRAEFIK_PROVIDERS_DOCKER_ENDPOINT=tcp://demyx_socket:2375
      - TRAEFIK_API=true
      - TRAEFIK_PROVIDERS_DOCKER=true
      - TRAEFIK_PROVIDERS_DOCKER_EXPOSEDBYDEFAULT=false
      # Uncomment if using Cloudflare to get client real IP
      #- TRAEFIK_ENTRYPOINTS_HTTPS_FORWARDEDHEADERS_TRUSTEDIPS=173.245.48.0/20,103.21.244.0/22,103.22.200.0/22,103.31.4.0/22,141.101.64.0/18,108.162.192.0/18,190.93.240.0/20,188.114.96.0/20,197.234.240.0/22,198.41.128.0/17,162.158.0.0/15,104.16.0.0/12,172.64.0.0/13,131.0.72.0/22
      - TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_HTTPCHALLENGE=true
      - TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_HTTPCHALLENGE_ENTRYPOINT=http
      - TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_EMAIL=info@domain.tld
      - TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_STORAGE=/demyx/acme.json
      - TRAEFIK_LOG=true
      - TRAEFIK_LOG_LEVEL=INFO
      - TRAEFIK_LOG_FILEPATH=/demyx/error.log
      - TRAEFIK_ACCESSLOG=true
      - TRAEFIK_ACCESSLOG_FILEPATH=/demyx/access.log
      - TZ=America/Los_Angeles
    labels:
      # Traefik Dashboard - https://traefik.domain.tld
      - "traefik.enable=true"
      - "traefik.http.middlewares.traefik-redirect.redirectscheme.scheme=https"
      - "traefik.http.routers.traefik-redirect.rule=hostregexp(`{host:.+}`)"
      - "traefik.http.routers.traefik-redirect.entrypoints=http"
      - "traefik.http.routers.traefik-redirect.middlewares=traefik-redirect"
      - "traefik.http.routers.traefik-http.rule=Host(`traefik.domain.tld`)" 
      - "traefik.http.routers.traefik-http.entrypoints=https"
      - "traefik.http.routers.traefik-http.service=api@internal"
      - "traefik.http.routers.traefik-http.tls.certresolver=demyx"
      - "traefik.http.routers.traefik-http.middlewares=traefik-http-auth"
      - "traefik.http.middlewares.traefik-http-auth.basicauth.users=demyx:$$apr1$$EqJj89Yw$$WLsBIjCILtBGjHppQ76YT1" # Password: demyx
  demyx_wp:
    container_name: demyx_wp
    image: demyx/code-server:sage
    restart: unless-stopped
    hostname: domaintld
    networks:
      - demyx
    depends_on:
      - demyx_wp
    volumes:
      - demyx_cs:/home/demyx
      - demyx_wp:/demyx
      - demyx_log:/var/log/demyx
    environment:
      - PASSWORD=demyx
      - CODE_ROOT=/demyx
      - CODE_CONFIG=/etc/demyx
      - CODE_LOG=/var/log/demyx
      - BROWSERSYNC_PROXY=demyx_nx
      - WORDPRESS_DB_HOST=demyx_db
      - WORDPRESS_DB_NAME=demyx
      - WORDPRESS_DB_USER=demyx
      - WORDPRESS_DB_PASSWORD=demyx
      - WORDPRESS_ADMIN_USER=demyx
      - WORDPRESS_ADMIN_PASSWORD=demyx
      - WORDPRESS_ADMIN_EMAIL=info@domain.tld
      - WORDPRESS_DOMAIN=domain.tld
      - WORDPRESS_BEDROCK_MODE=development
      - WORDPRESS_SSL=true
      - WORDPRESS_UPLOAD_LIMIT=128M
      - WORDPRESS_PHP_MEMORY=256M
      - WORDPRESS_PHP_MAX_EXECUTION_TIME=300
      - WORDPRESS_PHP_PM=ondemand
      - WORDPRESS_PHP_PM_MAX_CHILDREN=25
      - WORDPRESS_PHP_PM_START_SERVERS=5
      - WORDPRESS_PHP_PM_MIN_SPARE_SERVERS=5
      - WORDPRESS_PHP_PM_MAX_SPARE_SERVERS=20
      - WORDPRESS_PHP_PM_PROCESS_IDLE_TIMEOUT=3s
      - WORDPRESS_PHP_PM_MAX_REQUESTS=1000
      - TZ=America/Los_Angeles
    labels:
      # code-server https://domain.tld/demyx/cs/
      - "traefik.enable=true"
      - "traefik.http.routers.domaintld-cs.rule=(Host(`domain.tld`) && PathPrefix(`/demyx/cs/`))"
      - "traefik.http.routers.domaintld-cs.entrypoints=https"
      - "traefik.http.routers.domaintld-cs.middlewares=domaintld-cs-prefix"
      - "traefik.http.middlewares.domaintld-cs-prefix.stripprefix.prefixes=/demyx/cs/"
      - "traefik.http.routers.domaintld-cs.service=domaintld-cs"
      - "traefik.http.services.domaintld-cs.loadbalancer.server.port=8080"
      - "traefik.http.routers.domaintld-cs.priority=99"
      - "traefik.http.routers.domaintld-cs.tls.certresolver=demyx"
      # browser-sync https://domain.tld/demyx/bs/
      - "traefik.http.routers.domaintld-bs.rule=(Host(`domain.tld`) && PathPrefix(`/demyx/bs/`))"
      - "traefik.http.routers.domaintld-bs.entrypoints=https"
      - "traefik.http.routers.domaintld-bs.middlewares=domaintld-bs-prefix"
      - "traefik.http.middlewares.domaintld-bs-prefix.stripprefix.prefixes=/demyx/bs/"
      - "traefik.http.routers.domaintld-bs.service=domaintld-bs"
      - "traefik.http.services.domaintld-bs.loadbalancer.server.port=3000"
      - "traefik.http.routers.domaintld-bs.priority=99"
      - "traefik.http.routers.domaintld-bs.tls.certresolver=demyx"
      # browser-sync socket
      - "traefik.http.routers.domaintld-socket.rule=(Host(`domain.tld`) && PathPrefix(`/browser-sync/socket.io/`))"
      - "traefik.http.routers.domaintld-socket.entrypoints=https"
      - "traefik.http.routers.domaintld-socket.middlewares=domaintld-socket-prefix"
      - "traefik.http.middlewares.domaintld-socket-prefix.stripprefix.prefixes=/demyx/bs/browser-sync/socket.io/"
      - "traefik.http.routers.domaintld-socket.service=domaintld-socket"
      - "traefik.http.services.domaintld-socket.loadbalancer.server.port=3000"
      - "traefik.http.routers.domaintld-socket.priority=99"
      - "traefik.http.routers.domaintld-socket.tls.certresolver=demyx"
      # webpack
      - "traefik.http.routers.domaintld-webpack.rule=(Host(`domain.tld`) && PathPrefix(`/__webpack_hmr`))"
      - "traefik.http.routers.domaintld-webpack.entrypoints=https"
      - "traefik.http.routers.domaintld-webpack.middlewares=domaintld-webpack-prefix"
      - "traefik.http.middlewares.domaintld-webpack-prefix.stripprefix.prefixes=/demyx/bs/__webpack_hmr"
      - "traefik.http.routers.domaintld-webpack.service=domaintld-webpack"
      - "traefik.http.services.domaintld-webpack.loadbalancer.server.port=3000"
      - "traefik.http.routers.domaintld-webpack.priority=99"
      - "traefik.http.routers.domaintld-webpack.tls.certresolver=demyx"
      # hot-update.js
      - "traefik.http.routers.domaintld-hotupdate-js.rule=(Host(`domain.tld`) && PathPrefix(`/app/themes/{path:[a-z0-9]+}/dist/{hash:[a-z.0-9]+}.hot-update.js`))"
      - "traefik.http.routers.domaintld-hotupdate-js.entrypoints=https"
      - "traefik.http.routers.domaintld-hotupdate-js.middlewares=domaintld-hotupdate-js-prefix"
      - "traefik.http.middlewares.domaintld-hotupdate-js-prefix.stripprefix.prefixes=/demyx/bs/app/themes/[a-z0-9]/dist/[a-z.0-9].hot-update.js"
      - "traefik.http.routers.domaintld-hotupdate-js.service=domaintld-hotupdate-js"
      - "traefik.http.services.domaintld-hotupdate-js.loadbalancer.server.port=3000"
      - "traefik.http.routers.domaintld-hotupdate-js.priority=99"
      - "traefik.http.routers.domaintld-hotupdate-js.tls.certresolver=demyx"
      # hot-update.json
      - "traefik.http.routers.domaintld-hotupdate-json.rule=(Host(`domain.tld`) && PathPrefix(`/app/themes/{path:[a-z0-9]+}/dist/{hash:[a-z0-9]+}.hot-update.json`))"
      - "traefik.http.routers.domaintld-hotupdate-json.entrypoints=https"
      - "traefik.http.routers.domaintld-hotupdate-json.middlewares=domaintld-hotupdate-json-prefix"
      - "traefik.http.middlewares.domaintld-hotupdate-json-prefix.stripprefix.prefixes=/demyx/bs/app/themes/[a-z0-9]/dist/[a-z0-9].hot-update.json"
      - "traefik.http.routers.domaintld-hotupdate-json.service=domaintld-hotupdate-json"
      - "traefik.http.services.domaintld-hotupdate-json.loadbalancer.server.port=3000"
      - "traefik.http.routers.domaintld-hotupdate-json.priority=99"
      - "traefik.http.routers.domaintld-hotupdate-json.tls.certresolver=demyx"
  demyx_db:
    container_name: demyx_db
    image: demyx/mariadb:edge
    restart: unless-stopped
    depends_on:
      - demyx_traefik
    networks:
      - demyx
    volumes:
      - demyx_db:/demyx
    environment:
      - MARIADB_DATABASE=demyx
      - MARIADB_USERNAME=demyx
      - MARIADB_PASSWORD=demyx
      - MARIADB_ROOT_PASSWORD=demyx # Mandatory
      - MARIADB_ROOT=/demyx
      - MARIADB_CONFIG=/etc/demyx
      - MARIADB_LOG=/var/log/demyx
      - MARIADB_CHARACTER_SET_SERVER=utf8
      - MARIADB_COLLATION_SERVER=utf8_general_ci
      - MARIADB_DEFAULT_CHARACTER_SET=utf8
      - MARIADB_INNODB_BUFFER_POOL_SIZE=16M
      - MARIADB_INNODB_DATA_FILE_PATH=ibdata1:10M:autoextend
      - MARIADB_INNODB_FLUSH_LOG_AT_TRX_COMMIT=1
      - MARIADB_INNODB_LOCK_WAIT_TIMEOUT=50
      - MARIADB_INNODB_LOG_BUFFER_SIZE=8M
      - MARIADB_INNODB_LOG_FILE_SIZE=5M
      - MARIADB_INNODB_USE_NATIVE_AIO=1
      - MARIADB_KEY_BUFFER_SIZE=20M
      - MARIADB_MAX_ALLOWED_PACKET=16M
      - MARIADB_MAX_CONNECTIONS=500
      - MARIADB_MYISAM_SORT_BUFFER_SIZE=8M
      - MARIADB_NET_BUFFER_SIZE=8K
      - MARIADB_READ_BUFFER=2M
      - MARIADB_READ_BUFFER_SIZE=256K
      - MARIADB_READ_RND_BUFFER_SIZE=512K
      - MARIADB_SERVER_ID=1
      - MARIADB_SORT_BUFFER_SIZE=20M
      - MARIADB_TABLE_OPEN_CACHE=64
      - MARIADB_WRITE_BUFFER=2M
      - TZ=America/Los_Angeles
  demyx_nx:
    container_name: demyx_nx
    image: demyx/nginx
    restart: unless-stopped
    networks:
      - demyx
    depends_on:
      - demyx_wp
    volumes:
      - demyx_wp:/demyx
      - demyx_log:/var/log/demyx
    environment:
      - WORDPRESS=true
      - WORDPRESS_BEDROCK=true
      - WORDPRESS_CONTAINER=demyx_wp
      - WORDPRESS_CONTAINER_PORT=9000
      - NGINX_ROOT=/demyx
      - NGINX_CONFIG=/etc/demyx
      - NGINX_LOG=/var/log/demyx
      - NGINX_DOMAIN=domain.tld
      - NGINX_CACHE=false
      - NGINX_UPLOAD_LIMIT=128M
      - NGINX_RATE_LIMIT=false
      - NGINX_XMLRPC=false
      - TZ=America/Los_Angeles
    labels:
      # wordpress https://domain.tld
      - "traefik.enable=true"
      - "traefik.http.routers.domaintld-http.rule=Host(`domain.tld`) || Host(`www.domain.tld`)"
      - "traefik.http.routers.domaintld-http.entrypoints=http"
      - "traefik.http.routers.domaintld-http.middlewares=domaintld-redirect"
      - "traefik.http.middlewares.domaintld-redirect.redirectscheme.scheme=https"
      - "traefik.http.routers.domaintld-https.rule=Host(`domain.tld`) || Host(`www.domain.tld`)"
      - "traefik.http.routers.domaintld-https.entrypoints=https"
      - "traefik.http.routers.domaintld-https.tls.certresolver=demyx"
  demyx_pma:
    image: phpmyadmin/phpmyadmin
    container_name: demyx_pma
    restart: unless-stopped
    networks:
      - demyx
    depends_on:
      - demyx_wp
    environment:
      - PMA_HOST=demyx_db
      - MYSQL_ROOT_PASSWORD=demyx
      - PMA_ABSOLUTE_URI=https://domain.tld/demyx/pma/
    labels:
      # phpmyadmin https://domain.tld/demyx/pma/
      - "traefik.enable=true"
      - "traefik.http.routers.domaintld-pma.rule=(Host(`domain.tld`) && PathPrefix(`/demyx/pma/`))"
      - "traefik.http.routers.domaintld-pma.entrypoints=https"
      - "traefik.http.routers.domaintld-pma.middlewares=domaintld-pma-prefix"
      - "traefik.http.middlewares.domaintld-pma-prefix.stripprefix.prefixes=/demyx/pma/"
      - "traefik.http.routers.domaintld-pma.priority=99"
      - "traefik.http.routers.domaintld-pma.tls.certresolver=demyx"
  
volumes:
  demyx_cs:
    name: demyx_cs
  demyx_db:
    name: demyx_db
  demyx_log:
    name: demyx_log
  demyx_traefik:
    name: demyx_traefik
  demyx_wp:
    name: demyx_wp
networks:
  demyx:
    name: demyx
  demyx_socket:
    name: demyx_socket
```

## Updates & Support

[![Code Size](https://img.shields.io/github/languages/code-size/demyxco/code-server?style=flat&color=blue)](https://github.com/demyxco/code-server)
[![Repository Size](https://img.shields.io/github/repo-size/demyxco/code-server?style=flat&color=blue)](https://github.com/demyxco/code-server)
[![Watches](https://img.shields.io/github/watchers/demyxco/code-server?style=flat&color=blue)](https://github.com/demyxco/code-server)
[![Stars](https://img.shields.io/github/stars/demyxco/code-server?style=flat&color=blue)](https://github.com/demyxco/code-server)
[![Forks](https://img.shields.io/github/forks/demyxco/code-server?style=flat&color=blue)](https://github.com/demyxco/code-server)

* Auto built weekly on Saturdays (America/Los_Angeles)
* Rolling release updates
* For support: [#demyx](https://webchat.freenode.net/?channel=#demyx)
