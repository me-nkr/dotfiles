#!/usr/bin/env bash

session_file=$1

tmux_ressurect_sessions_path="$HOME/.local/share/tmux/resurrect"

last_session_file="$tmux_ressurect_sessions_path/last"

[[ -L $last_session_file ]] && rm $last_session_file

ln -s $session_file $last_session_file
