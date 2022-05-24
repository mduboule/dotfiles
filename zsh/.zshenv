###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################

export DOTCONFIG=$HOME/.config

# XDG
export XDG_CONFIG_HOME=$DOTCONFIG
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZSHZ_DATA=$ZDOTDIR/z/.z
export HISTFILE=$ZDOTDIR/z/.zsh_history # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

# nvm
export NVM_DIR="$HOME/.nvm"
