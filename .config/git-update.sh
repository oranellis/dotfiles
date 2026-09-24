#!/bin/bash

if [ -z "$1" ]; then
  commit_msg="Update $(date '+%y%m%d %H%M')"
else
  commit_msg="$*"
fi

local has_remote
if [ -n "$(git remote)"]; then
  has_remote="y"
fi

if [ "$has_remote" == "y" ]; then
  git reset
  git pull
fi

git add -A && git commit -m "$commit_msg"

if [ "$has_remote" == "y" ]; then
  git push
fi
