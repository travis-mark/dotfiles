# Courtesy: https://scriptingosx.com/2017/04/on-viewing-man-pages/
function xman() { open x-man-page://$@ ; }
function pman() { man -t "$@" | open -f -a "Preview" ;}