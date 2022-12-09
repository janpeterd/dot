# dot


<p align="center">
  <img width="250" height="250" src="gobelijn_small.png">
</p>


These are my configuration files. It is meant for personal use, but is public so I don't have to enter a password to clone this repo on a fresh pc. All personal info should be encrypted or removed, so you can use these files if you want.

## Dependencies
* [Git](https://git-scm.com/)
* [Gnu Stow](https://www.gnu.org/software/stow/)

## Installation
To install the dotfiles on your system run:

``` sh
cd ~
git clone https://github.com/janpeterd/dot.git
# before stowing make sure none of the files or directories in the dotfiles repo exist on your system.
stow */
```

*It is important that the dot folder is located in your **home directory**!*


## Extra
### Privacy stuff
* My addressbook is encrypted and needs to be decrypted before usage with abook.
* I redacted my personal email from config.el in .doom.d folder for emacs

#### Decrypt
To decrypt, I need to import my private gpg-key via my password manager.

``` sh
gpg --import my-key.key
```



## TODO
* [ ] Modify folder structure to have support for different configurations (different distros, etc.)
  * [ ] for example a folder arch with all arch dotfiles inside, and 'stow arch' would install these dotfiles
