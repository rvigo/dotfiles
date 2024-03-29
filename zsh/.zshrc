# Set up the prompt
autoload -Uz promptinit
promptinit

setopt prompt_subst
setopt histignorealldups
setopt sharehistory
setopt histignorespace
setopt histreduceblanks
setopt autocd autopushd chaselinks pushdignoredups pushdminus
autoload -Uz vcs_info

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle :compinstall filename '$HOME/.zshrc'

ZSH_HIGHLIGHT_MAXLENGTH=200
ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$(brew --prefix)/share/zsh-syntax-highlighting/highlighters
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=()
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=( forward-char forward-word end-of-line )

# Plugins
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_PLUGINS=$HOME/.zsh/plugins
source $ZSH_PLUGINS/git/git-prompt.zsh
source $ZSH_PLUGINS/dircycle/dircycle.zsh
source $ZSH_PLUGINS/command-not-found/command-not-found.zsh
source $ZSH_PLUGINS/aws/aws.zsh
source $ZSH_PLUGINS/zsh-interactive-cd/zsh-interactive-cd.zsh
source $HOME/.config/cl/cl-exec-widget

PROMPT="%(?:%F{green%}> :%F{red%}> )"
PROMPT+=$'%F{cyan%}%(4~|...|)%3~ %F{yellow%}$(git_super_status)%f\n%# '

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# some useful aliases
alias ls='ls -h --group-directories-first --color=auto'
alias ll='ls -thalFSr'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias nv='nvim'
