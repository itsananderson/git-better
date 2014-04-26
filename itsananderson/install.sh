#!/bin/bash

script_dir=$(pushd `dirname $0` > /dev/null && pwd -P)

$script_dir/../install.sh

# User specific install steps

git config --global format.pretty format:"%C(yellow)%h%Creset %s%n%Cgreen%ad%Creset %aN <%aE>%n"
