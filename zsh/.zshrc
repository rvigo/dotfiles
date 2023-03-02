export GPG_TTY=$TTY
# Set up the prompt
autoload -Uz promptinit
promptinit

setopt prompt_subst
setopt histignorealldups
setopt sharehistory
setopt histignorespace
setopt histreduceblanks

autoload -Uz vcs_info

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

#fix dir colors in ubuntu
if [[ -f ~/.dircolors ]] ; then
    eval $(dircolors -b ~/.dircolors)
    elif [[ -f /etc/DIR_COLORS ]] ; then
    eval $(dircolors -b /etc/DIR_COLORS)
fi

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
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle :compinstall filename '$HOME/.zshrc'

# User configuration

export EDITOR=$(which nvim)
export VISUAL="$EDITOR"
export HOMEBREW_NO_ANALYTICS=1
ZSH_HIGHLIGHT_MAXLENGTH=200
ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$(brew --prefix)/share/zsh-syntax-highlighting/highlighters

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.functions
source $HOME/.aliases

# Plugins
source ~/.zsh/plugins/git/git-prompt.zsh
source ~/.zsh/plugins/dircycle/dircycle.zsh
source ~/.zsh/plugins/command-not-found/command-not-found.zsh
source ~/.zsh/plugins/aws/aws.zsh
source ~/.zsh/plugins/zsh-interactive-cd/zsh-interactive-cd.zsh

PROMPT="%(?:%F{green%}> :%F{red%}> )"
PROMPT+=$'%F{cyan%}%(4~|...|)%3~ %F{yellow%}$(git_super_status)%f\n%# '


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/zsh-interactive-cd.plugin.zsh
source ~/.config/cl/cl-exec-widget
