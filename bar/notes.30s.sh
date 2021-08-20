#!/bin/zsh

NOTES="${HOME}/Library/Mobile Documents/iCloud~md~obsidian/Documents"

COUNT=$(fd .md "${NOTES}" | wc -l)
echo "${COUNT} N"

echo "---"

for VAULT in `ls "${NOTES}"`; do
    COUNT=$(fd .md "${NOTES}/${VAULT}" | wc -l)
    echo "${COUNT} ${VAULT}"
done