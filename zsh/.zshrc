export ZSH="/home/rafavigo/.oh-my-zsh"

ZSH_THEME="rvigo"

plugins=(
git
gitfast
zsh-interactive-cd
dircycle
bgnotify
)

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' menu select
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

zstyle :compinstall filename '$HOME/.zshrc'

setopt histignorealldups sharehistory

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.aliases
# source ~/.scripts

#fix dir colors in ubuntu
if [[ -f ~/.dircolors ]] ; then
    eval $(dircolors -b ~/.dircolors)
    elif [[ -f /etc/DIR_COLORS ]] ; then
    eval $(dircolors -b /etc/DIR_COLORS)
fi

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
