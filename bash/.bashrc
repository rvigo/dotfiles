HISTSIZE=HISTFILESIZE=
HISTCONTROL=ignoreboth

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Use case-insensitive TAB autocompletion
set completion-ignore-case on

# Auto list tab completions (use instead of TAB-cycling)
set show-all-if-ambiguous on
