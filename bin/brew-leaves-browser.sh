#!/bin/sh

brew leaves | fzf --preview='brew info {}'