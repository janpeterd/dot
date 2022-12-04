#!/bin/sh

mkdir -p $HOME/Code/repos
cd $HOME/Code/repos

# doom emacs

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install

# vim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install the plugins
nvim -c PlugInstall

# generate gpg-keypair, needed for pass
gpg --full-generate-key
