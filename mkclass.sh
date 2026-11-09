#!/usr/bin/env zsh

read 'directory?Name of Directory: '

mkdir $directory

cd $directory

read 'input?Name of Classes: '

classes=(${=input})
amount=${#classes}

# echo -e "\nWe have $amount classes:\n"

function put_header() {
	local	filename="$1"
	cat >> $filename << 'EOF'
/* ************************************************************************** */
/*              ／＞　 フ                        ˚★ ₊ ⊹　  ࣪˖ ࣪ ࣪ ˖⋆˚★ ₊ ⊹　  ࣪˖ ࣪ ₊  ࣪ ˖*/
/*             | 　_　_|                             ˖ ࣪　⊹ ࣪ ★⊹ ࣪ ┆ ˖ ࣪　⊹ ࣪ ★ ⋆.˚  ⊹ ࣪*/
/*            ／` ミ＿xノ                                   ࣪ ˖⋆˚★ ₊ ⊹　  ࣪˖ ࣪ ₊  ࣪ ˖*/
/*           /　　　　 |                                   ˖⋆˚★ ₊ ⊹　  ࣪˖ ࣪ ₊  ࣪ ˖　*/
/*          /　 ヽ　　 ﾉ           へ   ╱|、 ♡   ╱|、       ☆⊹ ࣪ ┆ ˖ ࣪　⊹ ࣪ ★ .˚  ⊹ */
/*          │　　|　|　|       ૮ - ՛ ) (˚ˎ 。7  (` -  7          ˚★ ₊ ⊹　  ࣪˖ ࣪ ₊ */
/*      ／￣ 　　 |　|　|       /  ⁻៸|  |、 ˜(    |、⁻(           ★ ₊ ⊹　  ࣪˖ ࣪ ࣪ ˖⋆ */
/*      ( ( ヽ＿_ヽ_)__)   乀 (ˍ, ل ل  じしˍ,)ノ じしˍ,)ノ         　⊹ ࣪ ★ ⋆.˚    */
/*      ＼__二)                                               ࣪˖ ࣪ ₊  ★⊹ ࣪ ┆  ★ ⋆.*/
/* ********************************************************** github/olmatske */

EOF
}

# //////////////////////////////////////////////////////////////////////////////
function cpp_includes() {

	local class="$1"
	local guard="${(U)class}_HPP"

	cat  >> "${class}.cpp" << EOF
#include "${classes[count]}.hpp"

EOF

	cat  >> "${class}.hpp" << EOF
#ifndef ${guard}
#define ${guard}

#include <iostream>
#include <string>

#endif


EOF
}

# //////////////////////////////////////////////////////////////////////////////

function fill_main() {

local class="$1"

	cat >> main.cpp << EOF
#include "${class[count]}.hpp"
EOF
}

# //////////////////////////////////////////////////////////////////////////////
function fill_Makefile() {

}

function fill_Colors() {
	cat >> Colors.hpp << EOF
#ifndef "COLORS_HPP"
#define "COLORS_HPP"

#include <string>

#endif

const std::string M = "\033[1;35m";
const std::string G = "\033[1;32m";
const std::string C = "\033[1;36m";
const std::string RED = "\033[1;31m";
const std::string P = "\033[1;38;5;216m";
const std::string R = "\033[0m";

const std::string p = "\033[38;5;216m";
const std::string c = "\033[36m";
const std::string g = "\033[32m";
const std::string pp = "\033[35m";

EOF
}

count=1

touch Colors.hpp
touch main.cpp
touch Makefile

put_header "Colors.hpp"
put_header "main.cpp"
put_header "Makefile"
echo "#include Colors.hpp" > main.cpp

while ((count <= amount)); do
	touch ${classes[count]}.cpp
	touch ${classes[count]}.hpp
	put_header	"${classes[count]}.cpp"
	put_header	"${classes[count]}.hpp"
	fill_main "${classes[count]}"
	cpp_includes "${classes[count]}"
	(( count ++ ))
done

fill_Colors




# sleep 2

# rm -rf *.cpp *.hpp main.cpp Makefile

# sleep 3

# cd ..

# rm -rf $directory


# while ((count <= amount)); do
# 	echo "${classes[count]}"
# 	(( count++ ))
# done

