export LANG=en_US.UTF-8

# MISE

eval "$(mise activate zsh)"

export EDITOR=nvim
# ------------
#
# Antidote installation path for Linux
# Install antidote: git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
source "${ZDOTDIR:-${HOME}}/.antidote/antidote.zsh"

fpath=(
    "${HOME}/.zsh/completions"
    "${XDG_DATA_HOME}/zsh/site-functions"
    $(antidote path)
    "${fpath[@]}"
)

fpath=(${(u)fpath})

autoload -Uz compinit
compinit

autoload bashcompinit && bashcompinit

antidote load

if command -v carapace &> /dev/null; then
    export CARAPACE_BRIDGES='zsh,bash,inshellisense'
    zstyle ':completion:*' format-explanation '  %e'
    source <(carapace _carapace)
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select




# Starship
eval "$(starship init zsh)"

# fzf
if command -v fzf &> /dev/null; then
    source <(fzf --zsh) 
fi


if command -v dircolors &> /dev/null; then
    eval "$(dircolors -b)"
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
else
    export CLICOLOR=1
fi

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
zstyle ':fzf-tab:*' fzf-bindings 'forward-slash:accept'
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-e:accept'
# -------------------
# zsh options

bindkey -e

setopt auto_cd
setopt autopushd
typeset -i DIRSTACKSIZE=127

export WORDCHARS=${WORDCHARS/\/}

# shell hotkey settings

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^U' backward-kill-line
bindkey '^X^E' edit-command-line

autoload -Uz reverse-menu-complete
zle -N reverse-menu-complete
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down



# aliases
alias rm='rm -i'
alias mv='mv -i'
alias vim='nvim'
alias watch='watch --color'

alias pip='uv pip'
alias pip3='uv pip'
alias python='python3'

alias fd='fd --color=auto'
alias tf='terraform'
alias ls='ls --color=auto'
alias grep='grep --color=auto'


function wellcome() {
    if ! command -v cowsay &> /dev/null; then return; fi

    local cows=( alpaca bud-frogs cheese cupcake daemon elephant eyes fox head-in llama milk moose mutilated stegosaurus sus turtle tux)
    local cow=$(shuf -n 1 -e "${cows[@]}")
    local mood=$(shuf -n 1 -e -- -b -d -g -p -s -t -w)

    figlet -c "Welcome $1" \
        | cowsay -n "$mood" -f "$cow" \
        | lolcat
}



[[ -o interactive ]] && wellcome "YuzuRu"
