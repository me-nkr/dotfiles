#!/usr/bin/env bash

session_file=$1

tmux_ressurect_sessions_path="$HOME/.local/share/tmux/resurrect"

restore_script=$(tmux show-options -gqv @resurrect-restore-script-path)

if [[ -n $restore_script ]]; then 

    last_session_file="$tmux_ressurect_sessions_path/last"

    [[ -L $last_session_file ]] && rm $last_session_file

    ln -s $session_file $last_session_file

    tmux run $restore_script

else

    tmux display-message -d 3 "Resurrection script not found"
    exit 1

fi
