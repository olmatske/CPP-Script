#!/usr/bin/env zsh

read 'directory?Name of Directory: '

mkdir $directory

cd $directory

read 'input?Name of Classes: '

classes=(${=input})
amount=${#classes}

sources=''
for class in $classes; do
	sources+="$class.cpp "
done
sources=${sources% }

read 'executable?Name of the Executable: '

executable=(${=executable})
# echo -e "\nWe have $amount classes:\n"

function put_header() {
	local	filename="$1"
	if [[ "$filename" == "Makefile" ]]; then
	cat >> Makefile << 'EOF'
# ************************************************************************** */
#              ／＞　 フ                      ˚★ ₊ ⊹　  ࣪˖ ࣪ ࣪ ˖⋆˚★ ₊ ⊹　  ࣪˖ ࣪ ₊  ࣪ ˖*/
#             | 　_　_|                           ˖ ࣪　⊹ ࣪ ★⊹ ࣪ ┆ ˖ ࣪　⊹ ࣪ ★ ⋆.˚  ⊹ ࣪*/
#            ／` ミ＿xノ                                  ࣪ ˖⋆˚★ ₊ ⊹　  ࣪˖ ࣪ ₊  ࣪ ˖*/
#           /　　　　 |                                  ˖⋆˚★ ₊ ⊹　  ࣪˖ ࣪ ₊  ࣪ ˖　*/
#          /　 ヽ　　 ﾉ           へ   ╱|、 ♡   ╱|、     ☆⊹ ࣪ ┆ ˖ ࣪　⊹ ࣪ ★ .˚  ⊹ */
#          │　　|　|　|       ૮ - ՛ ) (˚ˎ 。7  (` -  7          ˚★ ₊ ⊹　  ࣪˖ ࣪ ₊ */
#      ／￣ 　　 |　|　|       /  ⁻៸|  |、 ˜(    |、⁻(          ★ ₊ ⊹　  ࣪˖ ࣪ ࣪ ˖⋆ */
#      ( ( ヽ＿_ヽ_)__)   乀 (ˍ, ل ل  じしˍ,)ノ じしˍ,)ノ        　⊹ ࣪ ★ ⋆.˚    */
#      ＼__二)                                              ࣪˖ ࣪ ₊  ★⊹ ࣪ ┆  ★ ⋆.*/
# ********************************************************** github/olmatske */

EOF
	else
	cat >> "$filename" << 'EOF'
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
	fi
}

function cpp_includes() {

	local class="$1"
	local guard="${(U)class}_HPP"

	cat  >> "${class}.cpp" << EOF
#include "${classes[count]}.hpp"

${class}::${class}() : type("${class}") {
	std::cout << G << "${class} default constructor called" << R << std::endl;
}

${class}::${class}( std::string type ) : type(type) {
	std::cout << G << "${class} parametarized constructor called" << R << std::endl;
}

${class}::${class}( const ${class} &other ) : type(other.type) {
	std::cout << G << "${class} copy constructor called" << R << std::endl;
	this->type = other.type;
}

${class} &${class}::operator=( const ${class} &other ) {
	std::cout << G << "${class} assignment operator called" << R << std::endl;
	if (this != &other) {
		this->type = other.type;
	}
	return (*this);
}

${class}::~${class}() {
	std::cout << G << "${class} Destructor called" << R << std::endl;
}

EOF

	cat  >> "${class}.hpp" << EOF
#ifndef ${guard}
#define ${guard}

#include "Colors.hpp"
#include <iostream>
#include <string>

#endif

class ${class} {

	public:
		${class}();
		${class}( std::string type );
		${class}( const ${class} &other );
		${class}& operator=( const ${class} &other );

};

EOF
}

# //////////////////////////////////////////////////////////////////////////////

function fill_main() {

local class="$1"

	cat >> main.cpp << EOF
#include "${class}.hpp"
EOF
}

# //////////////////////////////////////////////////////////////////////////////
function fill_Makefile() {
# if Makefile is not empty, empty it beforehand and append?
	cat >> Makefile << EOF
NAME = ${executable}
CXX = c++
FLAGS = -Wall -Werror -Wextra -std=c++17

SRC = main.cpp ${sources}
OBJ = \$(SRC:.cpp=.o)

all: \$(NAME)

\$(NAME): \$(OBJ)
	\$(CXX) \$(FLAGS) \$(OBJ) -o \$(NAME)

%.o: %.cpp
	\$(CXX) \$(FLAGS) -c \$< -o \$@

clean:
	rm -rf \$(OBJ)

fclean: clean
	rm -rf \$(NAME)

re: fclean all

.PHONY: all clean fclean re

EOF
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
fill_Makefile
echo '#include "Colors.hpp"' >> main.cpp

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

