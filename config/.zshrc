# Reload script
alias reload='source ~/.zshrc'

# General / Addons
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # FZF Completions
eval "$(starship init zsh)" # Starship Command Prompt
PATH=$PATH:${HOME}/bin # Scripts

function code {
    open -a "Visual Studio Code" $argv
}

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

function xc {
    open -a "Xcode" $argv
}

# Courtesy: https://scriptingosx.com/2017/04/on-viewing-man-pages/
function xman() { 
    open x-man-page://$@ ; 
}