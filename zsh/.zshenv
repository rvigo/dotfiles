export PATH={{brew_home}}/bin:$PATH

{{#if (eq os "ubuntu")}}
# fixes ubuntu link color
export LS_COLORS=$LS_COLORS:'ow=30;42:tw=30;42'
{{/if}}

export GPG_TTY=$TTY
export EDITOR=$(which vi)
export VISUAL=$(which vi)
export HOMEBREW_NO_ANALYTICS=1
export JAVA_HOME=$HOME/.sdkman/candidates/java/current
export CARGO_HOME=$HOME/.cargo/env

FPATH="{{brew_home}}/share/zsh/site-functions:${FPATH}"

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
