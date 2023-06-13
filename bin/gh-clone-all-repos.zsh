#!/usr/bin/env zsh
set -e

echo "Notes:"
echo "Use \`gh auth login\` to pick account before calling this."
echo "\$1 to optionally set user / organization."
echo "\`GIT_SSH_COMMAND='ssh -i ~/.ssh/file'\` $0 to force an SSH key."
echo "\`ssh-add ~/.ssh/file\` to avoid repeated password requests."
echo ""

CODE="${HOME}/Code"
COUNT=0

mkdir -p ${CODE}
cd ${CODE}

if [[ $1 ]]; then
    mkdir -p $1
fi

gh repo list $1 -L 1000 | awk '{ print $1 }' | while read -r REPO; do
    COUNT=$((COUNT + 1))
    if [ -d $REPO ]; then
        echo "FETCH ($COUNT): $REPO" 
        pushd "$REPO"
        git fetch -q 
        popd
    else 
        echo "CLONE ($COUNT): $REPO"
        gh repo clone "$REPO" "$REPO" -- -q
    fi
done
