FROM fedora:44


ARG USERNAME=runner
ARG USER_UID=1000
ARG USER_GID=1000


ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

ARG HOST_USER
ARG HOST_DOMAIN=host.orb.internal
ARG HOST_OP_PATH


LABEL org.opencontainers.image.created="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
      org.opencontainers.image.authors="Nagato Yuruzu <x4.nagato.yuzuru@gmail.com>" \
      org.opencontainers.image.source="https://github.com/Nagato-Yuzuru/agent-runner-base" \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.title="Fedora Agent Runner" \
      org.opencontainers.image.description="High-performance sandbox for AI agents, featuring Python, Go, Rust, and Node.js toolchains." \
      org.opencontainers.image.licenses="Apache-2.0"


RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && mkdir -p /home/$USERNAME/.ssh \
    && chown -R $USERNAME:$USERNAME /home/$USERNAME \
    && chmod 700 /home/$USERNAME/.ssh \
    && dnf install -y \
    ca-certificates \
    wget \
    gnupg \
    git \
    openssh-clients \
    glibc-langpack-en \
    procps-ng \
    less \
    gcc-c++ \
    clang \
    clang-tools-extra \
    make \
    zsh \
    fd-find \
    ripgrep \
    just \
    zoxide \
    fzf \
    git-delta \
    bat \
    neovim \
    jq \
    tldr \
    zip \
    tree \
    iproute \
    bubblewrap \
    socat \
    sudo \
#    && rpm --import https://downloads.1password.com/linux/keys/1password.asc \
#    && sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://downloads.1password.com/linux/keys/1password.asc" > /etc/yum.repos.d/1password.repo' \
#    && dnf install -y 1password-cli \
    && dnf copr enable -y atim/starship \
    && dnf copr enable -y jdxcode/mise \
    && dnf install -y mise starship \
    && usermod -s /usr/bin/zsh $USERNAME \
    && dnf clean all \
    && printf '#!/bin/bash\n\
    REMOTE_ARGS=$(printf " %%q" "$@")\n\
    exec ssh -A -q -o StrictHostKeyChecking=no -T %s@%s "%s $REMOTE_ARGS"\n' \
    "${HOST_USER}" "${HOST_DOMAIN}" "${HOST_OP_PATH}" > /usr/local/bin/op \
    && chmod +x /usr/local/bin/op


ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8


USER $USERNAME
WORKDIR /home/$USERNAME


ENV PNPM_HOME="/home/$USERNAME/.local/share/pnpm"
ENV PATH="$PNPM_HOME:/home/$USERNAME/.local/bin:$PATH"
ENV EDITOR=nvim
ENV UV_COMPILE_BYTECODE="1"

RUN echo 'eval "$(mise activate zsh)"' >> /home/$USERNAME/.zshrc \
    && mise use -g node pnpm uv rust go usage carapace \
    && mise x -- pnpm add -g @anthropic-ai/claude-code \
    && rm -rf /home/$USERNAME/.local/share/mise/cache/* \
    && rm -rf /home/$USERNAME/.local/share/mise/downloads/* \
    && git clone --depth=1 https://github.com/mattmc3/antidote.git /home/$USERNAME/.antidote \
    && touch /home/$USERNAME/.zsh_plugins.txt

RUN mkdir -p /home/$USERNAME/.cache/uv \
        /home/$USERNAME/.claude \
        /home/$USERNAME/.config/anthropic \
        /home/$USERNAME/.1password \
        /home/$USERNAME/.local/share/mise \
        /home/$USERNAME/.local/share/nvim \
        /home/$USERNAME/.local/state/nvim \
        /home/$USERNAME/.cache/antidote

CMD ["sleep", "infinity"]
