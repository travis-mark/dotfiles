#!/usr/bin/env zsh
set -e

CODE="${HOME}/Code"

mkdir -p ${CODE}
cd ${CODE}

gh repo list travis-mark | awk '{ print $1 }' | while read -r repo; do
    gh repo clone "$repo" "$repo" -- -q 2>/dev/null || (
        cd "$repo"
        # Handle case where local checkout is on a non-main/master branch
        # - ignore checkout errors because some repos may have zero commits,
        # so no main or master
        git checkout -q main 2>/dev/null || true
        git checkout -q master 2>/dev/null || true
        git pull -q
    )
done
