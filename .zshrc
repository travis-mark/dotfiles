HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

PATH="/opt/homebrew/opt/openjdk/bin:$PATH" # Java
PATH=${HOME}/.local/bin:$PATH # PIP
PATH=${HOME}/go/bin:$PATH # Go
PATH="/opt/homebrew/opt/ruby/bin:$PATH" # Ruby
PATH=${HOME}/bin:$PATH # Scripts

function code { open -a "Visual Studio Code" $argv }
function fork { open -a "Fork" $argv }
function edge { open -a "Microsoft Edge" $argv }
function safari { open -a "Safari" $argv }
function xc { open -a "Xcode" $argv }
function reload_zsh_config { source ~/.zshrc }

alias ll='exa -l'
alias neocities=$(echo `gem which neocities` | sed s:lib/neocities.rb$:bin/neocities:)
alias wordle='cat /usr/share/dict/words | grep "^.....$"'

function git-claim-personal {
    git config --add --local user.name 'Travis Luckenbaugh'
    git config --add --local user.email 'tluckenbaugh@gmail.com'
    git config --add --local core.sshCommand 'ssh -i ~/.ssh/id_rsa -o IdentitiesOnly=yes'
}

function git-claim-subaru {
    git config --add --local user.name 'Travis Luckenbaugh'
    git config --add --local user.email 'tlucke@subaru.com'
    git config --add --local core.sshCommand 'ssh -i ~/.ssh/id_ed25519_subaru -o IdentitiesOnly=yes'
}

# TODO: go looking for package.json, __init__.py, etc...
function up {
    PORT=$(( $RANDOM % 48576 + 16384 ))
    VIEWER=${1?open}
    python3 -m http.server ${PORT} &
    ${VIEWER} "http://localhost:${PORT}/"
    fg
}

# TODO: connect to eshell
