<!--************************************************************************** */
/*              ／＞　 フ                        ˚★ ₊ ⊹　  ࣪˖ ࣪ ࣪ ˖⋆˚★ ₊ ⊹　  ࣪˖ ࣪ ₊  ࣪ ˖*/
/*             | 　_　_|                             ˖ ࣪　⊹ ࣪ ★⊹ ࣪ ┆ ˖ ࣪　⊹ ࣪ ★ ⋆.˚  ⊹ ࣪*/
/*            ／` ミ＿xノ                                    ࣪ ˖⋆˚★ ₊ ⊹　  ࣪˖ ࣪ ₊  ࣪ ˖*/
/*           /　　　　 |                                    ˖⋆˚★ ₊ ⊹　  ࣪˖ ࣪ ₊  ࣪ ˖　*/
/*          /　 ヽ　　 ﾉ           へ   ╱|、 ♡  ╱|、        ☆⊹ ࣪ ┆ ˖ ࣪　⊹ ࣪ ★ .˚  ⊹ */
/*          │　　|　|　|       ૮ - ՛ ) (˚ˎ 。7  (` -  7           ˚★ ₊ ⊹　  ࣪˖ ࣪ ₊ */
/*      ／￣ 　　 |　|　|       /  ⁻៸|  |、 ˜(    |、⁻(           ★ ₊ ⊹　  ࣪˖ ࣪ ࣪ ˖⋆ */
/*      ( ( ヽ＿_ヽ_)__)   乀 (ˍ, ل ل  じしˍ,)ノ じしˍ,)ノ         　⊹ ࣪ ★ ⋆.˚    */
/*      ＼__二)                                               ࣪˖ ࣪ ₊  ★⊹ ࣪ ┆  ★ ⋆.*/
/* ********************************************************** github/olmatske -->

# 👾 Zsh Scripting 👾

In this directory I'm scripting my first zsh script and documenting my journey in this Markdown file. It's mainly for the C++ Projects of my school, namely the CPP Modules. This also works for Python Modules, alltough I recommend for both Curriculums to first go through the pain of making the directories, creating the files, writing classes and their headers etc by hand until you are truly and utterly sick of it.

## 🌱 How to use the script

_coming soon..._

## 🌱 Roadmap

### ./mkclass

- [X] create directory
	- [X] ask and create .cpp and .hpp files
	- [X] create main.cpp
	- [X] create Makefile
- [ ] header (with cats) in all files
- [ ] standard libraries in .hpp files
- [ ] ANSI colors in .hpp file(s)
- [ ] create Makefile template
	- [ ] take the Class names and write them as sources
	- [ ] ask and input executable

### ./cpydir

- [ ] copy the whole directory with all the files
- [ ] create additional directories
- [ ] buy coffee


## 🌱 Useful knowledge for scripting

### Brackets

**(...):**	creates an array

	array		->		# classes=(dog cat hamster)

**{...}:**	brace expansion which generates multiple strings from a pattern

	echo file.{cpp,hpp}		->	# file.cpp file.hpp
	mkdir -p ex{01,02,03}	->	# ex01 ex02 ex03
	echo {1..5}				->	# 1 2 3 4 5

### Commands

- `echo` is specifically for printing but `echo -e` acknowledges _escape sequences_ aka backslashes followed by a flag, such as `\n` for newline or `\t` for tab

	`echo "It's Britney bitch" | cat -e`

		It's Britney bitch$

	`echo -e "It's Britney bitch \n" | cat -e`

		It's Britney bitch$
		$


## 🌱 Resources that helped me

_coming soon..._

