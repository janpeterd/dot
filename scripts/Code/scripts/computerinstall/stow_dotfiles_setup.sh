#!/bin/sh

# Run this script before the initial stow, but after cloning the repo https://github.com/janpeterd/.dot.git

# make normal directories first, otherwise stow might symlink them
rm -rf $HOME/.config
rm -rf $HOME/.local
rm -rf $HOME/.Code
rm -rf $HOME/.school

mkdir $HOME/.config
mkdir $HOME/.local
mkdir $HOME/Code
mkdir $HOME/school

# make symlinks to home dir
rm -f $HOME/.xprofile
rm -f $HOME/.zprofile

ln -s $HOME/dot/x11/.config/x11/xprofile $HOME/.xprofile
ln -s $HOME/dot/shell/.config/shell/profile $HOME/.zprofile

rm -f $HOME/.bashrc

cd $HOME/dot


# stow
stow */
