#!/bin/sh

BIN=$(dirname "$0")

touch ~/.hushlogin # Silence "last login" message
[ ! -e "$HOME/bin" ] && ln -s "$BIN" "$HOME/bin"
[ ! -e "$HOME/share" ] && ln -s "$BIN/../share" "$HOME/share" # TODO: Better link here
