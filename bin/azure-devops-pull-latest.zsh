# Depends: azure-cli, jq
function azure-devops-pull-latest {
    pushd -q /Volumes/Code
    az login > /dev/null
    az extension add --name azure-devops
    ORGANIZATIONS="penndotvso.visualstudio.com"
    for ORGANIZATION in $ORGANIZATIONS; do
        mkdir $ORGANIZATION 2> /dev/null
        pushd -q $ORGANIZATION
        PROJECTS=`az devops project list --organization "https://$ORGANIZATION" | jq '.value|.[]|.name' --raw-output`
        for PROJECT ($=PROJECTS); do
            mkdir $PROJECT 2> /dev/null
            pushd -q $PROJECT
            REPOS=`az repos list --organization "https://$ORGANIZATION" --project $PROJECT | jq '.[].sshUrl' --raw-output`
            for REPO ($=REPOS); do
                git clone $REPO
            done
            for repo in `ls`; do 
                pushd -q $repo
                git pull
                popd -q
            done
            popd  -q
        done
        popd -q
    done
    popd -q
}
