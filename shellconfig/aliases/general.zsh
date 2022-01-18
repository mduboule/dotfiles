alias {vi,vim,nvim}='/opt/homebrew/bin/nvim'

# Alias for Intel based Homebrew install
alias brow='arch --x86_64 /usr/local/Homebrew/bin/brew'

# Ref: https://stackoverflow.com/questions/64951024/how-can-i-run-two-isolated-installations-of-homebrew
# I also created another handy alias in .zshrc
# so I can prepend any Homebrew-installed command
# with ib to force using the Intel version of that command
alias ib='PATH=/usr/local/bin'

alias sz='source ~/.config/.zshrc'
alias ez='nvim ~/.config/.zshrc'

alias c=clear
alias md=mkdir
alias rd=rmdir
alias ls='ls -G -p'
alias ll='ls -lA'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias /='cd /'
alias ~='cd ~'
alias -- -='cd -'

alias rm=trash
alias myip="curl http://ipecho.net/plain; echo"
