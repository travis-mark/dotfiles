function azure-devops-pull-latest {
    pushd /Volumes/Code
    #brew install azure-cli jq
    #az login
    ORGANIZATIONS="penndotvso.visualstudio.com"
    for ORGANIZATION in $ORGANIZATIONS; do
        mkdir $ORGANIZATION
        pushd $ORGANIZATION
        PROJECTS=`az devops project list --organization "https://$ORGANIZATION" | jq '.value|.[]|.name' --raw-output`
        for PROJECT ($=PROJECTS); do
            mkdir $PROJECT
            pushd $PROJECT
            REPOS=`az repos list --organization "https://$ORGANIZATION" --project $PROJECT | jq '.[].sshUrl' --raw-output`
            for REPO ($=REPOS); do
                git clone $REPO
            done
            popd
        done
        popd
    done
    popd
}