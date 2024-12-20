#!/usr/bin/env bash

tmux_ressurect_sessions_path="$HOME/.local/share/tmux/resurrect"

read -r temp_file < /tmp/ipcc
session_name=$1

echo $temp_file
echo $session_name

notify='tmux display-message -d 0 "Session \$2 was saved"'

if [[ $2 == "new" ]]; then

    cmd="mv\ $temp_file\ %1\ >\ \/tmp\/tmux-log 2>&1\ && $notify"
    tmux command-prompt -p "New session name:,Confirm?"  "run $cmd"

else

    cmd='mv \$1 $session_name > /tmp/tmux-log 2>&1  && \$notify'
    tmux command-prompt -p "Confirm?" 'run "$cmd"'

fi
