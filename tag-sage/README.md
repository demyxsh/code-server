# code-server:sage

[![Architecture](https://img.shields.io/badge/linux-amd64-important?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Alpine](https://img.shields.io/badge/alpine-3.10.3-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![code-server](https://img.shields.io/badge/code--server-2.1523--vsc1.38.1-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Buy Me A Coffee](https://img.shields.io/badge/buy_me_coffee-$5-informational?style=flat&color=blue)](https://www.buymeacoffee.com/VXqkQK5tb)

Bootstraps an instance of Alpine Linux, code-server, WordPress, Sage, and Bedrock. SSL/TLS enabled with working webpack hot updates.

<p align="center" style="max-width: 1024px"><img src="https://i.imgur.com/7f0TwEa.png" width="100%"></p>

DEMYX | CODE-SERVER:SAGE
--- | ---
TAG | sage
USER<br />GROUP | www-data (82)<br />www-data (82)
WORKDIR | /var/www/html
PORT | 80 3000 8080 9000
ENTRYPOINT | s6-overlay
SHELL | zsh
SHELL THEME | Oh My Zsh "ys"
PACKAGES | composer gcc git gnupg htop jq mysql-client<br />nano npm openssh sudo util-linux zsh
WORDPRESS | https://domain.tld
CODE-SERVER | https://domain.tld/demyx/cs/
BROWSER-SYNC | https://domain.tld/demyx/bs/
PHPMYADMIN | https://domain.tld/demyx/pma/

## Updates & Support

[![Code Size](https://img.shields.io/github/languages/code-size/demyxco/code-server?style=flat&color=blue)](https://github.com/demyxco/code-server)
[![Repository Size](https://img.shields.io/github/repo-size/demyxco/code-server?style=flat&color=blue)](https://github.com/demyxco/code-server)
[![Watches](https://img.shields.io/github/watchers/demyxco/code-server?style=flat&color=blue)](https://github.com/demyxco/code-server)
[![Stars](https://img.shields.io/github/stars/demyxco/code-server?style=flat&color=blue)](https://github.com/demyxco/code-server)
[![Forks](https://img.shields.io/github/forks/demyxco/code-server?style=flat&color=blue)](https://github.com/demyxco/code-server)

* Auto built weekly on Sundays (America/Los_Angeles)
* Rolling release updates
* For support: [#demyx](https://webchat.freenode.net/?channel=#demyx)

## Environment Variables

### demyx_sage

ENVIRONMENT | VALUE 
--- | ---
PASSWORD | demyx
CODER_BASE_PATH | /demyx/cs
WORDPRESS_DB_NAME | demyx
WORDPRESS_DB_USER | demyx
WORDPRESS_DB_PASSWORD | demyx
WORDPRESS_DB_HOST | demyx_sage_db
WORDPRESS_DOMAIN | domain.tld
WORDPRESS_USER | demyx
WORDPRESS_USER_EMAIL | info@domain.tld
WORDPRESS_SSL | true
WORDPRESS_UPLOAD_LIMIT | 128M
WORDPRESS_PHP_MEMORY | 256M
WORDPRESS_PHP_MAX_EXECUTION_TIME | 300
WORDPRESS_PHP_OPCACHE | off
WORDPRESS_NGINX_CACHE | off
WORDPRESS_NGINX_RATE_LIMIT | off
WORDPRESS_NGINX_XMLRPC | off
TZ | America/Los_Angeles

### demyx_sage_db

ENVIRONMENT | VALUE 
--- | ---
MARIADB_DATABASE | demyx
MARIADB_USERNAME | demyx
MARIADB_PASSWORD | demyx
MARIADB_ROOT_PASSWORD | demyx # Required
MARIADB_BINLOG_FORMAT | mixed
MARIADB_CHARACTER_SET_SERVER | utf8
MARIADB_COLLATION_SERVER | utf8_general_ci
MARIADB_DEFAULT_CHARACTER_SET | utf8
MARIADB_INNODB_BUFFER_POOL_SIZE | 16M
MARIADB_INNODB_DATA_FILE_PATH | ibdata1:10M:autoextend
MARIADB_INNODB_FLUSH_LOG_AT_TRX_COMMIT | 1
MARIADB_INNODB_LOCK_WAIT_TIMEOUT | 50
MARIADB_INNODB_LOG_BUFFER_SIZE | 8M
MARIADB_INNODB_LOG_FILE_SIZE | 5M
MARIADB_INNODB_USE_NATIVE_AIO | 1
MARIADB_KEY_BUFFER_SIZE | 20M
MARIADB_LOG_BIN | mysql-bin
MARIADB_MAX_ALLOWED_PACKET | 16M
MARIADB_MAX_CONNECTIONS | 151
MARIADB_MYISAM_SORT_BUFFER_SIZE | 8M
MARIADB_NET_BUFFER_SIZE | 8K
MARIADB_READ_BUFFER | 2M
MARIADB_READ_BUFFER_SIZE | 256K
MARIADB_READ_RND_BUFFER_SIZE | 512K
MARIADB_SERVER_ID | 1
MARIADB_SORT_BUFFER_SIZE | 20M
MARIADB_TABLE_OPEN_CACHE | 64
MARIADB_WRITE_BUFFER | 2M
TZ | America/Los_Angeles

### demyx_pma

ENVIRONMENT | VALUE
--- | ---
PMA_HOST | demyx_sage_db
MYSQL_ROOT_PASSWORD | demyx
PMA_ABSOLUTE_URI | https://domain.tld/demyx/pma/

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

### docker-compose.yml

When you run `docker-compose up -d`, it will probably take 10 seconds or less on the first time to initialize the container. You can see the output in real time by running `docker logs demyx_sage -f` to see what's installing in that moment.

```
docker logs demyx_sage -f            
[s6-init] making user provided files available at /var/run/s6/etc...exited 0.
[s6-init] ensuring user provided files have correct perms...exited 0.
[fix-attrs.d] applying ownership & permissions fixes...
[fix-attrs.d] done.
[cont-init.d] executing container initialization scripts...
[cont-init.d] 00-init: executing... 
[demyx] installing WordPress...
Success: WordPress installed successfully.
Success: Rewrite structure set.
Success: Rewrite rules flushed.
[demyx] installing Sage...
Success: Switched to 'Sage Starter Theme' theme.
[demyx] installing demyx-browsersync mu plugin...
[cont-init.d] 00-init: exited 0.
[cont-init.d] done.
[services.d] starting services
[services.d] done.
2019/10/10 13:53:52 [notice] 461#461: using the "epoll" event method
2019/10/10 13:53:52 [notice] 461#461: nginx/1.17.4
2019/10/10 13:53:52 [notice] 461#461: built by gcc 8.3.0 (Alpine 8.3.0) 
2019/10/10 13:53:52 [notice] 461#461: OS: Linux 4.19.75-0-vanilla
2019/10/10 13:53:52 [notice] 461#461: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2019/10/10 13:53:52 [notice] 461#461: start worker processes
2019/10/10 13:53:52 [notice] 461#461: start worker process 464
2019/10/10 13:53:52 [notice] 464#464: sched_setaffinity(): using cpu #0
[10-Oct-2019 13:53:52] NOTICE: fpm is running, pid 462
[10-Oct-2019 13:53:52] NOTICE: ready to handle connections
info  Server listening on http://localhost:8080
info    - Using custom password for authentication
info    - Not serving HTTPS
```

* Configured for remote VPS
* Ports 80 and 443 must be open when using Traefik
* TLS/SSL enabled by default

```
version: "3.7"
services:
  traefik:
    image: traefik
    container_name: demyx_traefik
    restart: unless-stopped
    networks:
      - demyx
    ports:
      - 80:80
      - 443:443
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - demyx_traefik:/demyx
    environment:
      - TRAEFIK_API=true
      - TRAEFIK_PROVIDERS_DOCKER=true
      - TRAEFIK_PROVIDERS_DOCKER_EXPOSEDBYDEFAULT=false
      - TRAEFIK_ENTRYPOINTS_HTTP_ADDRESS=:80
      - TRAEFIK_ENTRYPOINTS_HTTPS_ADDRESS=:443
      # Only one acme challenege can be activated at a time
      - TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_HTTPCHALLENGE=true
      - TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_HTTPCHALLENGE_ENTRYPOINT=http
      - TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_DNSCHALLENGE=false # Set to true and http challenge to false if you want to use Cloudflare as the certificate resolver
      - TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_DNSCHALLENGE_PROVIDER=cloudflare
      - TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_DNSCHALLENGE_DELAYBEFORECHECK=0
      - TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_DNSCHALLENGE_RESOLVERS=1.1.1.1
      - CF_API_EMAIL=
      - CF_API_KEY=
      - TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_EMAIL=info@domain.tld
      - TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_STORAGE=/demyx/acme.json
      - TRAEFIK_LOG=true
      - TRAEFIK_LOG_LEVEL=INFO
      - TRAEFIK_LOG_FILEPATH=/demyx/error.log
      - TRAEFIK_ACCESSLOG=true
      - TRAEFIK_ACCESSLOG_FILEPATH=/demyx/access.log
      - TZ=America/Los_Angeles
    labels:
      - "traefik.enable=true"
      # Traefik dashboard with basic auth protection https://traefik.domain.tld
      - "traefik.http.routers.traefik-http.rule=Host(`traefik.domain.tld`)"
      - "traefik.http.routers.traefik-http.service=api@internal"
      - "traefik.http.routers.traefik-http.entrypoints=http"
      - "traefik.http.routers.traefik-http.middlewares=traefik-redirect"
      - "traefik.http.routers.traefik-https.rule=Host(`traefik.domain.tld`)"
      - "traefik.http.routers.traefik-https.entrypoints=https"
      - "traefik.http.routers.traefik-https.service=api@internal"
      - "traefik.http.routers.traefik-https.tls.certresolver=demyx"
      - "traefik.http.routers.traefik-https.middlewares=traefik-auth"
      - "traefik.http.middlewares.traefik-auth.basicauth.users=demyx:$$apr1$$EqJj89Yw$$WLsBIjCILtBGjHppQ76YT1" # Password: demyx
      - "traefik.http.middlewares.traefik-redirect.redirectscheme.scheme=https"
  demyx_sage_db:
    container_name: demyx_sage_db
    image: demyx/mariadb
    restart: unless-stopped
    networks:
      - demyx
    volumes:
      - demyx_sage_db:/var/lib/mysql
    environment:
      - MARIADB_DATABASE=demyx
      - MARIADB_USERNAME=demyx
      - MARIADB_PASSWORD=demyx
      - MARIADB_ROOT_PASSWORD=demyx # Required
      - MARIADB_BINLOG_FORMAT=mixed
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
      - MARIADB_LOG_BIN=mysql-bin
      - MARIADB_MAX_ALLOWED_PACKET=16M
      - MARIADB_MAX_CONNECTIONS=151
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
  demyx_sage:
    image: demyx/code-server:sage
    container_name: demyx_sage
    hostname: demyx_sage # Used for webpack and code-server
    restart: unless-stopped
    networks:
      - demyx
    volumes:
      - demyx_sage:/var/www/html
      - demyx_sage_user:/home/www-data
    depends_on:
      - demyx_sage_db
    environment:
      - PASSWORD=demyx # Password for code-server and wp
      - CODER_BASE_PATH=/demyx/cs # https://domain.tld/demyx/cs/
      - WORDPRESS_DB_NAME=demyx
      - WORDPRESS_DB_USER=demyx
      - WORDPRESS_DB_PASSWORD=demyx
      - WORDPRESS_DB_HOST=demyx_sage_db
      - WORDPRESS_DOMAIN=domain.tld
      - WORDPRESS_USER=demyx
      - WORDPRESS_USER_EMAIL=info@domain.tld
      - WORDPRESS_SSL=true
      - WORDPRESS_UPLOAD_LIMIT=128M
      - WORDPRESS_PHP_MEMORY=256M
      - WORDPRESS_PHP_MAX_EXECUTION_TIME=300
      - WORDPRESS_PHP_OPCACHE=off
      - WORDPRESS_NGINX_CACHE=off
      - WORDPRESS_NGINX_RATE_LIMIT=off
      - WORDPRESS_NGINX_XMLRPC=off
      - TZ=America/Los_Angeles
    labels:
      - "traefik.enable=true"
      # wordpress https://domain.tld
      - "traefik.http.routers.sage-http.rule=Host(`domain.tld`) || Host(`www.domain.tld`)"
      - "traefik.http.routers.sage-http.entrypoints=http"
      - "traefik.http.routers.sage-http.middlewares=sage-redirect"
      - "traefik.http.routers.sage-http.service=sage-http"
      - "traefik.http.routers.sage-https.rule=Host(`domain.tld`)"
      - "traefik.http.routers.sage-https.entrypoints=https"
      - "traefik.http.routers.sage-https.tls.certresolver=demyx"
      - "traefik.http.routers.sage-https.service=sage-https"
      - "traefik.http.services.sage-http.loadbalancer.server.port=80"
      - "traefik.http.services.sage-https.loadbalancer.server.port=80"
      - "traefik.http.middlewares.sage-redirect.redirectscheme.scheme=https"
      # code-server https://domain.tld/demyx/cs/
      - "traefik.http.routers.sage-cs.rule=(Host(`domain.tld`) && PathPrefix(`/demyx/cs/`))"
      - "traefik.http.routers.sage-cs.middlewares=sage-cs-prefix"
      - "traefik.http.routers.sage-cs.entrypoints=https"
      - "traefik.http.routers.sage-cs.tls.certresolver=demyx"
      - "traefik.http.routers.sage-cs.service=sage-cs"
      - "traefik.http.middlewares.sage-cs-prefix.stripprefix.prefixes=/demyx/cs/"
      - "traefik.http.services.sage-cs.loadbalancer.server.port=8080"
      # browser-sync https://domain.tld/demyx/bs/
      - "traefik.http.routers.sage-bs.rule=(Host(`domain.tld`) && PathPrefix(`/demyx/bs/`))"
      - "traefik.http.routers.sage-bs.middlewares=sage-bs-prefix"
      - "traefik.http.routers.sage-bs.entrypoints=https"
      - "traefik.http.routers.sage-bs.tls.certresolver=demyx"
      - "traefik.http.routers.sage-bs.service=sage-bs"
      - "traefik.http.middlewares.sage-bs-prefix.stripprefix.prefixes=/demyx/bs/"
      - "traefik.http.services.sage-bs.loadbalancer.server.port=3000"
      # browser-sync socket
      - "traefik.http.routers.sage-socket.rule=(Host(`domain.tld`) && PathPrefix(`/browser-sync/socket.io/`))"
      - "traefik.http.routers.sage-socket.middlewares=sage-socket-prefix"
      - "traefik.http.routers.sage-socket.entrypoints=https"
      - "traefik.http.routers.sage-socket.tls.certresolver=demyx"
      - "traefik.http.routers.sage-socket.service=sage-socket"
      - "traefik.http.middlewares.sage-socket-prefix.stripprefix.prefixes=/demyx/bs/browser-sync/socket.io/"
      - "traefik.http.services.sage-socket.loadbalancer.server.port=3000"
      # webpack
      - "traefik.http.routers.sage-webpack.rule=(Host(`domain.tld`) && PathPrefix(`/__webpack_hmr`))"
      - "traefik.http.routers.sage-webpack.middlewares=sage-webpack-prefix"
      - "traefik.http.routers.sage-webpack.entrypoints=https"
      - "traefik.http.routers.sage-webpack.tls.certresolver=demyx"
      - "traefik.http.routers.sage-webpack.service=sage-webpack"
      - "traefik.http.middlewares.sage-webpack-prefix.stripprefix.prefixes=/demyx/bs/__webpack_hmr"
      - "traefik.http.services.sage-webpack.loadbalancer.server.port=3000"
      # hot-update.js
      - "traefik.http.routers.sage-hotupdate-js.rule=(Host(`domain.tld`) && PathPrefix(`/app/themes/{path:[a-z0-9]+}/dist/{hash:[a-z.0-9]+}.hot-update.js`))"
      - "traefik.http.routers.sage-hotupdate-js.middlewares=sage-hotupdate-js-prefix"
      - "traefik.http.routers.sage-hotupdate-js.entrypoints=https"
      - "traefik.http.routers.sage-hotupdate-js.tls.certresolver=demyx"
      - "traefik.http.routers.sage-hotupdate-js.service=sage-hotupdate-js"
      - "traefik.http.middlewares.sage-hotupdate-js-prefix.stripprefix.prefixes=/demyx/bs/app/themes/[a-z0-9]/dist/[a-z.0-9].hot-update.js"
      - "traefik.http.services.sage-hotupdate-js.loadbalancer.server.port=3000"
      # hot-update.json
      - "traefik.http.routers.sage-hotupdate-json.rule=(Host(`domain.tld`) && PathPrefix(`/app/themes/{path:[a-z0-9]+}/dist/{hash:[a-z0-9]+}.hot-update.json`))"
      - "traefik.http.routers.sage-hotupdate-json.middlewares=sage-hotupdate-json-prefix"
      - "traefik.http.routers.sage-hotupdate-json.entrypoints=https"
      - "traefik.http.routers.sage-hotupdate-json.tls.certresolver=demyx"
      - "traefik.http.routers.sage-hotupdate-json.service=sage-hotupdate-json"
      - "traefik.http.middlewares.sage-hotupdate-json-prefix.stripprefix.prefixes=/demyx/bs/app/themes/[a-z0-9]/dist/[a-z0-9].hot-update.json"
      - "traefik.http.services.sage-hotupdate-json.loadbalancer.server.port=3000"
  demyx_pma:
    image: phpmyadmin/phpmyadmin
    container_name: demyx_pma
    restart: unless-stopped
    networks:
      - demyx
    depends_on:
      - demyx_sage_db
    environment:
      - PMA_HOST=demyx_sage_db
      - MYSQL_ROOT_PASSWORD=demyx
      - PMA_ABSOLUTE_URI=https://domain.tld/demyx/pma/
    labels:
      - "traefik.enable=true"
      # phpmyadmin https://domain.tld/demyx/pma/
      - "traefik.http.routers.sage-pma.rule=(Host(`domain.tld`) && PathPrefix(`/demyx/pma/`))"
      - "traefik.http.routers.sage-pma.middlewares=sage-pma-prefix"
      - "traefik.http.routers.sage-pma.entrypoints=https"
      - "traefik.http.routers.sage-pma.tls.certresolver=demyx"
      - "traefik.http.middlewares.sage-pma-prefix.stripprefix.prefixes=/demyx/pma/"
volumes:
  demyx_sage:
    name: demyx_sage
  demyx_sage_db:
    name: demyx_sage_db
  demyx_sage_user:
    name: demyx_sage_user
  demyx_traefik:
    name: demyx_traefik
networks:
  demyx:
    name: demyx
```
