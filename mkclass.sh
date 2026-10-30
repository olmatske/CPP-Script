#!/usr/bin/env zsh

read 'directory?Name of Directory: '

mkdir $directory

cd $directory

read 'input?Name of Classes: '

classes=(${=input})
amount=${#classes}

# echo -e "\nWe have $amount classes:\n"

count=1

while ((count <= amount)); do
	touch ${classes[count]}.cpp
	touch ${classes[count]}.hpp
	touch main.cpp
	touch Makefile
	(( count ++ ))
done

sleep 2

rm -rf *.cpp *.hpp main.cpp Makefile

sleep 3

cd ..

rm -rf $directory


# while ((count <= amount)); do
# 	echo "${classes[count]}"
# 	(( count++ ))
# done

