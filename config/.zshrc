# Actual zsh configs
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

PATH=/Users/travis/.local/bin:$PATH # Misc PIP packages
PATH=/Users/travis/go/bin:$PATH # Misc Go packages

# Programming
export JAVA_HOME=/nix/store/24pg7m8hzcvym9lpi6nffnqj93bbbs6x-zulu-11.41.23

# Reload script
alias reload='source ~/.zshrc'

# General / Addons
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # FZF Completions
eval "$(starship init zsh)" # Starship Command Prompt
PATH=$PATH:${HOME}/bin # Scripts
STOW_DIR=${HOME}/GitHub/dotfiles

# App launchers
function code { open -a "Visual Studio Code" $argv }
function fork { open -a "Fork" $argv }
function xc { open -a "Xcode" $argv }

# Adapted from: https://github.com/ttscoff/fish_files/blob/master/functions/imgsize.fish
function image-size {
    if [[ $# != 0 ]]; then
        HEIGHT=$(sips -g pixelHeight "$argv" | tail -n 1 | awk '{print $2}')
        WIDTH=$(sips -g pixelWidth "$argv" | tail -n 1 | awk '{print $2}')
        echo ${HEIGHT}x${WIDTH}
    else
        echo "File not found"
    fi
}

# Adapted from: https://github.com/ttscoff/fish_files/blob/master/functions/ip.fish
function ip {
    curl -Ss icanhazip.com
}

function stow-apply {
    stow -v -d ${STOW_DIR} -t ${HOME} -R config
}

# Courtesy: https://scriptingosx.com/2017/04/on-viewing-man-pages/
function xman() { 
    open x-man-page://$@ ; 
}

function git-claim-home {
    git config user.name "Travis Luckenbaugh" 
    git config user.email "tluckenbaugh@gmail.com"
}

function git-claim-penndot {
    git config user.name "Travis Luckenbaugh" 
    git config user.email "c-trlucken@pa.gov"
}
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

alias neocities=$(echo `gem which neocities` | sed s:lib/neocities.rb$:bin/neocities:)
