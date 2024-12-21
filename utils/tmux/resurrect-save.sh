#!/usr/bin/env bash

tmux_ressurect_sessions_path="$HOME/.local/share/tmux/resurrect"

tmux set -g @resurrect-hook-post-save-layout "echo"

save_script=$(tmux show-options -gqv @resurrect-save-script-path)

last_session_file="$tmux_ressurect_sessions_path/last"

[[ -L $last_session_file ]] && rm $last_session_file

temp_file=$(tmux run $save_script)

notify() {

    echo "tmux display-message -d 2 \\\"Session $1 was saved\\\""
}

resetlast() {

    echo "rm $last_session_file && ln -s $tmux_ressurect_sessions_path/$1 $last_session_file"
}

confirm() {

    echo "confirm-before -p 'Save session as $1? (y/n)'"
}

if [[ $1 == "new" ]]; then

    cmd="mv $temp_file $tmux_ressurect_sessions_path/%1 && $(notify %1) && $(resetlast %1)"
    tmux command-prompt -p "New session name:" "$(confirm %1) 'run \"$cmd\"'"

else

    cmd="mv $temp_file $1 && $(notify $(basename $1)) && $(resetlast $(basename $1))"
    tmux confirm-before -p "Save session to $(basename $1)? (y/n)" "run \"$cmd\""

fi
