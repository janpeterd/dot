#!/bin/sh

# Run this script before the initial stow, but after cloning the repo https://github.com/janpeterd/.dot.git

# make normal directories first, otherwise stow might symlink them
mkdir $HOME/.config
mkdir $HOME/.local
mkdir $HOME/Code
mkdir $HOME/school

# make symlinks to home dir
ln -s $HOME/.dot/x11/.config/x11/xprofile $HOME/.xprofile
ln -s $HOME/.dot/shell/.config/shell/profile $HOME/.zprofile

git clone https://github.com/janpeterd/.dot.git
cd $HOME/dot


# stow
stow */
