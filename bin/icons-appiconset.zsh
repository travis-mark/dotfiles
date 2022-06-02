#!/bin/zsh
set -e

IN=$1
OUT=$2

convert ${IN} -resize 40x40 ${OUT}/AppIcon-20x20@2x.png
convert ${IN} -resize 60x60 ${OUT}/AppIcon-20x20@3x.png
convert ${IN} -resize 58x58 ${OUT}/AppIcon-29x29@2x.png
convert ${IN} -resize 87x87 ${OUT}/AppIcon-29x29@3x.png
convert ${IN} -resize 80x80 ${OUT}/AppIcon-40x40@2x.png
convert ${IN} -resize 120x120 ${OUT}/AppIcon-40x40@3x.png
convert ${IN} -resize 120x120 ${OUT}/AppIcon-60x60@2x.png
convert ${IN} -resize 180x180 ${OUT}/AppIcon-60x60@3x.png
convert ${IN} -resize 20x20 ${OUT}/AppIcon-20x20~iPad.png
convert ${IN} -resize 40x40 ${OUT}/AppIcon-20x20@2x~iPad.png
convert ${IN} -resize 29x29 ${OUT}/AppIcon-29x29~iPad.png
convert ${IN} -resize 58x58 ${OUT}/AppIcon-29x29@2x~iPad.png
convert ${IN} -resize 40x40 ${OUT}/AppIcon-40x40~iPad.png
convert ${IN} -resize 80x80 ${OUT}/AppIcon-40x40@2x~iPad.png
convert ${IN} -resize 76x76 ${OUT}/AppIcon-76x76~iPad.png
convert ${IN} -resize 152x152 ${OUT}/AppIcon-76x76@2x~iPad.png
convert ${IN} -resize 167x167 ${OUT}/AppIcon-83.5x83.5@2x~iPad.png
convert ${IN} -resize 1024x1024 ${OUT}/AppIcon-1024x1024~iOSMarketing.png