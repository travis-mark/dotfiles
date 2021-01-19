#!/bin/sh
set -xe # Bail on error

if [[ ! $1 ]]; then
    echo "Missing argument: repo"
    exit 1
fi

REPO=$1
TMP=/tmp/$$

cd ${REPO}
mkdir ${TMP}
mv * ${TMP}
if [[ -x .gitignore ]]; then
    mv .gitignore ${TMP}
fi
mv ${TMP} ${REPO}
git remote add -f archive git@github.com:travis-mark/ARCHIVE.git
git fetch
git add .
git commit -m "Stage ${REPO} for ARCHIVE"
git merge archive/master --allow-unrelated-histories
git push archive
