CONFIG_DIR="/Volumes/Code/Personal/dotfiles/config"

function install-dotfiles {
    rm ~/.gitconfig 
    ln -s ${CONFIG_DIR}/.gitconfig ${HOME}/.gitconfig
}

function install-shell-addons {
    brew-depend ripgrep
    brew-depend wget
}

function install-spacehammer {
    brew cask install hammerspoon
    brew install luarocks
    luarocks install fennel
    git clone https://github.com/agzam/spacehammer ~/.hammerspoon
}