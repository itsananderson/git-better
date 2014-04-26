#!/bin/bash

script_dir=$(pushd `dirname $0` > /dev/null && pwd -P)

$script_dir/../install.sh

# User specific install steps

git config --global format.pretty format:"%C(yellow)%h%Creset %s%n%Cgreen%ad%Creset %aN <%aE>%n"

echo "Customizing KDiff3 settings"

if [ ! -e "~/.kdiff3rc" ]
then
    cp $script_dir/.kdiff3rc-base ~/.kdiff3rc
fi

$script_dir/apply-kdiff3rc.sh $script_dir/.kdiff3rc ~/.kdiff3rc
