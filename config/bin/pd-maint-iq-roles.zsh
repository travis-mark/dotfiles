#!/bin/zsh

if [[ ! ${1} ]]; then
    echo "USAGE ${0} ACCOUNT_NAME";
    exit 1;
fi

curl "https://gis.penndot.gov/pdauth/api/permissions?appName=Maintenance_IQ&emailAddress=${1}@pa.gov" 