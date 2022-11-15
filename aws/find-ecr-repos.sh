#!/usr/bin/env bash
# Example:
#    ./find-ecr-repos.sh multienv-vote-main

if [[ $# -lt 1 ]]; then
    echo "Usage: $( basename $0 ) <repository-name>"
    exit 1
fi

REPOS_META="$( aws ecr describe-repositories --repository-names $1 2> /dev/null )"

if [[ $? == 0 ]]; then
    REPOS_META="$( echo ${REPOS_META} | jq '.repositories[0]' -r )"
    echo "$1 repository found"
else
    echo "$1 repository not found"
    exit 1
fi