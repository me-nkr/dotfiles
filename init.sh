#!/usr/bin/bash

# immediate exit on error
set -e

# verify dependedncies are installed
if ! stow --version 2>&1 > /dev/null ; then
    echo "GNU Stow not installed"
    exit 1
fi

if ! git --version 2>&1 > /dev/null ; then
    echo "Git not installed"
    exit 1
fi

# install tmp using git for tmux
mkdir -p tmux/.tmux/plugins
[[ -d "./tmux/.tmux/plugins/tpm" ]] || git clone https://github.com/tmux-plugins/tpm tmux/.tmux/plugins/tpm

# install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# restow everything
stow -R bash
stow -R tmux
stow -R nvim
stow -R git
stow -R scripts
stow -R freecad
