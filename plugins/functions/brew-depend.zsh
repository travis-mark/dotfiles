function brew-depend {
    if [[ $# = 1 ]]; then
        if brew ls --versions "$1" > /dev/null; then
        else
            brew install $1
        fi
    fi
}