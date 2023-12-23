#!/bin/sh

ANSWERS_FOLDER="/tmp/$$"
ANSWERS_FILE="${ANSWERS_FOLDER}/answers.txt"
START="2021-06-19"

mkdir -p ${ANSWERS_FOLDER}
for i in $(seq 0 1000); do 
    d=`date -j -v+${i}d -f %Y-%m-%d ${START} +%Y-%m-%d`
    curl "https://www.nytimes.com/svc/wordle/v2/${d}.json" >> ${ANSWERS_FILE}
    echo >> ${ANSWERS_FILE}
done

open ${ANSWERS_FILE}