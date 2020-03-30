function fork {
    if [[ $# = 0 ]]; then
        open -a "Fork"
    else
        local argPath="$1"
        [[ $1 = /* ]] && argPath="$1" || argPath="$PWD/${1#./}"
        if [[ ! -e $argPath ]]; then touch $argPath; fi
        open -a "Fork" "$argPath"
    fi
}