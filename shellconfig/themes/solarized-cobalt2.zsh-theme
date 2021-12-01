    1 #
    2 # Cobalt2 Theme - https://github.com/wesbos/Cobalt2-iterm
    3 #
    4 # # README
    5 #
    6 # In order for this theme to render correctly, you will need a
    7 # [Powerline-patched font](https://gist.github.com/1595572).
    8 ##
    9 ### Segment drawing
   10 # A few utility functions to make it easy and re-usable to draw segmented prompts
   11
   12 CURRENT_BG='NONE'
   13 SEGMENT_SEPARATOR=''
   14
   15 # Begin a segment
   16 # Takes two arguments, background and foreground. Both can be omitted,
   17 # rendering default background/foreground.
   18 prompt_segment() {
   19   local bg fg
   20   [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
   21   [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
   22   if [[ $CURRENT_BG != 'NONE' && $1 != $URRENT_BG ]]; then
   23     echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
   24   else
   25     echo -n "%{$bg%}%{$fg%} "
   26     # echo $(pwd | sed -e "s,^$HOME,~," | sed "s@\(.\)[^/]*/@\1/@g")
   27     # echo $(pwd | sed -e "s,^$HOME,~,")
   28   fi
   29   CURRENT_BG=$1
   30   [[ -n $3 ]] && echo -n $3
   31 }
   32
   33 # End the prompt, closing any open segments
   34 prompt_end() {
   35   if [[ -n $CURRENT_BG ]]; then
   36     echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
   37   else
   38     echo -n "%{%k%}"
   39   fi
   40   echo -n "%{%f%}"
   41   CURRENT_BG=''
   42 }
   43
   44 ### Prompt components
   45 # Each component will draw itself, and hide itself if no information needs to be shown
   46
   47 # Context: user@hostname (who am I and where am I)
   48 prompt_context() {
   49   local user=`whoami`
   50
   51   if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
   52     prompt_segment black default "%(!.%{%F{yellow}%}.)"
   53   fi
   54 }
   55
   56 # Git: branch/detached head, dirty status
   57 prompt_git() {
   58   local ref dirty
   59   if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
   60     ZSH_THEME_GIT_PROMPT_DIRTY='±'
   61     dirty=$(parse_git_dirty)
   62     ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
.config/shellconfig/themes/cobalt2.zsh-theme                                                                                                                                                                                                                        1,1            Top
C
