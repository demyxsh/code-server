# CHANGELOG

## 2021-02-22
### tag-openlitespeed
- Download only stable versions.
- Have a fallback version.

### tag-openlitespeed-bedrock
- Download only stable versions.
- Have a fallback version.

## 2021-02-21
- Moved old/outdated tags and files to archive. 
### tag-bedrock
- Added
    - `bin/demyx-config`
    - `bin/demyx-entrypoint`
    - `bin/demyx-install`
    - `bin/demyx-sage`
    - `config/.demyxrc`
    - `config/.p10k.zsh`
    - `config/bs.js`
    - `config/bs.php`
    - `config/launch.json`
    - `config/settings.json`
    - `config/shevaua.phpcs-1.0.8.vsix`
- Changed
    - Renamed from demyx/code-server:sage.
    - Update directory structure.
    - `bin/demyx-config`
        - Replace WORDPRESS_ with DEMYX_ prefix for variables.
        - Support for old variables.
        - Alphabetize php.ini config generator.
        - Update XDebug configuration.
    - `bin/demyx-entrypoint`
        - Update code-server variables.
        - Support for old variables.
        - Migrate oh-my-zsh plugins to custom directory.
        - Make oh-my-zsh, custom themes, and plugins auto update.
        - Source `.demyxrc` in .zshrc.
        - Migrate code-server data and extensions directory.
        - code-server now uses config.yaml for its configs.
    - `bin/demyx-install`
        - Replace WORDPRESS_ with DEMYX_ prefix for variables.
        - Support for old variables.
    - `bin/demyx-sage`
        - Replace WORDPRESS_ with DEMYX_ prefix for variables.
        - Support for old variables.
        - Organize code by putting each into its own function.
    - `config/.demyxrc`
        - oh-my-zsh config variables.
        - Other misc variables.
    - `config/launch.json`
        - Remove unused items.
    - `config/settings.json`
        - Set default font family.
        - Removed some items.
    - `docker-compose.yml`
        - Downgrade version to 2.4.
        - Alphabetize keys.
        - Update variables with DEMYX_ prefix.
        - Various misc updates.
    - `Dockerfile`
        - Add shellcheck.
        - Set FROM image to a fixed PHP version.
        - All main variables are now prefixed with DEMYX_.
        - Import ENVs from demyx/wordpress image.
        - Update ENVs with additional variables.
        - Rearrange RUN commands.
        - Update bash PS1.
        - Set default theme to powerlevel10k.
        - Dynamically update code-server version by curling its GitHub repo.
        - Support custom fonts needed by powerlevel10k theme.
    - `README.md`
        - Use relative screenshot.
        - Update table.
        - Update usage.
- Removed

### tag-browse
- Added
    - `bin/demyx`
    - `bin/demyx-entrypoint`
    - `config/.demyxrc`
    - `config/.p10k.zsh`
    - `config/ctop`
    - `config/settings.json`
- Changed
    - Update directory structure.
    - `bin/demyx-entrypoint`
        - Update code-server variables.
        - Support for old variables.
        - Migrate oh-my-zsh plugins to custom directory.
        - Make oh-my-zsh, custom themes, and plugins auto update.
        - Source `.demyxrc` in .zshrc.
        - Migrate code-server data and extensions directory.
        - code-server now uses config.yaml for its configs.
    - `config/.demyxrc`
        - oh-my-zsh config variables.
        - Other misc variables.
    - `config/settings.json`
        - Set default font family.
        - Removed some items.
    - `Dockerfile`
        - Update ctop to latest version.
        - Add shellcheck.
        - All main variables are now prefixed with DEMYX_.
        - Update ENVs with additional variables.
        - Rearrange RUN commands.
        - Update packages.
        - Update bash PS1.
        - Set default theme to powerlevel10k.
        - Dynamically update code-server version by curling its GitHub repo.
        - Support custom fonts needed by powerlevel10k theme.
- Removed

### tag-go
- Added
    - `bin/demyx`
    - `bin/demyx-entrypoint`
    - `config/.demyxrc`
    - `config/.p10k.zsh`
    - `config/ctop`
    - `config/settings.json`
