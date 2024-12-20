#!/usr/bin/env bash

tmux_ressurect_sessions_path="$HOME/.local/share/tmux/resurrect"

file_list=("$tmux_ressurect_sessions_path/"*)

menu_structure="menu -T 'Select session'"

[[ $1 == "-s" ]] && file_list=("new" ${file_list[@]})

for idx in "${!file_list[@]}"; do

    filename="${file_list[$idx]}"

    [[ $(basename $filename) == "last" ]] && continue
    [[ $(basename $filename) == tmux_resurrect_* ]] && continue

    if [[ $1 == "-s" ]]; then

        cmd="\$HOME/dotfiles/utils/tmux/resurrect-save.sh '$filename' > /tmp/tmux-log 2>&1"

    else

        cmd="\$HOME/dotfiles/utils/tmux/resurrect-restore.sh '$filename' > /tmp/tmux-log 2>&1"

    fi

    menu_structure+=" \
        '$(basename $filename)' \
        '$((++$idx))' \
        'run \"$cmd\"'"
done

eval tmux $menu_structure || exit 1
