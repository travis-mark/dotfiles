CONFIG_DIR="/Volumes/Code/Personal/dotfiles/config"

function install-dotfiles {
    rm ~/.gitconfig 
    ln -s ${CONFIG_DIR}/.gitconfig ${HOME}/.gitconfig
}
