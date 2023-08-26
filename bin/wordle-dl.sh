#!/bin/sh

START="2021-06-19"
rm answers.txt
for i in $(seq 0 1000); do 
    d=`date -j -v+${i}d -f %Y-%m-%d ${START} +%Y-%m-%d`
    curl "https://www.nytimes.com/svc/wordle/v2/${d}.json" >> answers.txt
    echo >> answers.txt
done