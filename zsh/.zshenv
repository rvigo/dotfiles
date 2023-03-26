# sets the homebrew home
case `uname` in
  Linux)
    brew_home=/home/linuxbrew/.linuxbrew ;;
  Darwin)
    brew_home=/opt/homebrew ;;
  *)
    brew_home= ;;
esac
if [ -n "${brew_home}" ] && [ -d "${brew_home}" ]; then
    export PATH=${brew_home}/bin:$PATH
fi

# fixes ubuntu link color
export LS_COLORS=$LS_COLORS:'ow=30;42:tw=30;42'
export GPG_TTY=$TTY
export EDITOR=$(which vi)
export VISUAL=$(which nvim)
export HOMEBREW_NO_ANALYTICS=1
export JAVA_HOME=$HOME/.sdkman/candidates/java/current
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history