HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

PATH=${HOME}/.local/bin:$PATH # PIP
PATH=${HOME}/go/bin:$PATH # Go
PATH="/opt/homebrew/opt/ruby/bin:$PATH" # Ruby
PATH=${HOME}/bin:$PATH # Scripts

function code { open -a "Visual Studio Code" $argv }
function fork { open -a "Fork" $argv }
function xc { open -a "Xcode" $argv }

alias neocities=$(echo `gem which neocities` | sed s:lib/neocities.rb$:bin/neocities:)
alias wordle='cat /usr/share/dict/words | grep "^.....$"'
