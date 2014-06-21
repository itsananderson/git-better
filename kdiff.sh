#!/bin/bash

echo "Configuring Git to use KDiff3"

kdiffpath=`type -P kdiff3`

if [ -z "$kdiffpath" ]; then
    echo >&2 "ERROR: Can't find KDiff3. Halting configuration"
    exit
fi

if [[ `uname` == MINGW* ]]; then
	echo Converting KDiff path to Windows path 
	kdiffpath=`echo $kdiffpath | sed -e 's/\//\\\\/g' | sed -e 's/^\\\\c/c\:/' | sed -e 's/ /\\ /g'`
fi

script_dir=$(pushd `dirname $0` > /dev/null && pwd -P)
 
./ensure-script.sh diff-wrapper "$(<$script_dir/git-scripts/diff-wrapper.sh)"

git config --global diff.external $HOME/.git-scripts/diff-wrapper.sh
git config --global diff.tool kdiff3
git config --global difftool.kdiff3.cmd "'$kdiffpath' \$LOCAL \$REMOTE"
git config --global difftool.kdiff3.keepBackup false
git config --global difftool.kdiff3.trustExitCode true
git config --global difftool.kdiff3.keepTemporaries false

git config --global merge.tool kdiff3
git config --global mergetool.kdiff3.path "$kdiffpath"
git config --global mergetool.kdiff3.keepBackup false
git config --global mergetool.kdiff3.trustExitCode true
git config --global mergetool.kdiff3.keepTemporaries false

git config --global --replace-all alias.dt 'difftool -y'
git config --global --replace-all alias.mt 'mergetool -y'
