function install-spacehammer {
    brew cask install hammerspoon
    brew install luarocks
    luarocks install fennel
    git clone https://github.com/agzam/spacehammer ~/.hammerspoon
}
    