git_scripts_folder=$HOME/.git-scripts

if [ ! -d "$git_scripts_folder" ]; then
	mkdir "$git_scripts_folder"
fi

echo "$2" > ${git_scripts_folder}/${1}.sh
