#!/bin/bash

if [ -z "$1" ]; then
    commit_msg="Update $(date '+%y%m%d %H%M')"
else
    remaining_args="$*"
    if [[ ${remaining_args:0:1} =~ [a-zA-Z] ]]; then
        # Capitalize the first letter and concatenate the rest of the string
        commit_msg="${remaining_args^}"
    else
        commit_msg="$remaining_args"
    fi
fi

if [ -n "$(git remote)" ]; then
    git reset
    git pull
fi

git add -A && git commit -m "$commit_msg"

if [ -n "$(git remote)" ]; then
    git push
fi
