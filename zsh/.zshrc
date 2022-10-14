export GPG_TTY=$TTY
# Set up the prompt
autoload -Uz promptinit
promptinit
setopt prompt_subst

setopt histignorealldups sharehistory
autoload -Uz vcs_info

export EDITOR="nano"

PROMPT="%(?:%F{green%}> :%F{red%}> )"
PROMPT+=$'%F{cyan%}%(4~|...|)%3~ %F{yellow%}$(git_prompt_info)%f\n\$ '
# RPROMPT='%*'

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    
    # Checks if working tree is dirty
    local STATUS=''
    local FLAGS
    FLAGS=('--porcelain')
    
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
    if [[ -n $STATUS ]]; then
        GIT_DIRTY_STAR="*"
    else
        unset GIT_DIRTY_STAR
    fi
    
    echo "$(git branch --show-current)$GIT_DIRTY_STAR"
}

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

source ~/.aliases
source ~/.functions

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

setopt histignorealldups sharehistory
setopt complete_aliases
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/zsh-interactive-cd.plugin.zsh

source ~/.config/cl/cl-exec-widget
