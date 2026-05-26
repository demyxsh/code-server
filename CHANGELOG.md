# CHANGELOG

## 2026-05-25
### Added
- None.
### Changed
- Updated GitHub Actions Docker workflow to publish all moving variant tags plus versioned tags derived from `DEMYX_VERSION` from the `demyx` orchestrator using the `<version>-<variant>` convention.
- Updated GitHub Actions workflow to resolve `CODE_SERVER_VERSION` once per run and pass it to all Docker builds via `--build-arg`.
### Fixed
- Removed per-image runtime dependency on GitHub `releases/latest` API for `code-server`, preventing CI `403` rate-limit failures that cascaded into bad download URLs.
### Removed
- None.
### Security
- None.
## 2026-04-24
### Changed
- Fix repo url

## 2025-08-19
### Changed
- Enhance demyx-entrypoint script to install Catppuccin theme if not already present, ensuring a consistent theme experience across environments.

## 2025-07-28
### Changed
- Include subshells for error checking
- Remove unused variables
- Rename/delete files/variables
- Fix WordPress URL error
- Update versions
- Combine functions
- Allow config override
- Update entrypoint so code-server is pid 1
- Update sudo
- Update packages
- Fix imagick install error
- Simplify `demyx_config_php`
- `demyx_config_www()` is now fully automated
- New variables
- Force symlink
- Create missing xdebug.ini
- Direct people to demyx
- Misc update
- Add symlink to switch lsphp version
- Compile xdebug so there is no version mismatch
- Change pgrep string
- Refactor Dockerfile and entrypoint scripts to remove powerlevel10k theme, update VS Code extensions, and enhance SSH setup. Adjust settings for editor and improve configuration handling in demyx scripts.
- Update GitHub Actions workflow to use run ID in commit message for scheduled builds
- Update Dockerfile to use debian:bookworm-slim as the base image
- Update configuration files to change ZSH theme to 'candy', modify sudoers permissions in Dockerfile, and enhance VS Code settings for improved editor experience.

## 2024-03-25
### Changed
- Install latest version of Docker through package manager
- Remove docker-compose package since the latest version of Docker now has compose installed as a plugin

## 2024-03-07
### Changed
- Fix container crashes
- The demyx container will handle this
- Backup extensions before updating
- Execute `demyx motd` when the terminal starts

## 2024-03-05
### Changed
- Remove shorthand since it was causing the container to crash
- Remove missing package
- Forgot to remove this shorthand

## 2024-02-28
### Changed
- Remove title from first line to prevent outputting error
- Backup extensions before updating
- Fix reboot container crash
- 2024-02-20
- Allow users to add custom cron
- Include missing create rule
- 2024-02-08
- Merge branch 'master' of github.com:demyxsh/code-server
- Update description with shameless plug
- Misc updates
- Use tidy package to scrape the latest stable version in openlitespeed's downloads page
- Add packages
- Add missing environment variables
- Update rewrite rule
- Use new function to include all demyx environment variables  for lsphp
- New function to auto calculate values for `LSAPI_EXTRA_CHILDREN` and `LSAPI_MAX_IDLE_CHILDREN`
- Update php versions and set default to 8.1
- New function to reset permissions at container start and hourly cron
- Add environment variables
- Double the upload limit
- Remove environment variables
- Include custom volume

## 2023-11-14
### Changed
- Disable installation of default themes/plugins when upgrading

## 2023-09-21
### Changed
- Add support for redis

## 2023-09-14
### Changed
- Install wp-cli login package if missing
- Fix WPCS and run it in the background

## 2023-09-03
### Changed
- Add new variable DEMYX_CRON_TYPE
- Update to bullseye image

## 2023-08-29
### Changed
- Add docker-compose package

## 2023-08-28
### Changed
- Update logrotate conf

## 2023-08-15
### Changed
- Update/remove RUN commands since most of the updates are from the FROM image
- Set to root user for temporary mods
- Update ENVs
- Update FROM
- Install wp-cli login package
- Update xdebug configuration commands
- Purge xdebug deps
- Add lsphp packages and replicate for lsphp81
- Set fallback
- Configure php extensions
- Add new files
- Delete
- Use new format and misc updates
- Configure sudo
- Combine RUN commands and add wp-cli login package
- Update installed packages
- Update ENVs
- Update FROM to official php image and set version to 8.0

## 2023-07-03
### Changed
- Fix pecl install error

## 2023-07-02
### Changed
- Fix libssh2 library was not found error

## 2023-06-23
### Changed
- Enable auto update for ohmyzsh

## 2022-09-14
### Changed
- Put if statement inside the others

## 2022-08-29
### Changed
- Make sure file exist

## 2022-08-23
### Changed
- Misc updates
- Install roots/acorn into bedrock's composer.json
- Use latest LTS version for nvm/npm
- Replace php extension install script
- Update default packages
- Update environment variables
- Update to php8 and bullseye
- Update to bullseye
- Update traefik rules for Sage 10
- Update echo strings when opening terminal for the first time
- Update sage helper script for sage 10

