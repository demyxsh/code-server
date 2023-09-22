# CHANGELOG

## 2023-09-21
- Add support for redis [ba6f1c1](https://github.com/demyxsh/code-server/commit/ba6f1c11ebfdc3b3689f6795d03d028ebcdc20bd)

## 2023-09-14
- Install wp-cli login package if missing [80970e2](https://github.com/demyxsh/code-server/commit/80970e222a2479bbc3c09136c5cb9b4a275b34fb)
- Fix WPCS and run it in the background [0f0846e](https://github.com/demyxsh/code-server/commit/0f0846edbf2cabfbc132d4bfcc875e67ea571a7b)

## 2023-09-03
- Add new variable DEMYX_CRON_TYPE [61b723c](https://github.com/demyxsh/code-server/commit/61b723c2028a65e83b1d35e1945e4d9d2c7ba3b0)
- Update to bullseye image [04a0886](https://github.com/demyxsh/code-server/commit/04a08863d6b5746567c9c939ae502c301c356e1b)

## 2023-08-29
- Add docker-compose package [24f6206](https://github.com/demyxsh/code-server/commit/24f620659e68dcc96a2d2954c48c821d892374a0)

## 2023-08-28
- Update logrotate conf [9a6b6f9](https://github.com/demyxsh/code-server/commit/9a6b6f9a02aaa64b1565ddd6e8928eb42456566c)

## 2023-08-15
- Update/remove RUN commands since most of the updates are from the FROM image [af12ddf](https://github.com/demyxsh/code-server/commit/af12ddf10af9abb508e720e5dbaf04ebd5ade0e6)
- Set to root user for temporary mods [27b2be9](https://github.com/demyxsh/code-server/commit/27b2be96bb25dd1afafbabf04a8393b3a1068c4f)
- Update ENVs [ddee7e4](https://github.com/demyxsh/code-server/commit/ddee7e4a98902a565548ff847c51a123088a323e)
- Update FROM [7308cac](https://github.com/demyxsh/code-server/commit/7308cac34663981a9c3ef03646686d144bf708a7)
- Install wp-cli login package [4eba04c](https://github.com/demyxsh/code-server/commit/4eba04ca19461301c3507562c65e3dba8fc4bb62)
- Update xdebug configuration commands [6db3626](https://github.com/demyxsh/code-server/commit/6db3626caf87981d8a9ab10262216a80847d716b)
- Purge xdebug deps [0805236](https://github.com/demyxsh/code-server/commit/08052368cecb3591ba80a86add71ff01db046c18)
- Add lsphp packages and replicate for lsphp81 [69b2a63](https://github.com/demyxsh/code-server/commit/69b2a637a57a6cc19139604b69b3d2bc3320c012)
- Set fallback [b4a7230](https://github.com/demyxsh/code-server/commit/b4a7230a57f6bde1e3ecc499102c59f28baee8cc)
- Configure php extensions [8e02fa1](https://github.com/demyxsh/code-server/commit/8e02fa1f8f99770baf00b18b5eca8c2beb9c1404)
- Add new files [e2f3cf5](https://github.com/demyxsh/code-server/commit/e2f3cf5280331c53150b6c22ca5335292440efca)
- Delete [db767fe](https://github.com/demyxsh/code-server/commit/db767fed38e77d7b9fbb1aadbae31802625e45d4)
- Use new format and misc updates [4114a5b](https://github.com/demyxsh/code-server/commit/4114a5b848ff4231b0dc8978138f562c9b9cfe0c)
- Configure sudo [6f4ebe1](https://github.com/demyxsh/code-server/commit/6f4ebe1c3c4ef7ab56215b9153e108d3a8d68792)
- Combine RUN commands and add wp-cli login package [e9d190b](https://github.com/demyxsh/code-server/commit/e9d190b7f8841fb7e539e12c52ac7df576b29538)
- Update installed packages [cb417ac](https://github.com/demyxsh/code-server/commit/cb417ac267b27cc546a0f4dee9711956b3188a8d)
- Update ENVs [e638110](https://github.com/demyxsh/code-server/commit/e6381105c57736b0edfc6ca0eb42b2c6e649a841)
- Update FROM to official php image and set version to 8.0 [bdbdc1d](https://github.com/demyxsh/code-server/commit/bdbdc1d5aadb586a65a6a78050912fd25f73f7b6)

## 2023-07-03
- Fix pecl install error [e197cd8](https://github.com/demyxsh/code-server/commit/e197cd8d3528ddfe453bb8c41b8813db089e77cd)

## 2023-07-02
- Fix libssh2 library was not found error [7078b23](https://github.com/demyxsh/code-server/commit/7078b238307f0b5dbee753aada260bce56fb8733)

## 2023-06-23
- Enable auto update for ohmyzsh [5059abb](https://github.com/demyxsh/code-server/commit/5059abbba09886fa93494d968f22e9e0ce116b1d)

## 2022-09-14
- Put if statement inside the others [f7742d0](https://github.com/demyxsh/code-server/commit/f7742d04109ed11ed8ee88ee2297a6be4706c1bd)

## 2022-08-29
- Make sure file exist [c155ae7](https://github.com/demyxsh/code-server/commit/c155ae79444ffaac3c4404f9a1542ba7c6dd5da5)

## 2022-08-23
- Misc updates [582844b](https://github.com/demyxsh/code-server/commit/582844ba521b68c781dac610d38332f45954e983)
- Install roots/acorn into bedrock's composer.json [ec5fbd3](https://github.com/demyxsh/code-server/commit/ec5fbd34547c546eb7ac00702c67fde1be649c2a)
- Use latest LTS version for nvm/npm [fa47753](https://github.com/demyxsh/code-server/commit/fa477534dadab5b3f7e7d9bf6f47d9fd5d0002ff)
- Replace php extension install script [5979a67](https://github.com/demyxsh/code-server/commit/5979a67bad143538db67a887676562c96457b7e5)
- Update default packages [e897bb6](https://github.com/demyxsh/code-server/commit/e897bb6627835fa14c6ca8ce33a4dd1bc8e4092d)
- Update environment variables [6ad04a6](https://github.com/demyxsh/code-server/commit/6ad04a6c61967d223c7c8476820ad733a0b89e25)
- Update to php8 and bullseye [3c0d2cd](https://github.com/demyxsh/code-server/commit/3c0d2cda4fce47677a54ebb4bd9f49f1dc64fd92)
- Update to bullseye [2878681](https://github.com/demyxsh/code-server/commit/2878681e806ce94df91724f9bec99d8e01e8c754)
- Update traefik rules for Sage 10 [572fc87](https://github.com/demyxsh/code-server/commit/572fc87e4027e1ffff5a0ca10ea2ccd4efa99350)
- Update echo strings when opening terminal for the first time [9c7bc1a](https://github.com/demyxsh/code-server/commit/9c7bc1ac3e0e07ceecb52bd6c6a7c24d09749144)
- Update sage helper script for sage 10 [4b1c311](https://github.com/demyxsh/code-server/commit/4b1c3114bc694771732a879ccce93689ba6c1319)

## 2022-06-17
- tag-wp - add missing package default-mysql-client for wp-cli [32fb748](https://github.com/demyxsh/code-server/commit/32fb748b84a5703b4fd5746c635f144079f237b4)
- tag-bedrock/tag-openlitespeed-bedrock - echo out useful information about demyx-sage commands [8561d3a](https://github.com/demyxsh/code-server/commit/8561d3ab52698514df194a1cded5026aa4ed9c05)
- tag-bedrock/tag-openlitespeed-bedrock - create new sage project with a fixed version, add yard cache clean, add --no-interaction flag to both composer commands [7deda1a](https://github.com/demyxsh/code-server/commit/7deda1a7c2c7cc0e5af9708ebf4e73d08eeeabd8)
- tag-bedrock/tag-openlitespeed-bedrock - update demyx-sage help menu [38547c0](https://github.com/demyxsh/code-server/commit/38547c09675ed184ed25f71ad64cad66a133d0a3)
- tag-bedrock/tag-openlitespeed-bedrock - remove the error "--max-old-space-size=2048 is not allowed" [2f389c9](https://github.com/demyxsh/code-server/commit/2f389c94d67adb15cebb8a4468ab5e4bacffee86)
- Update the README with new demyx-sage usage [25f31d6](https://github.com/demyxsh/code-server/commit/25f31d6bf636f668280f9e3ae537e48c410c1f02)
- tag-openlitespeed-bedrock - use su for the npm and yarn RUN commands [e8baf7b](https://github.com/demyxsh/code-server/commit/e8baf7b85f14713a6107cedbfa3acaf47b72027f)
- tag-bedrock/tag-openlitespeed-bedrock - use a different sage code-server extension [bba0ef1](https://github.com/demyxsh/code-server/commit/bba0ef164cd70b16d6fa55ea600cd451cbea5792)
- tag-bedrock/tag-openlitespeed-bedrock - remove adding sage to the image [0513b20](https://github.com/demyxsh/code-server/commit/0513b209b067121e55b3faa713df33f8b89329bb)
- tag-bedrock/tag-openlitespeed-bedrock - replace node lts version with a fixed version [416ef8c](https://github.com/demyxsh/code-server/commit/416ef8c4facbace151d4eeaac59406d0705b16c1)
- tag-bedrock/tag-openlitespeed-bedrock - add missing package default-mysql-client for wp-cli [d4218b5](https://github.com/demyxsh/code-server/commit/d4218b5bda90342b7b2672f36c3f4c80bc73924c)
- tag-bedrock/tag-openlitespeed-bedrock - add new environment variables: DEMYX_NODE_VERSION DEMYX_SAGE_VERSION [a946d0f](https://github.com/demyxsh/code-server/commit/a946d0f146a3f5866308b883443561a4e39317ed)

## 2022-03-24
- Use find to find the workbench.html since it's been relocating in recent code-server updates [297d5b8](https://github.com/demyxsh/code-server/commit/297d5b828aceba3ccc412c785efccdc03974ff50)
- Use canvas as the default gpu acceleration for the terminal [e8f981c](https://github.com/demyxsh/code-server/commit/e8f981c12e4b4990fe977256dddf631bfbc9f669)
- Remove old directories [a97f44f](https://github.com/demyxsh/code-server/commit/a97f44f27e1a442f0f74afcc6bd171681919d327)
- Use cp instead of rm [081d551](https://github.com/demyxsh/code-server/commit/081d5516f5a8d2f273918f0f2490c57a23f2cce0)

## 2022-03-16
- Symlink /demyx directory [fbe89c1](https://github.com/demyxsh/code-server/commit/fbe89c1e40df180801d92e31a869ef60740bde44)

## 2022-02-10
- New script to update all code-server extensions [caff5aa](https://github.com/demyxsh/code-server/commit/caff5aa0a9e7cf48475a1f7937f74a307cf1ae31)

## 2022-01-15
- Put back code to inject custom fonts [e233d22](https://github.com/demyxsh/code-server/commit/e233d22eb9b5de07ed4bf857a0a03e0fce0f4fe3)
- Change ZSH_THEME back to powerlevel10k/powerlevel10k [8b8c20c](https://github.com/demyxsh/code-server/commit/8b8c20c481630dab61a00a3634866993b6cd4bde)
- Remove default code-server version [8b9ae13](https://github.com/demyxsh/code-server/commit/8b9ae13ff342c4b6f67026c550643a6353abc446)
- Change back SHELL THEME to powerlevel10k [dc63c21](https://github.com/demyxsh/code-server/commit/dc63c21ae2a21502598c33ba248a19b65ef6751e)

## 2022-01-14
- Update SHELL THEME [7bcfff6](https://github.com/demyxsh/code-server/commit/7bcfff684b90c96b28ac9f52e6c373c65fc6d034)
- Remove custom font injection for now [144771e](https://github.com/demyxsh/code-server/commit/144771e0214d0776076b9ef822b3a42f76d5105e)
- Remove extension ryu1kn.partial-diff [8b58972](https://github.com/demyxsh/code-server/commit/8b589721c446ad3a94d9610c20cdfa90bd0c146f)
- Change theme to ys for now [5b7affa](https://github.com/demyxsh/code-server/commit/5b7affa1e994b2613ca43a90a7ad1fcae6926aac)

## 2021-11-02
- Use wildcard when replacing shell path [afde53f](https://github.com/demyxsh/code-server/commit/afde53f8428e24efb26e500f6e6fb562393f69fa)

## 2021-07-14
### tag-openlitespeed
- Update OLS default version [7a88aaa](https://github.com/demyxsh/code-server/commit/7a88aaa8f30af3daf91c2cdeb0b1a94909814ea9)

### tag-openlitespeed-bedrock
- Update OLS default version [7a88aaa](https://github.com/demyxsh/code-server/commit/7a88aaa8f30af3daf91c2cdeb0b1a94909814ea9)

## 2021-05-06
### tag-bedrock
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed
### tag-browse
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed
### tag-go
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed
### tag-latest
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed
### tag-openlitespeed
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed
### tag-openlitespeed-bedrock
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed
### tag-wp
- Added
- Changed
    - Rearrange order of entrypoint commands.
    - Add double checks for missing git repos.
- Removed

## 2021-03-08
### tag-bedrock
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed
### tag-browse
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed
### tag-go
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed
### tag-latest
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed
### tag-openlitespeed
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed
### tag-openlitespeed-bedrock
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed
### tag-wp
- Added
- Changed
    - Move export GPG_TTY variable to the bottom.
    - Make GPG_TTY variable use the TTY variable.
- Removed

## 2021-03-03
### tag-openlitespeed
- Added
- Changed
    - Move WordPress rewrite rules to the bottom so the security rules works again.
- Removed

### tag-openlitespeed-bedrock
- Added
- Changed
    - Move WordPress rewrite rules to the bottom so the security rules works again.
- Removed

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
