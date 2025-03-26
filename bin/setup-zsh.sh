#!/bin/sh

PROJECT="$(cd "$(dirname "$0")/.." && pwd)"

touch ~/.hushlogin # Silence "last login" message
# (s)ymbolic, (i)nteractive, (v)erbose
# (h) do not follow link (useful when replacing folder links)
ln -sivh "$PROJECT/bin" "$HOME/bin"
ln -sivh "$PROJECT/share" "$HOME/share"
ln -sivh "$PROJECT/.zshrc" "$HOME/.zshrc"
