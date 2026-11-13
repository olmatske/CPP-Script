#!/usr/bin/env zsh

read "newd?Name of Directory: "

read "olddir?Input Directory to be copied from: "

read "class?Input new Classes: "

read "exec?Name of the Executable: "

newdir=(${=newd})
amount=${#class}










if (( amount == 0 )); then
	cp -R "$olddir" "$newdir" || exit 1
	echo "Copied the directory without adding Classes"
else
	cp -r $olddir $newdir
	cd $newdir
	
fi



