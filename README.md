# code-server
[![Build Status](https://img.shields.io/travis/demyxco/code-server?style=flat)](https://travis-ci.org/demyxco/code-server)
[![Docker Pulls](https://img.shields.io/docker/pulls/demyx/code-server?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Architecture](https://img.shields.io/badge/linux-amd64-important?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Ubuntu](https://img.shields.io/badge/ubuntu-18.04-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![code-server](https://img.shields.io/badge/code--server-2.1568--vsc1.38.1-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Buy Me A Coffee](https://img.shields.io/badge/buy_me_coffee-$5-informational?style=flat&color=blue)](https://www.buymeacoffee.com/VXqkQK5tb)

code-server is VS Code running on a remote server, accessible through the browser.

<p align="center" style="max-width: 1024px"><img src="https://i.imgur.com/93QZgnG.png" width="100%"></p>

DEMYX | LATEST | WP
--- | --- | ---
TAG | latest | wp
USER<br />GROUP | coder (1000)<br />coder (1000)  | www-data (82)<br />www-data (82)
WORKDIR | /home/coder | /var/www/html
PORT | 8080 | 8080 3000
ENTRYPOINT | dumb-init | s6-overlay
DEFAULT PASSWORD | demyx | demyx
TIMEZONE | America/Los_Angeles | America/Los_Angeles
SHELL | zsh | zsh
SHELL THEME | Oh My Zsh "ys" | Oh My Zsh "ys"
PACKAGES | zsh jq htop nano tzdata | zsh jq htop nano tzdata composer npm browser-sync wp-cli

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

To disable password authentication, set CODER_AUTH to false.

DEMYX | LATEST | WP
--- | --- | ---
CODER_AUTH | true | true
PASSWORD | demyx | demyx
TZ | America/Los_Angeles | America/Los_Angeles

## Usage
* Requires no config file for Traefik and is ready to go when running: `docker-compose up -d`
* For SSL/TLS, just remove the comments (#)
* Upgrading from Traefik v1 to v2? You will need to convert your [acme.json](https://github.com/containous/traefik-migration-tool)

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
      #- 443:443
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - demyx_traefik:/demyx
    environment:
      - TRAEFIK_API=true
      - TRAEFIK_PROVIDERS_DOCKER=true
      - TRAEFIK_PROVIDERS_DOCKER_EXPOSEDBYDEFAULT=false
      - TRAEFIK_ENTRYPOINTS_HTTP_ADDRESS=:80
      #- TRAEFIK_ENTRYPOINTS_HTTPS_ADDRESS=:443
      #- TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_HTTPCHALLENGE=true
      #- TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_HTTPCHALLENGE_ENTRYPOINT=http
      #- TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_EMAIL=info@domain.tld
      #- TRAEFIK_CERTIFICATESRESOLVERS_DEMYX_ACME_STORAGE=/demyx/acme.json
      - TRAEFIK_LOG=true
      - TRAEFIK_LOG_LEVEL=INFO
      - TRAEFIK_LOG_FILEPATH=/demyx/error.log
      - TRAEFIK_ACCESSLOG=true
      - TRAEFIK_ACCESSLOG_FILEPATH=/demyx/access.log
      - TZ=America/Los_Angeles
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.traefik-http.rule=Host(`traefik.domain.tld`)"
      - "traefik.http.routers.traefik-http.service=api@internal"
      - "traefik.http.routers.traefik-http.entrypoints=http"
      #- "traefik.http.routers.traefik-http.middlewares=traefik-redirect"
      #- "traefik.http.routers.traefik-https.rule=Host(`traefik.domain.tld`)"
      #- "traefik.http.routers.traefik-https.entrypoints=https"
      #- "traefik.http.routers.traefik-https.service=api@internal"
      #- "traefik.http.routers.traefik-https.tls.certresolver=demyx"
      #- "traefik.http.routers.traefik-https.middlewares=traefik-auth"
      #- "traefik.http.middlewares.traefik-auth.basicauth.users=demyx:$$apr1$$EqJj89Yw$$WLsBIjCILtBGjHppQ76YT1"
      #- "traefik.http.middlewares.traefik-redirect.redirectscheme.scheme=https" 
  code_server:
    container_name: demyx_cs
    image: demyx/code-server
    restart: unless-stopped
    networks:
      - demyx
    volumes:
      - demyx_cs:/home/coder
    environment:
      - CODER_AUTH=true
      - PASSWORD=demyx
      - TZ=America/Los_Angeles
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.domaintld-http.rule=Host(`domain.tld`) || Host(`www.domain.tld`)"
      - "traefik.http.routers.domaintld-http.entrypoints=http"
      #- "traefik.http.routers.domaintld-http.middlewares=domaintld-redirect"
      #- "traefik.http.routers.domaintld-https.rule=Host(`domain.tld`) || Host(`www.domain.tld`)"
      #- "traefik.http.routers.domaintld-https.entrypoints=https"
      #- "traefik.http.routers.domaintld-https.tls.certresolver=demyx"
      #- "traefik.http.middlewares.domaintld-redirect.redirectscheme.scheme=https"
volumes:
  demyx_cs:
    name: demyx_cs
  demyx_traefik:
    name: demyx_traefik
networks:
  demyx:
    name: demyx
```
