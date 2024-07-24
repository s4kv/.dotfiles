# prompt
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
PURE_GIT_PULL=0
zstyle :prompt:pure:git:stash show yes
prompt pure

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sakvi/.zshrc'

# autoload -Uz compinit
# compinit

# ALIAS
alias ls='exa'
alias grep='grep --color=auto'
alias cat='bat'
alias cd='z'

# xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'


# ZNAP
# Download Znap, if it's not there yet.
[[ -r ~/Repos/znap-pluggins/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap-pluggins/znap
source ~/Repos/znap-pluggins/znap/znap.zsh  # Start Znap

# `znap prompt` makes your prompt visible in just 15-40ms!
# znap prompt sindresorhus/pure

# `znap function` lets you lazy-load features you don't always need.
# znap function _pyenv pyenv "znap eval pyenv 'pyenv init - --no-rehash'"
# compctl -K    _pyenv pyenv

# `znap install` adds new commands and completions.

# # znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-syntax-highlighting 
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions 

# ZOXIDE
eval "$(zoxide init zsh)"



