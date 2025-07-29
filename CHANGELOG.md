# CHANGELOG

## 2025-07-28
- Include subshells for error checking [0e34ca9](https://github.com/demyxsh/code-server/commit/0e34ca9f0b9a77e0c1a8dd42e924ff30529891c1)
- Remove unused variables [f2fd300](https://github.com/demyxsh/code-server/commit/f2fd300a6e4a9d1c52bea345c1da0ae95df04313)
- Rename/delete files/variables [961b095](https://github.com/demyxsh/code-server/commit/961b0959a1f7a02fa47c3e195eeb17b55d1380c1)
- Fix WordPress URL error [290f512](https://github.com/demyxsh/code-server/commit/290f512fca80e0f4e9be6a05182799b824bc144d)
- Update versions [cbe1dd9](https://github.com/demyxsh/code-server/commit/cbe1dd92e1c4e87640963acaa6c4731ebef80d1f)
- Combine functions [71b3b9a](https://github.com/demyxsh/code-server/commit/71b3b9adbf19658389bc121c881b1fd8c7c9bbbd)
- Allow config override [3d52810](https://github.com/demyxsh/code-server/commit/3d5281024cb36d518cb7da5d68034ff4df5d4e3f)
- Update entrypoint so code-server is pid 1 [5a0d0b3](https://github.com/demyxsh/code-server/commit/5a0d0b327f3ba32a223e0af02d4f0f336f3898bd)
- Update sudo [135edb5](https://github.com/demyxsh/code-server/commit/135edb559fc3ca2c05fa3f56263177bde72b2e79)
- Update packages [683a473](https://github.com/demyxsh/code-server/commit/683a473cd55feaa00457444de38a0b711eea6fbb)
- Fix imagick install error [9ec922e](https://github.com/demyxsh/code-server/commit/9ec922e1bc32e1aafb173196e86a22f08327c23e)
- Simplify `demyx_config_php` [da3a0f1](https://github.com/demyxsh/code-server/commit/da3a0f108b48f7f2d6d8e12516589b682ebb601e)
- `demyx_config_www()` is now fully automated [bc13ef8](https://github.com/demyxsh/code-server/commit/bc13ef8fcda60bb728ee5a0f23c6460381f7899d)
- New variables [e50e326](https://github.com/demyxsh/code-server/commit/e50e32623d640c0eeeffda66f0b0b6c57e5f8e29)
- Force symlink [b6f43b4](https://github.com/demyxsh/code-server/commit/b6f43b45539b36fb91ddf215ea9527d1396daadf)
- Create missing xdebug.ini [242f80b](https://github.com/demyxsh/code-server/commit/242f80b9f174b5a41da0d4341d65dbfaf23022e3)
- Direct people to demyx [51277f5](https://github.com/demyxsh/code-server/commit/51277f5f18004093818ba022fa6a06aa975a9214)
- Misc update [c508668](https://github.com/demyxsh/code-server/commit/c508668739c672e0244b1d1afbbabd4a7d045830)
- Add symlink to switch lsphp version [be83373](https://github.com/demyxsh/code-server/commit/be833733cae8f6242d3f159ba31011e8e30f36de)
- Compile xdebug so there is no version mismatch [f01050d](https://github.com/demyxsh/code-server/commit/f01050daedd36fd04cfc2b3c730895d9b1394466)
- Change pgrep string [0f0cf7e](https://github.com/demyxsh/code-server/commit/0f0cf7e5d318e2b0abe71935fc3ed8b073b8163b)
- Refactor Dockerfile and entrypoint scripts to remove powerlevel10k theme, update VS Code extensions, and enhance SSH setup. Adjust settings for editor and improve configuration handling in demyx scripts. [a0fd27a](https://github.com/demyxsh/code-server/commit/a0fd27a66c83ce848a99e96846974b0f29d88134)
- Update GitHub Actions workflow to use run ID in commit message for scheduled builds [d85d5c6](https://github.com/demyxsh/code-server/commit/d85d5c6ca471285639f9ffe9e9cb04cbfa546826)
- Update Dockerfile to use debian:bookworm-slim as the base image [369824a](https://github.com/demyxsh/code-server/commit/369824a0864683d0e4052be73b1660c9da46018f)

## 2024-03-25
- Install latest version of Docker through package manager [8ee678b](https://github.com/demyxsh/code-server/commit/8ee678b3f475eee9b8f4f49a2fe4c3fba99d0c2e)
- Remove docker-compose package since the latest version of Docker now has compose installed as a plugin [d7400a8](https://github.com/demyxsh/code-server/commit/d7400a88c930f2fe95eb25ea875d2079253dd057)

## 2024-03-07
- Fix container crashes [93d2749](https://github.com/demyxsh/code-server/commit/93d2749b35321868a143a7dea336138cd2b8d6af)
- The demyx container will handle this [adf3f57](https://github.com/demyxsh/code-server/commit/adf3f5708a17b62b7ef3084ebe73ba0956c56fd9)
- Backup extensions before updating [2b51b50](https://github.com/demyxsh/code-server/commit/2b51b506488058ee8128a2db0c366365b5841c9e)
- Execute `demyx motd` when the terminal starts [b075b9e](https://github.com/demyxsh/code-server/commit/b075b9e213de0bdb63ccd7ea74794069e3a7e0e6)

## 2024-03-05
- Remove shorthand since it was causing the container to crash [c02fbca](https://github.com/demyxsh/code-server/commit/c02fbcad6562b138edaf2a64c201a9ad0f27199e)
- Remove missing package [58d2c3c](https://github.com/demyxsh/code-server/commit/58d2c3c5c8f10e15e6ff032db10f3e3fe57bf236)
- Forgot to remove this shorthand [1b9920e](https://github.com/demyxsh/code-server/commit/1b9920e00e3eb195adb76927bf86f89d61b0523f)

## 2024-02-28
- Remove title from first line to prevent outputting error [e4a82e9](https://github.com/demyxsh/code-server/commit/e4a82e993fcea86d8e9bf6f9886c26c4764b0cd2)
- Backup extensions before updating [f325d4a](https://github.com/demyxsh/code-server/commit/f325d4a372513989a67fde5f95419e78c807bde1)
- Fix reboot container crash [615ad9c](https://github.com/demyxsh/code-server/commit/615ad9c7cbc0d96ba252072193638344e4061a2d)
- 2024-02-20 [0a9814e](https://github.com/demyxsh/code-server/commit/0a9814ec2fb17031b95a01b3d3cff97671336b2e)
- Allow users to add custom cron [3f8e06a](https://github.com/demyxsh/code-server/commit/3f8e06ab726e975416d6d00332ff88b4fe2aec2b)
- Include missing create rule [e660242](https://github.com/demyxsh/code-server/commit/e6602421af8cc7637156f90076fdd5e341488ea0)
- 2024-02-08 [7bb136b](https://github.com/demyxsh/code-server/commit/7bb136b4291b6705e4ed5c67a84efafc358458f1)
- Merge branch 'master' of github.com:demyxsh/code-server [ecd8316](https://github.com/demyxsh/code-server/commit/ecd8316e22f10f0160bf27397b629ac17a7e1206)
- Update description with shameless plug [e1e8537](https://github.com/demyxsh/code-server/commit/e1e85370468f5c644cd6a338e6eb3aaca646a602)
- Misc updates [33b88a5](https://github.com/demyxsh/code-server/commit/33b88a54530b02e36820bb4d949b10de61899bd6)
- Use tidy package to scrape the latest stable version in openlitespeed's downloads page [33a2945](https://github.com/demyxsh/code-server/commit/33a2945d6665df827113002cce791d51bd610c04)
- Add packages [2fac1fc](https://github.com/demyxsh/code-server/commit/2fac1fcec90d5c413b1c7541af036ec2798ed98b)
- Add missing environment variables [8c244fa](https://github.com/demyxsh/code-server/commit/8c244fafdfc5dbb8db3812931b1bb56fceef602c)
- Update rewrite rule [5fd7a59](https://github.com/demyxsh/code-server/commit/5fd7a5983516ee4f8498244bd70ee6f3609b5d57)
- Use new function to include all demyx environment variables  for lsphp [946eeb3](https://github.com/demyxsh/code-server/commit/946eeb3e1571fe8ec23e464920ee587af5fb3d59)
- New function to auto calculate values for `LSAPI_EXTRA_CHILDREN` and `LSAPI_MAX_IDLE_CHILDREN` [8dfe52b](https://github.com/demyxsh/code-server/commit/8dfe52bc2c22d2d48d97c5a81f3d105de670bb56)
- Update php versions and set default to 8.1 [51d6631](https://github.com/demyxsh/code-server/commit/51d6631d81aa0415666a3a3b74c47fb8433c2c75)
- New function to reset permissions at container start and hourly cron [4539909](https://github.com/demyxsh/code-server/commit/4539909be5e25a5dffc282f0b6688930c3e2da25)
- Add environment variables [2d7bf0d](https://github.com/demyxsh/code-server/commit/2d7bf0d43f527f66d3254caa0ba3823af0f6d065)
- Double the upload limit [9674616](https://github.com/demyxsh/code-server/commit/967461655daae521e30fa00a7415f422ebaea427)
- Remove environment variables [9424721](https://github.com/demyxsh/code-server/commit/9424721b874e4ef1cf38fe0422771b1d89ad0771)
- Include custom volume [656addd](https://github.com/demyxsh/code-server/commit/656addd9b4d44f8006259470e906a6bd5c5a127e)

## 2023-11-14
- Disable installation of default themes/plugins when upgrading [3b1c5df](https://github.com/demyxsh/code-server/commit/3b1c5dfd186497395a98379e2f01581b5ab079c6)

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
