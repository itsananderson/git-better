#!/bin/bash

echo "Performing Git Better base install"

echo "Enabling console colors for Git commands"
git config --global color.ui true

echo "Configuring kdiff as the default merge/diff tool"
./kdiff.sh

echo "Configuring some useful aliases"
./alias.sh
