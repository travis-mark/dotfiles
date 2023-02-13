HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

PATH="/opt/homebrew/opt/openjdk/bin:$PATH" # Java
PATH=${HOME}/.local/bin:$PATH # PIP
PATH=${HOME}/go/bin:$PATH # Go
PATH="/opt/homebrew/opt/ruby/bin:$PATH" # Ruby
PATH=${HOME}/.emacs.d/bin:$PATH # Emacs
PATH=${HOME}/bin:$PATH # Scripts
PATH=${HOME}/local/bin:$PATH # Small compiled programs
export ANDROID_HOME=${HOME}/Library/Android/sdk/

function code { open -a "Visual Studio Code" $argv }
function fork { open -a "Fork" $argv }
function edge { open -a "Microsoft Edge" $argv }
function safari { open -a "Safari" $argv }
function xc { open -a "Xcode" $argv }
function reload_zsh_config { source ~/.zshrc }

export CODE="${HOME}/Code"
PROMPT="%F{51}%1~%f %# "
RPROMPT="%w %T [%?]"

function use {
    # Does nothing for now.
    # Check for data caches or tools.
    # Implement someday.
}

function project-build-project-list {
    find ${CODE} -name .git -maxdepth 3 | sed s/.git$//g > ~/.projects
}

function project-change-directory {
    use projects
    use selecta
    cd $(cat ~/.projects | selecta)
}

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

alias ll='exa -l'
alias pcd='project-change-directory'
alias neocities=$(echo `gem which neocities` | sed s:lib/neocities.rb$:bin/neocities:)
alias wordle='cat /usr/share/dict/words | grep "^.....$"'
alias skiping='ping skitheeast.asuscomm.com'
