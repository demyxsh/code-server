# code-server
[![Build Status](https://img.shields.io/travis/demyxco/code-server?style=flat)](https://travis-ci.org/demyxco/code-server)
[![Docker Pulls](https://img.shields.io/docker/pulls/demyx/code-server?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Architecture](https://img.shields.io/badge/linux-amd64-important?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Alpine](https://img.shields.io/badge/alpine-3.10.3-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Debian](https://img.shields.io/badge/debian-10.4-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Go](https://img.shields.io/badge/go-1.14.6-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![code-server](https://img.shields.io/badge/code--server-3.4.1-informational?style=flat&color=blue)](https://hub.docker.com/r/demyx/code-server)
[![Buy Me A Coffee](https://img.shields.io/badge/buy_me_coffee-$5-informational?style=flat&color=blue)](https://www.buymeacoffee.com/VXqkQK5tb)
[![Become a Patron!](https://img.shields.io/badge/become%20a%20patron-$5-informational?style=flat&color=blue)](https://www.patreon.com/bePatron?u=23406156)

code-server is VS Code running on a remote server, accessible through the browser.

<p align="center" style="max-width: 1024px"><img src="https://i.imgur.com/jBSya1n.png" width="100%"></p>

DEMYX | CODE-SERVER
--- | ---
TAGS | latest alpine openlitespeed openlitespeed-sage wp wp-alpine sage sage-alpine
PORT | 8080
USER | demyx
WORKDIR | /demyx
CONFIG | /etc/demyx
ENTRYPOINT | ["demyx-entrypoint"]
SHELL | zsh
SHELL THEME | Oh My Zsh "ys" 

## Usage
* SSL/TLS first!
* Requires no config file for Traefik and is ready to go when running: `docker-compose up -d`
* Upgrading from Traefik v1 to v2? You will need to convert your [acme.json](https://github.com/containous/traefik-migration-tool)

```
# Demyx
# https://demyx.sh
#
# Be sure to change all the domain.tld domains and credentials
#
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
      # traefik https://traefik.domain.tld
      - "traefik.enable=true"
      - "traefik.http.routers.traefik-http.rule=Host(`traefik.domain.tld`)"
      - "traefik.http.routers.traefik-http.service=api@internal"
      - "traefik.http.routers.traefik-http.entrypoints=http"
      - "traefik.http.routers.traefik-http.middlewares=traefik-redirect"
      - "traefik.http.middlewares.traefik-redirect.redirectscheme.scheme=https"
      - "traefik.http.routers.traefik-https.rule=Host(`traefik.domain.tld`)"
      - "traefik.http.routers.traefik-https.entrypoints=https"
      - "traefik.http.routers.traefik-https.service=api@internal"
      - "traefik.http.routers.traefik-https.middlewares=traefik-auth"
      - "traefik.http.middlewares.traefik-auth.basicauth.users=demyx:$$apr1$$EqJj89Yw$$WLsBIjCILtBGjHppQ76YT1" # Password: demyx
      - "traefik.http.routers.traefik-https.tls.certresolver=demyx"
  demyx_cs:
    container_name: demyx_cs
    image: demyx/code-server
    restart: unless-stopped
    networks:
      - demyx
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - demyx_cs:/home/demyx
    environment:
      - PASSWORD=demyx
      - TZ=America/Los_Angeles
    labels:
      # code-server https://domain.tld
      - "traefik.enable=true"
      - "traefik.http.routers.domaintld-http.rule=Host(`domain.tld`) || Host(`www.domain.tld`)"
      - "traefik.http.routers.domaintld-http.entrypoints=http"
      - "traefik.http.routers.domaintld-https.rule=Host(`domain.tld`) || Host(`www.domain.tld`)"
      - "traefik.http.routers.domaintld-https.entrypoints=https"
      - "traefik.http.routers.domaintld-http.middlewares=domaintld-redirect"
      - "traefik.http.middlewares.domaintld-redirect.redirectscheme.scheme=https"
      - "traefik.http.routers.domaintld-https.tls.certresolver=demyx"
volumes:
  demyx_cs:
    name: demyx_cs
  demyx_traefik:
    name: demyx_traefik
networks:
  demyx:
    name: demyx
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
