#!/bin/sh

kdiffpath=`which kdiff3`

kdiff_win_path=`echo $kdiffpath | sed -e 's/\//\\\\/g' | sed -e 's/^\\\\c/c\:/' | sed -e 's/ /\\ /g'`

echo '#!/bin/sh' >  ~/git-diff-wrapper.sh
echo "'$kdiffpath'" '"$2" "$5" | cat' >> ~/git-diff-wrapper.sh

git config --global diff.external $HOME/git-diff-wrapper.sh
git config --global merge.external $HOME/git-merge-wrapper.sh

git config --global diff.tool kdiff3

git config --global merge.tool kdiff3

git config --global mergetool.kdiff3.path "$kdiffpath"
git config --global mergetool.kdiff3.keepBackup false
git config --global mergetool.kdiff3.trustExitCode true
git config --global difftool.kdiff3.keepTemporaries false

git config --global difftool.kdiff3.cmd "'$kdiff_win_path' \$LOCAL \$REMOTE"
git config --global difftool.kdiff3.keepBackup false
git config --global difftool.kdiff3.trustExitCode true
git config --global difftool.kdiff3.keepTemporaries false

git config --global --replace-all alias.dt 'difftool -y'
git config --global --replace-all alias.mt 'mergetool -y'