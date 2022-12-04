#!/bin/sh

# Run this script before the initial stow, but after cloning the repo https://github.com/janpeterd/.dot.git

mkdir $HOME/.config
mkdir $HOME/Code
ln -s $HOME/.dot/x11/.config/x11/xprofile $HOME/.xprofile
ln -s $HOME/.dot/shell/.config/shell/profile $HOME/.zprofile
