#!/bin/bash

# This is a script that builds a file that looks 
# like someone started a Terraform project with s3 in mind and got distracted
# it adds the new file called s3_bucket_for_.tf to the git index



if [ -z "$1" ]; then
	echo -n "What repo amd I looking at? " && read REPO
else  
	REPO="$1"
fi
# Scan the repo

output=$(ggshield secret scan repo ${REPO})
echo "$output"

if [[ "$output" == *"No secrets have been found"* ]]; then

    echo "${2}"
    if [ -z "${2}" ]; then
	    echo -n "What do you want to name this new honeytoken?" && read NEW_HT_NAME
    else  
	    NEW_HT_NAME=${2}
    fi
    
    NEW_HT_DESC=" "
    if [ -z "${3}" ]; then
	    echo -n "What do you want to write a description? If so use \" double quotes\", otherwise just hit enter" && read NEW_HT_DESC 
        # NEW_HT_NAME="\"${NEW_HT_NAME}\""
    else  
	    NEW_HT_DESC="${3}"
    fi

## Build a new honeytoken!
NEW_HONEYTOKEN=$(gght create ${NEW_HT_NAME} "${NEW_HT_DESC}" )
fi

## Grab the new honeytoken creds
# echo "$NEW_HONEYTOKEN"
# AWS_ACCWSS_KEY_ID=$(echo "$NEW_HONEYTOKEN" | grep -w 'access_token_id' | cut -d'"' -f 4) 
# AWS_SECRET_ACCESS_KEY=$(echo "$NEW_HONEYTOKEN" | grep -w 'secret_key' | cut -d'"' -f 4)

AWS_ACCWSS_KEY_ID="testkeeeeeey" 
AWS_SECRET_ACCESS_KEY=="testsecrettttttttkeeeeeey" 

## make the file
echo "[jw341]" > ./s3_bucket_for_.tf
echo "aws_access_key_id = "$AWS_ACCWSS_KEY_ID >> ./s3_bucket_for_.tf
echo "aws_secret_access_key = "$AWS_SECRET_ACCESS_KEY >> ./s3_bucket_for_.tf

# add it to git index
git add ./s3_bucket_for_.tf
git status