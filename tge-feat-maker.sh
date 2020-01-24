#!/bin/bash

# README: https://github.com/danivijay/take-git-easy

git_operations()
{
  echo "you've selected $1"
  echo "feature/bug id?"
  read id
  echo "feature name separated by spaces (no special charactors, eg: 'sample feature')"
  read name
  name=`echo "$name" | tr -s ' ' | tr ' ' '-'`
  name=`echo "$name" | tr '[:upper:]' '[:lower:]'`
  echo "Your $1 branch will be named as $1/$id-$name (y/n)"
  read confirmation
  if [ $confirmation = "y" ]
  then
    git fetch origin master
    git checkout master
    git pull
    git checkout -b "$1/$id-$name"
  fi
}

echo "1. Create a feature branch"
echo "2. Create a bugfix branch"
echo "3. Create a hotfix brach"
read branch_type
if [ $branch_type -eq 1 ]
then
    git_operations "feature"
elif [ $branch_type -eq 2 ]
then
    git_operations "bugfix"
elif [ $branch_type -eq 3 ]
then
    git_operations "hotfix"
fi