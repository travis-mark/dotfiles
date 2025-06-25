#!/bin/sh
# Source: https://apple.stackexchange.com/questions/198623/uninstall-all-programs-installed-by-homebrew
# 03/02/24 - a homebrew package started installing dozen of packages, 
# so I got myself a wipe script and a Brewfile

while [[ `brew list | wc -l` -ne 0 ]]; do
    for EACH in `brew list`; do
        brew uninstall --force --ignore-dependencies $EACH
    done
done