typeset -U path cdpath fpath manpath

# Use emacs keymap as the default.
bindkey -e

autoload -U compinit && compinit
source @zsh-autosuggestions-pkg@/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history)

HISTSIZE=10000
SAVEHIST=10000

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

eval "$(fzf --zsh)"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "$\{(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
#
# TODO: download fzf-tab
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

autoload -U add-zsh-hook

# TODO: add vte
. @vte-pkg@/etc/profile.d/vte.sh

alias -- diff='diff --color=always'
alias -- ff=fastfetch
alias -- g=git
alias -- gia='git add .'
alias -- gic='git commit -am'
alias -- gich='git checkout'
alias -- gidi='git diff'
alias -- gis='git status'
alias -- grep='grep --color=always'
alias -- kc=kubectl
alias -- kubectx='kubectl config use-context'
alias -- lg=lazygit
alias -- ll='eza -a --icons=auto -l -h'
alias -- ls='eza -a --icons=auto'
alias -- nv=nvim
alias -- watch=viddy
alias -- weather='curl v2.wttr.in/Moscow'
alias -- yz='yazi'

# Plugins

source @zsh-fsh-pkg@/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source @zsh-hss-pkg@/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
source @zsh-fzf-pkg@/share/fzf-tab/fzf-tab.plugin.zsh

bindkey "^R" history-incremental-pattern-search-backward
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

export WORDCHARS='#*?_-.[]~=&;!#$%^(){}<>'

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
	eval "$(zoxide init zsh)"
fi
#
