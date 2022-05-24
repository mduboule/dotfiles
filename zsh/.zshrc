#zhistory# Access to binary files (multiple paths on top of $PATH)
export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/bins:$HOME/.config/bin:$PATH"

# Alias for Intel based Homebrew install
alias brow='arch --x86_64 /usr/local/Homebrew/bin/brew'

# Improves cli history search with arrows
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# Theme, colors and prompt
# autoload -U colors && colors
# export CLICOLOR=1
# export LSCOLORS="Gxfxcxdxbxegedabagacad"
setopt prompt_subst
source $ZDOTDIR/themes/cobalt2.zsh-theme

# Ommit cd when changing directory
setopt auto_cd

source $ZDOTDIR/completion.zsh

#fUse vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

# Will ask you before executing the rm command with a star: rm folder/*
unsetopt RM_STAR_SILENT

# Wait ten seconds before executing the rm command with a star: rm folder/*
setopt RM_STAR_WAIT

# Source aliases
for f in $ZDOTDIR/aliases/*; do source "$f"; done

# # Sets iterm 2 tab/window title to current directory
autoload -U add-zsh-hook
DISABLE_AUTO_TITLE="true"
tab_title() {
  echo -ne "\e]1;${PWD##*/}\a"
}
add-zsh-hook precmd tab_title

# Source Z jump
source $ZDOTDIR/z/z.zsh

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
