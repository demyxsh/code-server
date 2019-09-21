FROM codercom/code-server:v2

LABEL sh.demyx.image demyx/code-server
LABEL sh.demyx.maintainer Demyx <info@demyx.sh>
LABEL sh.demyx.url https://demyx.sh
LABEL sh.demyx.github https://github.com/demyxco/demyx
LABEL sh.demyx.registry https://hub.docker.com/u/demyx

ENV DEBIAN_FRONTEND noninteractive
ENV TZ America/Los_Angeles
ENV PASSWORD demyx

USER root

# Install custom packages
RUN set -ex; \
    apt-get update && apt-get install -y zsh jq htop nano tzdata

# Oh My Zsh
RUN set -ex; \
    sed -i "s|/home/coder:/bin/bash|/home/coder:/bin/zsh|g" /etc/passwd; \
    mkdir -p /home/coder/.code/data/User; \
    echo "{\n    \"terminal.integrated.shell.linux\": \"/bin/zsh\"\n}" > /home/coder/.code/data/User/settings.json; \
    chown -R coder:coder /home/coder

RUN set -ex; \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"; \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git /root/.oh-my-zsh/plugins/zsh-autosuggestions; \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' /root/.zshrc; \
    sed -i "s/(git)/(git zsh-autosuggestions)/g" /root/.zshrc

RUN set -ex; \
    su -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" -s /bin/sh coder; \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/coder/.oh-my-zsh/plugins/zsh-autosuggestions; \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' /home/coder/.zshrc; \
    sed -i "s/(git)/(git zsh-autosuggestions)/g" /home/coder/.zshrc; \
    ln -s /home/coder/.zsh_history /root

COPY demyx-entrypoint.sh /usr/local/bin/demyx-entrypoint

RUN chmod +x /usr/local/bin/demyx-entrypoint

USER coder

WORKDIR /home/coder

ENTRYPOINT ["dumb-init", "demyx-entrypoint"]