- Changed
    - Update directory structure.
    - `bin/demyx-entrypoint`
        - Update code-server variables.
        - Support for old variables.
        - Migrate oh-my-zsh plugins to custom directory.
        - Make oh-my-zsh, custom themes, and plugins auto update.
        - Source `.demyxrc` in .zshrc.
        - Migrate code-server data and extensions directory.
        - code-server now uses config.yaml for its configs.
    - `config/.demyxrc`
        - oh-my-zsh config variables.
        - Other misc variables.
    - `config/settings.json`
        - Set default font family.
        - Removed some items.
    - `Dockerfile`
        - Update ctop to latest version.
        - Add shellcheck.
        - All main variables are now prefixed with DEMYX_.
        - Update ENVs with additional variables.
        - Rearrange RUN commands.
        - Update packages.
        - Update bash PS1.
        - Set default theme to powerlevel10k.
        - Dynamically update code-server version by curling its GitHub repo.
        - Support custom fonts needed by powerlevel10k theme.
- Removed

### tag-latest
- Added
    - `bin/demyx-entrypoint`
    - `config/.demyxrc`
    - `config/.p10k.zsh`
    - `config/ctop`
    - `config/settings.json`
- Changed
    - Update directory structure.
    - `bin/demyx-entrypoint`
        - Update code-server variables.
        - Support for old variables.
        - Migrate oh-my-zsh plugins to custom directory.
        - Make oh-my-zsh, custom themes, and plugins auto update.
        - Source `.demyxrc` in .zshrc.
        - Migrate code-server data and extensions directory.
        - code-server now uses config.yaml for its configs.
    - `config/.demyxrc`
        - oh-my-zsh config variables.
        - Other misc variables.
    - `config/settings.json`
        - Set default font family.
        - Removed some items.
    - `Dockerfile`
        - Update ctop to latest version.
        - Add shellcheck.
        - All main variables are now prefixed with DEMYX_.
        - Update ENVs with additional variables.
        - Rearrange RUN commands.
        - Update packages.
        - Update bash PS1.
        - Set default theme to powerlevel10k.
        - Dynamically update code-server version by curling its GitHub repo.
        - Support custom fonts needed by powerlevel10k theme.
    - `README.md`
        - Update screenshot.
        - Update tags.
        - Update theme.
        - Update sample docker-compose.yml.
- Removed

### tag-openlitespeed
- Added
    - `bin/demyx-admin`
    - `bin/demyx-config`
    - `bin/demyx-entrypoint`
    - `bin/demyx-htpasswd`
    - `bin/demyx-install`
    - `bin/demyx-lsws`
    - `config/.demyxrc`
    - `config/.p10k.zsh`
    - `config/bs.php`
    - `config/launch.json`
    - `config/settings.json`
    - `config/shevaua.phpcs-1.0.8.vsix`
- Changed
    - Update directory structure.
    - `bin/demyx-admin`
        - Replace OPENLITESPEED_ with DEMYX_ prefix for variables.
        - Support for old variables.
    - `bin/demyx-config`
        - Replace OPENLITESPEED_ with DEMYX_ prefix for variables.
        - Support for old variables.
    - `bin/demyx-encrypt`
        - Replace OPENLITESPEED_ with DEMYX_ prefix for variables.
        - Support for old variables.
    - `bin/demyx-entrypoint`
        - Update code-server variables.
        - Support for old variables.
        - Migrate oh-my-zsh plugins to custom directory.
        - Make oh-my-zsh, custom themes, and plugins auto update.
        - Source `.demyxrc` in .zshrc.
        - Migrate code-server data and extensions directory.
        - code-server now uses config.yaml for its configs.
    - `bin/demyx-htpasswd`
        - Replace OPENLITESPEED_ with DEMYX_ prefix for variables.
    - `bin/demyx-install`
        - Replace OPENLITESPEED_ with DEMYX_ prefix for variables.
        - Support for old variables.
    - `bin/demyx-lsws`
        - Replace OPENLITESPEED_ with DEMYX_ prefix for variables.
    - `config/.demyxrc`
        - oh-my-zsh config variables.
        - Other misc variables.
    - `config/launch.json`
        - Remove unused items.
    - `config/settings.json`
        - Set default font family.
        - Removed some items.
    - `docker-compose.yml`
        - Downgrade version to 2.4.
        - Alphabetize keys.
        - Update variables with DEMYX_ prefix.
        - Various misc updates.
    - `Dockerfile`
        - Remove FROM demyx/openlitespeed.
        - Add shellcheck.
        - All main variables are now prefixed with DEMYX_.
        - Import ENVs from demyx/wordpress image.
        - Update ENVs with additional variables.
        - Rearrange RUN commands.
        - Update packages.
        - Update bash PS1.
        - Update Xdebug to 3.x.
        - Set default theme to powerlevel10k.
        - Dynamically update code-server version by curling its GitHub repo.
        - Support custom fonts needed by powerlevel10k theme.
