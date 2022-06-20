#!/bin/sh

# August 2021 - Marius Duboule
#
# Goal is to automate new sessions that include git, npm and dev windows for
# already known client folders (rely on z command).
#
# TO DO
# - Improve change of working directory using z earlier in the script, so
#   that new windows are already in the right directory.
# - We can probably refactor some of this.
#
# Useful resources
# https://newbedev.com/create-new-tmux-session-from-inside-a-tmux-session
# https://til.hashrocket.com/posts/ebvekqrzvx-change-tmux-working-directory-while-in-session
# https://stackoverflow.com/questions/10362501/tmux-pipe-pane-not-working

session_exists=""
is_new_session=fals
z_value=$(/bin/zsh -i -c "z -e $1")

# test for empty argument
if [ -z "$1" ]; then
	echo "(s.sh) Error: you need to pass a non empty value for the script to work."
	exit 1
# test for empty value when searching using z-jump
elif [ -z "$z_value" ]; then
	echo "(s.sh) Error: couldn't find a match while searching the z catalog."
	exit 2
fi

# Check if tmux session already exists
if [ "$TERM_PROGRAM" != tmux ]; then
  is_new_session=true
else
  session_exists=$(tmux list-sessions | grep $1)
fi

# if tmux is active and we already have a session w same name
if [ "$is_new_session" != true ] && [ "$session_exists" != "" ] ; then
  echo 'Switching to pre-existing session'
  tmux switch-client -t $1:1
  echo 'Exit 0'
  exit 0
fi

# if this is a new tmux session, then create one from scratch
if [ "$is_new_session" = true ] ; then
  echo "new session"
  tmux new -s $1 -n 'git' \; \
    split-window -h \; \
    new-window -n 'dev' \; \
    new-window -n 'npm' \; \
    split-window -h \; \
    send-keys -t $1:1.0 "z $1 && clear" C-m \; \
    send-keys -t $1:1.1 "z $1 && clear" C-m \; \
    send-keys -t $1:2.0 "z $1 && clear && vi" C-m \; \
    send-keys -t $1:3.0 "z $1 && clear" C-m \; \
    send-keys -t $1:3.1 "z $1 && clear" C-m \; \
    switch-client -t $1:1 \; \

# but if tmux is already active just add another session
else
  echo "add new session"
  tmux new-session -s $1 -d
  tmux rename-window -t $1:1 'git'
  tmux split-window -h -t $1:1
  tmux new-window -n 'dev' -t $1:
  tmux new-window -n 'npm' -t $1:
  tmux split-window -h -t $1:3
  tmux send-keys -t $1:1.0 "z $1 && clear" C-m
  tmux send-keys -t $1:1.1 "z $1 && clear" C-m
  tmux send-keys -t $1:2.0 "z $1 && clear && vi" C-m
  tmux send-keys -t $1:3.0 "z $1 && clear" C-m
  tmux send-keys -t $1:3.1 "z $1 && clear" C-m
  tmux switch-client -t $1:1
fi
