#!/bin/sh

rel_script_dir=`dirname $0`
pushd $rel_script_dir > /dev/null
script_dir=`pwd -P`
popd > /dev/null

$script_dir/../install.sh

# User specific install steps