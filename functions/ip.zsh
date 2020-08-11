# Adapted from: https://github.com/ttscoff/fish_files/blob/master/functions/ip.fish
function ip {
    curl -Ss icanhazip.com
}