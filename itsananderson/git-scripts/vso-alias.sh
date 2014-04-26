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
