#!/usr/bin/env zsh

# //////////////////////////////////////////////////////////////////////////////
# Prompts
# //////////////////////////////////////////////////////////////////////////////

read "newd?Name of the new Directory: " || exit 1
while [[ -z "$newd" ]]; do
	read "newd?Name of the new Directory: " || exit 1
done
newdir="$newd"
while [[ "$newdir" == */ && "$newdir" != "/" ]]; do
	newdir="${newdir%/}"
done

read "olddir?Directory to be copied from: " || exit 1
while [[ -z "$olddir" ]]; do
	read "olddir?Directory to be copied from: " || exit 1
done

read "classinput?Input new Classes: " || exit 1
classes=(${(u)${=classinput}})

read "execinput?Name of the Executable: " || exit 1
executable="$execinput"

# //////////////////////////////////////////////////////////////////////////////
# Checks
# //////////////////////////////////////////////////////////////////////////////

if [[ ! -d "$olddir" ]]; then
	print -u2 "Error: '$olddir' is not a directory."
	exit 1
fi

src_abs="${olddir:A}"
dst_abs="${newdir:A}"
cwd_abs="${PWD:A}"

if [[ "$dst_abs" == "/" || "$dst_abs" == "$cwd_abs" ]]; then
	print -u2 "Error: refusing to use '$newdir' as the new directory."
	exit 1
fi

if [[ "$dst_abs" == "$src_abs" ]]; then
	print -u2 "Error: the new directory must differ from the source directory."
	exit 1
fi

if [[ "$src_abs" == "$dst_abs"/* ]]; then
	print -u2 "Error: the new directory cannot be a parent of the source directory."
	exit 1
fi

if [[ "$dst_abs" == "$src_abs"/* ]]; then
	print -u2 "Error: the new directory cannot be inside the source directory."
	exit 1
fi

if [[ -e "$newdir" ]]; then
	if [[ ! -d "$newdir" ]]; then
		print -u2 "Error: '$newdir' already exists and is not a directory."
		exit 1
	fi
	read "overwrite?Directory '$newdir' already exists. Overwrite it? [y/N]: " || exit 1
	case "${overwrite:l}" in
		y|yes)
			rm -rf "$newdir"
			;;
		*)
			print "Aborted."
			exit 1
			;;
	esac
fi

if ! cp -R "$olddir" "$newdir"; then
	print -u2 "Error: failed to copy '$olddir' to '$newdir'."
	exit 1
fi

cd "$newdir" || exit 1

# //////////////////////////////////////////////////////////////////////////////
# Helpers
# //////////////////////////////////////////////////////////////////////////////

function put_header() {
	local	filename="$1"

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
}

function fill_class() {
	local class="$1"
	local guard="${(U)class}_HPP"

	cat >> "${class}.hpp" << EOF
#ifndef ${guard}
#define ${guard}

#include "Colors.hpp"
#include <iostream>
#include <string>

class ${class} {

	private:
		std::string _name = "Bob";

	public:
		${class}();
		${class}( std::string type );
		${class}( const ${class} &other );
		${class}& operator=( const ${class} &other );
		~${class}();

};

#endif

EOF

	cat >> "${class}.cpp" << EOF
#include "${class}.hpp"

${class}::${class}() {
	std::cout << M << "Default constructor called" << R << std::endl;
}

${class}::${class}( std::string name ) : _name(name) {
	std::cout << M << "Parameterizes constructor called" << R << std::endl;
}

${class}::${class}( const ${class} &other ) : _name(other._name) {
	std::cout << M << "Copy constructor called" << R << std::endl;
	this->_name = other._name;
}

${class} &${class}::operator=( const ${class} &other ) {
	std::cout << M << "Copy assignment operator called" << R << std::endl;
	if (this != &other) {
		this->_name = other._name;
	}
	return (*this);
}

${class}::~${class}() {
	std::cout << M << "Destructor called" << R << std::endl;
}


EOF
}

function update_makefile() {
	local -a sources=("$@")
	local tmp line
	local found_src=0
	local found_name=0

	tmp=$(mktemp "${TMPDIR:-/tmp}/cpyclass.XXXXXX") || return 1

	while IFS= read -r line || [[ -n "$line" ]]; do
		if [[ "$line" =~ '^SRC[[:space:]]*=' ]]; then
			found_src=1
			if (( ${#sources} > 0 )); then
				line+=" ${(j: :)sources}"
			fi
		elif [[ "$line" =~ '^NAME[[:space:]]*=' ]]; then
			found_name=1
			if [[ -n "$executable" ]]; then
				line="NAME = $executable"
			fi
		fi
		print -r -- "$line" >> "$tmp"
	done < Makefile

	if (( found_src == 0 && ${#sources} > 0 )); then
		print -r -- "SRC = main.cpp ${(j: :)sources}" >> "$tmp"
	fi
	if (( found_name == 0 )) && [[ -n "$executable" ]]; then
		print -r -- "NAME = $executable" >> "$tmp"
	fi

	if ! cat "$tmp" > Makefile; then
		rm -f "$tmp"
		return 1
	fi
	rm -f "$tmp"
}

# //////////////////////////////////////////////////////////////////////////////
# Add new Classes
# //////////////////////////////////////////////////////////////////////////////

new_sources=()

for class in "${classes[@]}"; do
	if [[ ! "$class" =~ '^[A-Za-z_][A-Za-z0-9_]*$' ]]; then
		print -u2 "Skipping '$class': not a valid C++ class name."
		continue
	fi
	if [[ -e "${class}.cpp" || -e "${class}.hpp" ]]; then
		print "Skipping '$class': file(s) already exist."
		continue
	fi

	touch "${class}.cpp" "${class}.hpp"
	put_header "${class}.cpp"
	put_header "${class}.hpp"
	fill_class "$class"

	if [[ -f main.cpp ]]; then
		print -r -- "#include \"${class}.hpp\"" >> main.cpp
	else
		print -u2 "Warning: main.cpp not found; '${class}.hpp' was not added to it."
	fi

	new_sources+=("${class}.cpp")
	print "Added class '$class'."
done

# //////////////////////////////////////////////////////////////////////////////
# Update the Makefile
# //////////////////////////////////////////////////////////////////////////////

if (( ${#new_sources} > 0 )) || [[ -n "$executable" ]]; then
	if [[ -f Makefile ]]; then
		if ! update_makefile "${new_sources[@]}"; then
			print -u2 "Error: could not update the Makefile."
			exit 1
		fi
	else
		print -u2 "Warning: Makefile not found; sources and executable were not updated."
	fi
fi

print "Copied '$olddir' to '$newdir'."
