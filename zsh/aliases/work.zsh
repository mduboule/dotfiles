alias s='s.sh'
alias ide='ide.sh'
alias up='up.sh'

fwcompare() {
  git diff --no-index $(find node_modules/@softlimit/framework/src -path '*'$1) $(find src -path '*'$1)
}
