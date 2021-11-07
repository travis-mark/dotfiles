#!/bin/zsh

NAMES="travis-mark"
for NAME in $NAMES; do
    REPOS=`curl "https://api.github.com/users/$NAME/repos" | jq '.[].ssh_url' --raw-output`
    for REPO ($=REPOS); do
        DIR=$(echo ${REPO} | awk 'BEGIN { FS = "/" } ; {print $(NF)}' | awk 'BEGIN { FS = "." } ; {print $1}')
        echo "\e[0;32m${DIR} \e[m" 
        if [[ -d ${DIR} ]]; then 
            pushd -q ${DIR}
            git pull
            popd -q
        else
            git clone ${REPO}
        fi
    done
done