- Removed

### tag-openlitespeed-bedrock
- Added
    - `bin/demyx-admin`
    - `bin/demyx-config`
    - `bin/demyx-entrypoint`
    - `bin/demyx-htpasswd`
    - `bin/demyx-install`
    - `bin/demyx-lsws`
    - `config/.demyxrc`
    - `config/.p10k.zsh`
    - `config/bs.php`
    - `config/launch.json`
    - `config/settings.json`
    - `config/shevaua.phpcs-1.0.8.vsix`
- Changed
    - Update directory structure.
    - `bin/demyx-admin`
        - Replace OPENLITESPEED_ with DEMYX_ prefix for variables.
        - Support for old variables.
    - `bin/demyx-config`
        - Replace OPENLITESPEED_ with DEMYX_ prefix for variables.
        - Support for old variables.
    - `bin/demyx-encrypt`
        - Replace OPENLITESPEED_ with DEMYX_ prefix for variables.
        - Support for old variables.
    - `bin/demyx-entrypoint`
        - Update code-server variables.
        - Support for old variables.
        - Migrate oh-my-zsh plugins to custom directory.
        - Make oh-my-zsh, custom themes, and plugins auto update.
        - Source `.demyxrc` in .zshrc.
        - Migrate code-server data and extensions directory.
        - code-server now uses config.yaml for its configs.
    - `bin/demyx-htpasswd`
        - Replace OPENLITESPEED_ with DEMYX_ prefix for variables.
    - `bin/demyx-install`
        - Replace OPENLITESPEED_ with DEMYX_ prefix for variables.
        - Support for old variables.
    - `bin/demyx-lsws`
        - Replace OPENLITESPEED_ with DEMYX_ prefix for variables.
    - `bin/demyx-sage`
        - Replace WORDPRESS_ with DEMYX_ prefix for variables.
        - Support for old variables.
        - Organize code by putting each into its own function.
    - `config/.demyxrc`
        - oh-my-zsh config variables.
        - Other misc variables.
    - `config/launch.json`
        - Remove unused items.
    - `config/settings.json`
        - Set default font family.
        - Removed some items.
    - `docker-compose.yml`
        - Downgrade version to 2.4.
        - Alphabetize keys.
        - Update variables with DEMYX_ prefix.
        - Various misc updates.
    - `Dockerfile`
        - Remove FROM demyx/openlitespeed.
        - Add shellcheck.
        - All main variables are now prefixed with DEMYX_.
        - Import ENVs from demyx/wordpress image.
        - Update ENVs with additional variables.
        - Rearrange RUN commands.
        - Update packages.
        - Update bash PS1.
        - Update Xdebug to 3.x.
        - Set default theme to powerlevel10k.
        - Dynamically update code-server version by curling its GitHub repo.
        - Support custom fonts needed by powerlevel10k theme.
- Removed

### tag-wp
- Added
    - `bin/demyx-config`
    - `bin/demyx-entrypoint`
    - `bin/demyx-install`
    - `config/.demyxrc`
    - `config/.p10k.zsh`
    - `config/bs.php`
    - `config/launch.json`
    - `config/settings.json`
    - `config/shevaua.phpcs-1.0.8.vsix`
- Changed
    - Update directory structure.
    - `bin/demyx-config`
        - Replace WORDPRESS_ with DEMYX_ prefix for variables.
        - Support for old variables.
        - Alphabetize php.ini config generator.
        - Update XDebug configuration.
    - `bin/demyx-entrypoint`
        - Update code-server variables.
        - Support for old variables.
        - Migrate oh-my-zsh plugins to custom directory.
        - Make oh-my-zsh, custom themes, and plugins auto update.
        - Source `.demyxrc` in .zshrc.
        - Migrate code-server data and extensions directory.
        - code-server now uses config.yaml for its configs.
    - `bin/demyx-install`
        - Replace WORDPRESS_ with DEMYX_ prefix for variables.
        - Support for old variables.
    - `config/.demyxrc`
        - oh-my-zsh config variables.
        - Other misc variables.
    - `config/launch.json`
        - Remove unused items.
    - `config/settings.json`
        - Set default font family.
        - Removed some items.
    - `docker-compose.yml`
        - Downgrade version to 2.4.
        - Alphabetize keys.
        - Update variables with DEMYX_ prefix.
        - Various misc updates.
    - `Dockerfile`
        - Add shellcheck.
        - Set FROM image to a fixed PHP version.
        - All main variables are now prefixed with DEMYX_.
        - Import ENVs from demyx/wordpress image.
        - Update ENVs with additional variables.
        - Rearrange RUN commands.
        - Update bash PS1.
        - Set default theme to powerlevel10k.
        - Dynamically update code-server version by curling its GitHub repo.
        - Support custom fonts needed by powerlevel10k theme.
    - `README.md`
        - Use relative screenshot.
        - Update table.
        - Update usage.
