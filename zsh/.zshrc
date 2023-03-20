export GPG_TTY=$TTY
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

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

function update_title {
    case "$TERM" in
        xterm*|rxvt*|alacritty*) print -Pn "\e]2;%n@${HOST%%.*}: %~\a" ;;
    esac
}
update_title

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

export EDITOR=$(which vi)
export VISUAL=$(which nvim)
export HOMEBREW_NO_ANALYTICS=1
export JAVA_HOME=$HOME/.sdkman/candidates/java/current
ZSH_HIGHLIGHT_MAXLENGTH=200
ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$(brew --prefix)/share/zsh-syntax-highlighting/highlighters
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=()
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=( forward-char forward-word end-of-line )
source $HOME/.functions
source $HOME/.aliases

# Plugins
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/plugins/git/git-prompt.zsh
source $HOME/.zsh/plugins/dircycle/dircycle.zsh
source $HOME/.zsh/plugins/command-not-found/command-not-found.zsh
source $HOME/.zsh/plugins/aws/aws.zsh
source $HOME/.zsh/plugins/zsh-interactive-cd/zsh-interactive-cd.zsh
source $HOME/.config/cl/cl-exec-widget

PROMPT="%(?:%F{green%}> :%F{red%}> )"
PROMPT+=$'%F{cyan%}%(4~|...|)%3~ %F{yellow%}$(git_super_status)%f\n%# '

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
