#!/bin/bash

# This script provides a shortcut for cloning a VSO Git repository
#
# Suggested usage is to install as 'vsoc' and 'vsor' aliases for git:
# 
#   git config --global alias.vsoc \!". /c/Users/wiand/.git-scripts/vso-alias.sh; clone" ""
#   git config --global alias.vsor \!". /c/Users/wiand/.git-scripts/vso-alias.sh; remote" ""
#
# Usage:
#
#   Call 'vsoc' and 'vsor' like you would call 'clone' and 'remote',
#   but rather than the normal clone url or remote url, pass in the following:
#       "<subdomain>:<project>[:<repository>]"
#
#   - <subdomain> is your visualstudio.com subdomain
#   - <project> is the name of your visualstudio.com project
#   - <repository> is the name of the repository within your project. Defaults to <project>
#
# Clone Examples:
#
#   git vsoc itsananderson:website
#
#   git vsoc itsananderson:website:repository2
#
#   git vsoc itsananderson:website another-folder
#
#   git vsoc "itsananderson:OMG Spaces" --bare yet-another-folder
#
# Remote Examples:
#
#   git vsor add origin itsananderson:website
#
#   git vsor add origin itsananderson:website:repository2
#
#   git vsor set-url origin itsananderson:website
#
#   git vsor set-url --add origin itsananderson:website


format_repo() {
    # Split the repo info
    IFS=':' read -ra parts <<< "$1";

    # Pull out the info parts
    subd=${parts[0]};
    proj="${parts[1]}";
    repo="${parts[2]-${proj}}";

    # Escape spaces to avoid HTTP 400 errors
    proj=${proj// /%20};
    repo=${repo// /%20};

    echo "https://${subd}.visualstudio.com/DefaultCollection/${proj}/_git/${repo}"
};

clone() {
    # From: https://github.com/github/hub/blob/fe7155419ee3d3c198ce80158f80e7d44b9b5f97/lib/hub/commands.rb#L283
    has_values="^(--(upload-pack|template|depth|origin|branch|reference|name)|-[ubo])$"

    args=("$@")

    i=0
    while [ $i -lt $# ]
    do
        arg="${args[i]}"
        if [[ $arg == -* ]]
        then
            if [[ $(echo $arg | grep -E $has_values) ]]
            then
                # Skip next arg
                i=$(($i+1))
            fi
        else
            # Found url
            args[i]="`format_repo "$arg"`"
            break
        fi
        i=$(($i+1))
    done

    echo git clone "${args[@]}" $'\n'

    git clone "${args[@]}"
};

remote() {
    args=("$@")
    subcommand=$1
    offset=0
    if [[ $subcommand == "add" ]]
    then
        offset=1
    elif [[ $subcommand == "set-url" ]]
    then
        if [[ ! ${args[1]} == "--delete" ]]
        then
            offset=1
            if [[ ! ${args[1]} == "--add" ]]
            then 
                if [[ ${args[1]} == "--push" && $# == 5 ]] || [[ ! ${args[1]} == "--push" && $# == 4 ]]
                then
                    offset=2
                fi
            fi
        fi
    fi

    if [[ $offset -ne 0 ]]
    then
        args[$((${#args[@]}-$offset))]=`format_repo "${args[$((${#args[@]}-$offset))]}"`
    fi

    echo git remote "${args[@]}"
    #git remote "${args[@]}"
};
