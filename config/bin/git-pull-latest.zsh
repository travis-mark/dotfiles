#!/bin/zsh

for repo in `ls`; do 
    echo $repo
    pushd -q $repo
    git pull
    popd -q
done