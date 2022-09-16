#zhistory# Access to binary files (multiple paths on top of $PATH)
export PATH="$HOME/.config/bin:$PATH"
export PATH="$HOME/Library/Python/3.8/bin:$PATH"
export PATH="$HOME/.pyenv/shimes:$PATH"
export PATH="$HOME/.pyenv/versions/2.7.18/bin:$PATH"
export PATH="$HOME/:/opt/homebrew/bin:$PATH"
export PATH="$HOME/:/opt/homebrew/sbin:$PATH"
export PATH="$HOME/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/bins:$PATH"

# Python please work now
# https://www.mediaglasses.blog/2021/10/30/managing-python-on-macos-monterey/
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Alias for Intel based Homebrew install
alias brow='arch --x86_64 /usr/local/Homebrew/bin/brew'

# Improves cli history search with arrows
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
bindkey "^p" up-line-or-search # Up
bindkey "^n" down-line-or-search # Down
bindkey "^k" up-line-or-search # Up
bindkey "^j" down-line-or-search # Down

# Useful Functions
source "$ZDOTDIR/utils/functions"

# Theme, colors and prompt
zsh_add_file "/themes/cobalt2.zsh-theme"
# Source Z jump
zsh_add_file "/z/z.zsh"

setopt prompt_subst # Allow fancy stuff with prompt
setopt autocd # Ommit cd when changing directory
setopt menucomplete # Insert first match on ambiguous completion
unsetopt RM_STAR_SILENT # Will ask you before executing the rm command with a star: rm folder/*
setopt RM_STAR_WAIT # Wait ten seconds before executing the rm command with a star: rm folder/*
stty stop undef	# Disable ctrl-s to freeze terminal

# Source aliases
for f in $ZDOTDIR/aliases/*; do source "$f"; done

# My original completion setup
# source $ZDOTDIR/completion

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line

# # Sets iterm 2 tab/window title to current directory
autoload -U add-zsh-hook
DISABLE_AUTO_TITLE="true"
tab_title() {
  echo -ne "\e]1;${PWD##*/}\a"
}
add-zsh-hook precmd tab_title

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