- Removed

## 2020-07-23
### Added
- tag-*
    - Set editor.quickSuggestions to true in settings.json
- tag-browse
    - Include shellcheck and unzip to default apps
### Changed
- tag-browse
    - Clean up /tmp
- tag-go
    - Use sudo -E so envs will be passed

## 2020-07-01
### Changed
- Remove font ligatures from the JSON setting files

## 2020-06-22
### Changed
- Update if statement for WP entrypoints

## 2020-06-16
### Changed
- Updated travis version commands

## 2020-06-07
### Changed
- tag-browse
    - Run git pulls in the entrypoint to the background

## 2020-06-06
### Added
- wget to packages
### Changed
- code-server:browse now has a symlink to /demyx from user's home

## 2020-05-29
### Added
- Auto update oh-my-zsh and its plugin in the entrypoint
- Sudo script to reset ownership for demyx home directory
### Changed
- Re-added ssh/gnupg to the browse tag

## 2020-05-24
### Added
- New tag code-server:browse

## 2020-05-17
### Changed
- Renamed variables for code-server version
- Update symlink directory to match upstream
### Removed
- --disable-updates
- --port

## 2020-05-10
### Changed
- The openlitespeed tags do not use CODE_CONFIG variable

## 2020-05-09
### Changed
- Entrypoints now copy code-server configs if it's missing
- Non Alpine images will now use curl to download code-server

## 2020-05-04
### Changed
- Updated Debian based code-server to 3.2.0 and its related flags

## 2020-04-12
### Added
- Shared folder with reusable files
- Go variant of code-server
- tag-alpine
    - Added CODE_VERSION and CODE_BINARY
- tag-openlitespeed
    - Third party source to upgrade php to 7.4
- tag-openlitespeed-sage
    - Third party source to upgrade php to 7.4
- tag-sage
    - Third party script to install additional php extensions
    - PHP_CodeSniffer and its code-server extension
- tag-sage-alpine
    - Third party script to install additional php extensions
    - PHP_CodeSniffer and its code-server extension
- tag-wp
    - Third party script to install additional php extensions
    - PHP_CodeSniffer and its code-server extension
- tag-wp-alpine
    - Third party script to install additional php extensions
    - PHP_CodeSniffer and its code-server extension
- Travis-CI
    - Pull several needed base images
    - Include go tag
    - Output versions in a file
    - Commit version file first before committing the rest
### Changed
- CODE_SERVER_ROOT => CODE_ROOT
- CODE_SERVER_CONFIG => CODE_CONFIG
- CODE_SERVER_LOG => CODE_LOG
- Formatted LABELS and ENV entries
- Moved Configure Demyx commands below the ENV entries
- Shared files are fetched via curl
- Renamed entrypoints
- Rearranged RUN commands
- Update screenshot
- tag-alpine
    - Set a fixed version when configuring code-server
- tag-latest
    - Update code-server to 3.1.0 via multistage layer
    - CMD uses flags specific for code-server v3
    - Updated docker-compose.yml
- tag-openlitespeed
    - Update code-server to 3.1.0 via multistage layer
    - Use updated variables from demyx/openlitespeed
- tag-openlitespeed-sage
    - Update code-server to 3.1.0 via multistage layer
    - Use updated variables from demyx/openlitespeed
- tag-sage
    - Update code-server to 3.1.0 via multistage layer
    - Base iamge is now php:fpm-buster
- tag-sage-alpine
    - Set a fixed version when configuring code-server
    - Base image is now php-fpm-alpine
    - Configure Sage in separate RUN command
- tag-wp
    - Update code-server to 3.1.0 via multistage layer
    - Base iamge is now php:fpm-buster
    - docker-compose.yml now includes updates from tag-openlitespeed's .yml
- tag-sage-alpine
    - Set a fixed version when configuring code-server
    - Base image is now php-fpm-alpine
    - Configure Sage in separate RUN command
- Travis-CI
    - Each environment variables are now in their own lines
    - Run tag-latest in the background
### Removed
- Files that were gonna be used for COPY
- Unused environment variable for main docker-compose.yml
- Travis-CI
    - DOCKER_COMPOSE_VERSION variable
    - docker-compose install commands
