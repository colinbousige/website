#!/bin/bash  

# Set the English locale for the `date` command.
export LC_TIME=en_US.UTF-8

# The commit message.
MESSAGE="Site rebuild $(date)"

git add .
git commit -m "$MESSAGE"
git push --force -u origin master
Rscript blogdownbuild.R
cd public
pwd
git add .
git commit -m "$MESSAGE"
git pull
git push --force -u origin master

