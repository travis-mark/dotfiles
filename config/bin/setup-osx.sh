#!/bin/sh
set -x

# TODO: Swap brew for nix-darwin if testing proves out

DOTFILES=$(dirname $0)/../..

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install stow
stow -v -d ${DOTFILES} -t ${HOME} -R config
brew bundle --global