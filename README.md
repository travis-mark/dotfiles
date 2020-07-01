# Junk Drawer

This is a collection of my miscellaneous scripts and shell customizations.

### To setup a new machine

1. Copy config files
    cp -R /Volumes/Code/travis-mark.github.com/dotfiles/config ~

2. Install oh-my-zsh and Homebrew
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

3. Grab other dependancies via Homebrew (execute in HOME directory after copy from step 1)
    brew bundle 
