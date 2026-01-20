FROM fedora:44


ARG USERNAME=runner
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && mkdir -p /home/$USERNAME/.ssh \
    && chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh \
    && chmod 700 /home/$USERNAME/.ssh

RUN dnf install -y \
    ca-certificates \
    wget \
    gnupg \
    git \
    openssh-clients \
    glibc-langpack-en \
    procps-ng \
    less \
    gcc \
    gcc-c++ \
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
    && \
    rpm --import https://downloads.1password.com/linux/keys/1password.asc && \
    sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://downloads.1password.com/linux/keys/1password.asc" > /etc/yum.repos.d/1password.repo' && \
    dnf install -y 1password-cli && \
    dnf copr enable -y atim/starship  && \
    dnf copr enable -y jdxcode/mise && \
    dnf install -y mise starship && \
    usermod -s /usr/bin/zsh $USERNAME && \
    dnf clean all


ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8


USER $USERNAME
WORKDIR /home/$USERNAME

RUN git clone --depth=1 https://github.com/mattmc3/antidote.git /home/$USERNAME/.antidote \
    && touch /home/$USERNAME/.zsh_plugins.txt

ENV PNPM_HOME="/home/$USERNAME/.local/share/pnpm"
ENV PATH="$PNPM_HOME:/home/$USERNAME/.local/bin:$PATH"
ENV EDITOR=nvim
ENV UV_COMPILE_BYTECODE="1"

RUN echo 'eval "$(mise activate zsh)"' >> /home/$USERNAME/.zshrc && \
    mise use -g node pnpm uv usage carapace rust && \
    mise x -- pnpm add -g @anthropic-ai/claude-code && \
    rm -rf /home/$USERNAME/.local/share/mise/cache/* && \
    rm -rf /home/$USERNAME/.local/share/mise/downloads/*

RUN mkdir -p /home/$USERNAME/.cache/uv \
    /home/$USERNAME/.claude \
    /home/$USERNAME/.config/anthropic \
    /home/$USERNAME/.1password \
    /home/$USERNAME/.local/share/mise \
    /home/$USERNAME/.local/share/nvim \
    /home/$USERNAME/.local/state/nvim \
    /home/$USERNAME/.cache/antidote

CMD ["sleep", "infinity"]

