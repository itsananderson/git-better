#!/bin/bash

remote=`git remote -v | awk '/\(push\)$/ {print $2}'`
email=will@itsananderson.com # default

if [[ $remote == *github.com:Microsoft* ]]; then
  email=wiand@microsoft.com
fi
if [[ $remote == *enr.visualstudio.com* ]]; then
  email=wiand@microsoft.com
fi
if [[ $remote == *itsananderson.visualstudio.com* ]]; then
  email=will@codeawhile.com
fi

echo "Configuring user.email as $email"
git config user.email $email
