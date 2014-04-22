#!/bin/sh

kdiffpath=`where kdiff3`

echo '#!/bin/sh' >  ~/git-diff-wrapper.sh
echo "'$kdiffpath'" '"$2" "$5" | cat' >> ~/git-diff-wrapper.sh

git config --global diff.external $HOME/git-diff-wrapper.sh
git config --global diff.tool kdiff3
git config --global difftool.kdiff3.cmd "'$kdiffpath' \$LOCAL \$REMOTE"
git config --global difftool.kdiff3.keepBackup false
git config --global difftool.kdiff3.trustExitCode true
git config --global difftool.kdiff3.keepTemporaries false

git config --global merge.tool kdiff3
git config --global mergetool.kdiff3.path "$kdiffpath"
git config --global mergetool.kdiff3.keepBackup false
git config --global mergetool.kdiff3.trustExitCode true
git config --global difftool.kdiff3.keepTemporaries false

git config --global --replace-all alias.dt 'difftool -y'
git config --global --replace-all alias.mt 'mergetool -y'