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