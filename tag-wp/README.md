# code-server:wp

[![Architecture](https://img.shields.io/badge/linux-amd64-important?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Alpine](https://img.shields.io/badge/alpine-3.10.3-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![code-server](https://img.shields.io/badge/code--server-2.1650--vsc1.39.2-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Buy Me A Coffee](https://img.shields.io/badge/buy_me_coffee-$5-informational?style=flat&color=blue)](https://www.buymeacoffee.com/VXqkQK5tb)

Bootstraps an instance of Alpine Linux, code-server, and WordPress SSL/TLS enabled with browser-sync.

<p align="center" style="max-width: 1024px"><img src="https://i.imgur.com/7f0TwEa.png" width="100%"></p>

DEMYX | CODE-SERVER:WP
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

### demyx_cs_wp

ENVIRONMENT | VALUE 
--- | ---
PASSWORD | demyx
CODER_BASE_PATH | /demyx/cs
WORDPRESS_DB_NAME | demyx
WORDPRESS_DB_USER | demyx
WORDPRESS_DB_PASSWORD | demyx
WORDPRESS_DB_HOST | demyx_cs_wp
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

### demyx_cs_wp_db

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

### demyx_cs_wp_pma

ENVIRONMENT | VALUE
--- | ---
PMA_HOST | demyx_cs_wp_db
MYSQL_ROOT_PASSWORD | demyx
PMA_ABSOLUTE_URI | https://domain.tld/demyx/pma/

### docker-compose.yml

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
  demyx_db:
    container_name: demyx_db
    image: demyx/mariadb
    restart: unless-stopped
    networks:
      - demyx
    volumes:
      - demyx_db:/var/lib/mysql
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
  demyx:
    image: demyx/code-server:wp
    container_name: demyx
    hostname: demyx # Used for code-server
    restart: unless-stopped
    networks:
      - demyx
    volumes:
      - demyx:/var/www/html
      - demyx_user:/home/www-data
    depends_on:
      - demyx_db
    environment:
      - PASSWORD=demyx # Password for code-server and wp
      - CODER_BASE_PATH=/demyx # https://domain.tld/demyx/cs/
      - CODER_BS_DOMAIN=domain.tld
      - CODER_BS_PROXY=demyx
      - WORDPRESS_DB_NAME=demyx
      - WORDPRESS_DB_USER=demyx
      - WORDPRESS_DB_PASSWORD=demyx
      - WORDPRESS_DB_HOST=demyx_db
      - WORDPRESS_DOMAIN=domain.tld
      - WORDPRESS_USER=demyx
      - WORDPRESS_USER_EMAIL=info@domain.tld
      - WORDPRESS_SSL=true
      - WORDPRESS_UPLOAD_LIMIT=128M
      - WORDPRESS_PHP_MEMORY=256M
      - WORDPRESS_PHP_MAX_EXECUTION_TIME=300
      - WORDPRESS_PHP_OPCACHE=false
      - WORDPRESS_NGINX_CACHE=false
      - WORDPRESS_NGINX_RATE_LIMIT=false
      - WORDPRESS_NGINX_XMLRPC=false
      - TZ=America/Los_Angeles
    labels:
      - "traefik.enable=true"
      # wordpress https://domain.tld
      - "traefik.http.routers.cs-wp-http.rule=Host(`domain.tld`) || Host(`www.domain.tld`)"
      - "traefik.http.routers.cs-wp-http.entrypoints=http"
      - "traefik.http.routers.cs-wp-http.middlewares=cs-wp-redirect"
      - "traefik.http.routers.cs-wp-http.service=cs-wp-http"
      - "traefik.http.routers.cs-wp-https.rule=Host(`domain.tld`)"
      - "traefik.http.routers.cs-wp-https.entrypoints=https"
      - "traefik.http.routers.cs-wp-https.tls.certresolver=demyx"
      - "traefik.http.routers.cs-wp-https.service=cs-wp-https"
      - "traefik.http.services.cs-wp-http.loadbalancer.server.port=80"
      - "traefik.http.services.cs-wp-https.loadbalancer.server.port=80"
      - "traefik.http.middlewares.cs-wp-redirect.redirectscheme.scheme=https"
      # code-server https://domain.tld/demyx/cs/
      - "traefik.http.routers.cs-wp-cs.rule=(Host(`domain.tld`) && PathPrefix(`/demyx/cs/`))"
      - "traefik.http.routers.cs-wp-cs.middlewares=cs-wp-cs-prefix"
      - "traefik.http.routers.cs-wp-cs.entrypoints=https"
      - "traefik.http.routers.cs-wp-cs.tls.certresolver=demyx"
      - "traefik.http.routers.cs-wp-cs.service=cs-wp-cs"
      - "traefik.http.middlewares.cs-wp-cs-prefix.stripprefix.prefixes=/demyx/cs/"
      - "traefik.http.services.cs-wp-cs.loadbalancer.server.port=8080"
      # browser-sync https://domain.tld/demyx/bs/
      - "traefik.http.routers.cs-wp-bs.rule=(Host(`domain.tld`) && PathPrefix(`/demyx/bs/`))"
      - "traefik.http.routers.cs-wp-bs.middlewares=cs-wp-bs-prefix"
      - "traefik.http.routers.cs-wp-bs.entrypoints=https"
      - "traefik.http.routers.cs-wp-bs.tls.certresolver=demyx"
      - "traefik.http.routers.cs-wp-bs.service=cs-wp-bs"
      - "traefik.http.middlewares.cs-wp-bs-prefix.stripprefix.prefixes=/demyx/bs/"
      - "traefik.http.services.cs-wp-bs.loadbalancer.server.port=3000"
      # browser-sync socket
      - "traefik.http.routers.cs-wp-socket.rule=(Host(`domain.tld`) && PathPrefix(`/browser-sync/socket.io/`))"
      - "traefik.http.routers.cs-wp-socket.middlewares=cs-wp-socket-prefix"
      - "traefik.http.routers.cs-wp-socket.entrypoints=https"
      - "traefik.http.routers.cs-wp-socket.tls.certresolver=demyx"
      - "traefik.http.routers.cs-wp-socket.service=cs-wp-socket"
      - "traefik.http.middlewares.cs-wp-socket-prefix.stripprefix.prefixes=/demyx/bs/browser-sync/socket.io/"
      - "traefik.http.services.cs-wp-socket.loadbalancer.server.port=3000"
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
  demyx:
    name: demyx
  demyx_db:
    name: demyx_db
  demyx_user:
    name: demyx_user
  demyx_traefik:
    name: demyx_traefik
networks:
  demyx:
    name: demyx
```