## 2022-06-17
### Changed
- tag-wp - add missing package default-mysql-client for wp-cli
- tag-bedrock/tag-openlitespeed-bedrock - echo out useful information about demyx-sage commands
- tag-bedrock/tag-openlitespeed-bedrock - create new sage project with a fixed version, add yard cache clean, add --no-interaction flag to both composer commands
- tag-bedrock/tag-openlitespeed-bedrock - update demyx-sage help menu
- tag-bedrock/tag-openlitespeed-bedrock - remove the error "--max-old-space-size=2048 is not allowed"
- Update the README with new demyx-sage usage
- tag-openlitespeed-bedrock - use su for the npm and yarn RUN commands
- tag-bedrock/tag-openlitespeed-bedrock - use a different sage code-server extension
- tag-bedrock/tag-openlitespeed-bedrock - remove adding sage to the image
- tag-bedrock/tag-openlitespeed-bedrock - replace node lts version with a fixed version
- tag-bedrock/tag-openlitespeed-bedrock - add missing package default-mysql-client for wp-cli
- tag-bedrock/tag-openlitespeed-bedrock - add new environment variables: DEMYX_NODE_VERSION DEMYX_SAGE_VERSION

## 2022-03-24
### Changed
- Use find to find the workbench.html since it's been relocating in recent code-server updates
- Use canvas as the default gpu acceleration for the terminal
- Remove old directories
- Use cp instead of rm

## 2022-03-16
### Changed
- Symlink /demyx directory

## 2022-02-10
### Changed
- New script to update all code-server extensions

## 2022-01-15
### Changed
- Put back code to inject custom fonts
- Change ZSH_THEME back to powerlevel10k/powerlevel10k
- Remove default code-server version
- Change back SHELL THEME to powerlevel10k

## 2022-01-14
### Changed
- Update SHELL THEME
- Remove custom font injection for now
- Remove extension ryu1kn.partial-diff
- Change theme to ys for now

## 2021-11-02
### Changed
- Use wildcard when replacing shell path

## 2021-07-14
### tag-openlitespeed
### Changed
- Update OLS default version

### tag-openlitespeed-bedrock
### Changed
- Update OLS default version

## 2021-05-06
### tag-bedrock
### Changed
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed
### tag-browse
### Changed
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed
### tag-go
### Changed
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed
### tag-latest
### Changed
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed
### tag-openlitespeed
### Changed
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed
### tag-openlitespeed-bedrock
### Changed
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed
### tag-wp
### Changed
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed

## 2021-03-08
### tag-bedrock
### Changed
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed
### tag-browse
### Changed
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed
### tag-go
### Changed
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed
### tag-latest
### Changed
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed
### tag-openlitespeed
### Changed
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed
### tag-openlitespeed-bedrock
### Changed
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed
### tag-wp
### Changed
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed

## 2021-03-03
### tag-openlitespeed
### Changed
- Added
- Changed
    - Move WordPress rewrite rules to the bottom so the security rules works again.
- Removed

### tag-openlitespeed-bedrock
### Changed
- Added
- Changed
    - Move WordPress rewrite rules to the bottom so the security rules works again.
- Removed

## 2021-02-22
### tag-openlitespeed
### Changed
- Download only stable versions.
- Have a fallback version.

### tag-openlitespeed-bedrock
### Changed
- Download only stable versions.
- Have a fallback version.

## 2021-02-21
### Changed
- Moved old/outdated tags and files to archive. 
### tag-bedrock
### Changed
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
### Changed
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
### Changed
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
### Changed
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
### Changed
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
### Changed
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
### Changed
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
### Changed
- tag-*
    - Set editor.quickSuggestions to true in settings.json
- tag-browse
    - Include shellcheck and unzip to default apps
### Changed
### Changed
- tag-browse
    - Clean up /tmp
- tag-go
    - Use sudo -E so envs will be passed

## 2020-07-01
### Changed
### Changed
- Remove font ligatures from the JSON setting files

## 2020-06-22
### Changed
### Changed
- Update if statement for WP entrypoints

## 2020-06-16
### Changed
### Changed
- Updated travis version commands

## 2020-06-07
### Changed
### Changed
- tag-browse
    - Run git pulls in the entrypoint to the background

## 2020-06-06
### Added
### Changed
- wget to packages
### Changed
### Changed
- code-server:browse now has a symlink to /demyx from user's home

## 2020-05-29
### Added
### Changed
- Auto update oh-my-zsh and its plugin in the entrypoint
- Sudo script to reset ownership for demyx home directory
### Changed
### Changed
- Re-added ssh/gnupg to the browse tag

## 2020-05-24
### Added
### Changed
- New tag code-server:browse

## 2020-05-17
### Changed
### Changed
- Renamed variables for code-server version
- Update symlink directory to match upstream
### Removed
### Changed
- --disable-updates
- --port

## 2020-05-10
### Changed
### Changed
- The openlitespeed tags do not use CODE_CONFIG variable

## 2020-05-09
### Changed
### Changed
- Entrypoints now copy code-server configs if it's missing
- Non Alpine images will now use curl to download code-server

## 2020-05-04
### Changed
### Changed
- Updated Debian based code-server to 3.2.0 and its related flags

## 2020-04-12
### Added
### Changed
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
### Changed
- Files that were gonna be used for COPY
- Unused environment variable for main docker-compose.yml
- Travis-CI
    - DOCKER_COMPOSE_VERSION variable
    - docker-compose install commands
