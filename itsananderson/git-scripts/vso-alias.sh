# This script provides a shortcut for cloning a VSO Git repository
#
# Suggested usage is to install as a 'vso' alias for git
# 
#     git config --global alias.vso \!"$HOME/.git-scripts/vso-alias.sh"\ ""
#
# Usage:
#
#     git vso <subdomain>:<project>[:repository] [other 'git clone' args]
#
# Examples:
#
#     git vso itsananderson:website
#
#     git vso itsananderson:website:repository2
#
#     git vso itsananderson:website another-folder
#
#     git vso "itsananderson:OMG Spaces" --bare yet-another-folder


# Split the repo info
IFS=':' read -ra parts <<< "$1";

# Pull out the info parts
subd=${parts[0]};
proj="${parts[1]}";
repo=${parts[2]-${proj}};

# Escape spaces to avoid HTTP 400 errors
proj=${proj// /%20};
repo=${repo// /%20};

git clone "https://${subd}.visualstudio.com/DefaultCollection/${proj}/_git/${repo}" "${@:2}"
