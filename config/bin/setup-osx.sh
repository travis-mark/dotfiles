#!/bin/sh
set -x

DOTFILES=$(dirname $0)/../..

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install stow
stow -v -d ${DOTFILES} -t ${HOME} -R config
brew bundle --global