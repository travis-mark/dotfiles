#!/bin/zsh

#az login > /dev/null
az extension add --name azure-devops
ORGANIZATIONS="penndotvso"
for ORGANIZATION in $ORGANIZATIONS; do
    URL="https://dev.azure.com/$ORGANIZATION"
    PROJECTS=`az devops project list --organization ${URL} | jq '.value|.[]|.name' --raw-output`
    for PROJECT ($=PROJECTS); do
        REPOS=`az repos list --organization ${URL} --project $PROJECT | jq '.[].sshUrl' --raw-output`
        for REPO ($=REPOS); do
            DIR=$(echo ${REPO} | awk 'BEGIN { FS = "/" } ; {print $(NF)}')
            echo "\e[0;32m${DIR} \e[m" 
            if [[ -d ${DIR} ]]; then 
                pushd -q ${DIR}
                git pull
                popd -q
            else
                git clone ${REPO}
            fi
        done
    done
done
