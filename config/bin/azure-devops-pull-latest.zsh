#!/bin/zsh

#az login > /dev/null
az extension add --name azure-devops
ORGANIZATIONS="penndotvso.visualstudio.com"
for ORGANIZATION in $ORGANIZATIONS; do
    PROJECTS=`az devops project list --organization "https://$ORGANIZATION" | jq '.value|.[]|.name' --raw-output`
    for PROJECT ($=PROJECTS); do
        REPOS=`az repos list --organization "https://$ORGANIZATION" --project $PROJECT | jq '.[].sshUrl' --raw-output`
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
