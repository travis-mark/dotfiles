#!/bin/sh
set -x

DOTFILES=$(dirname $0)/../..

# Nix install
if [[ ! -e "/run/current-system/sw/bin/darwin-rebuild" ]]; then
    echo "Installing Nix..."
    TMP_DIR="/tmp/$$"
    cd ${TMP_DIR}
    curl -L https://nixos.org/nix/install > install.sh
    sh install.sh --darwin-use-unencrypted-nix-store-volume
    nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
    ./result/bin/darwin-installer
fi

# Apply configs
nix-shell -p stow --command "stow -v -d ${DOTFILES} -t ${HOME} -R config"