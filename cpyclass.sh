#!/usr/bin/env zsh

read "newdir?Name of Directory: "

read "olddir?Input Directory to be copied from: "

read "class?Input new Classes: "

read "exec?Name of the Executable: "


cp -r $olddir $newdir

cd $newdir


