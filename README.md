<!--************************************************************************* */
/*              ／＞　 フ                        ˚★ ₊ ⊹　  ࣪˖ ࣪ ࣪ ˖⋆˚★ ₊ ⊹　  ࣪˖ ࣪ ₊  ࣪ ˖*/
/*             | 　_　_|                              ˖ ࣪　⊹ ࣪ ★⊹ ࣪ ┆ ˖ ࣪　⊹ ࣪ ★ ⋆.˚  ⊹ ࣪*/
/*            ／` ミ＿xノ                                    ࣪ ˖⋆˚★ ₊ ⊹　  ࣪˖ ࣪ ₊  ࣪ ˖*/
/*           /　　　　 |                                    ˖⋆˚★ ₊ ⊹　  ࣪˖ ࣪ ₊  ࣪ ˖　*/
/*          /　 ヽ　　 ﾉ           へ   ╱|、 ♡   ╱|、        ☆⊹ ࣪ ┆ ˖ ࣪　⊹ ࣪ ★ .˚  ⊹ */
/*          │　　|　|　|       ૮ - ՛ ) (˚ˎ 。7  (` -  7           ˚★ ₊ ⊹　  ࣪˖ ࣪ ₊ */
/*      ／￣ 　　 |　|　|       /  ⁻៸|  |、 ˜(    |、⁻(           ★ ₊ ⊹　  ࣪˖ ࣪ ࣪ ˖⋆ */
/*      ( ( ヽ＿_ヽ_)__)   乀 (ˍ, ل ل  じしˍ,)ノ じしˍ,)ノ         　⊹ ࣪ ★ ⋆.˚    */
/*      ＼__二)                                               ࣪˖ ࣪ ₊  ★⊹ ࣪ ┆  ★ ⋆.*/
/* ********************************************************** github/olmatske -->

# 👾 Zsh Scripting 👾

In this directory I'm scripting my first zsh script and documenting my journey in this Markdown file. It's mainly for the C++ Projects of my school, namely the CPP Modules. This also works for Python Modules if you tweak a couple of things, alltough I recommend for both Curriculums to first go through the pain of making the directories, creating the files, writing classes and their headers etc by hand until you are truly and utterly sick of it.

## 🌱 What the script does

### 🗃 mkclass

It does a lot of things:
- asks user to input directory, class and executable names
- creates a directory
- creates classes with both .cpp _and_ .hpp files
- creates main.cpp
- crreates Makefile
- creates a Color.hpp (I love an LSD infused terminal!)

we're not done yet!
- every single file has my own custom header which you can change or remove to your liking!
- fills .hpp class files with include guards tailored to the class and adds iostream and string libraries (and Color.hpp), as well as a Class template with all the constructors
- fills .cpp class files with the respected class header as well as the constructor declarations
- fills main.cpp with all the custom class headers (and Color.cpp) 
- fills the Makefile with all the basic neccessities and inputs the executable name as well as the .cpp files for you, so it's 100% ready to go if you're going for the standard minimal Makefile



### 🧬 cpyclass

_coming soon..._

## 🌱 How to use the script

_coming soon..._

## 🌱 Roadmap

### ./mkclass

- [X] create directory
	- [X] ask and create .cpp and .hpp files
	- [X] create main.cpp
	- [X] create Makefile
- [X] header (with cats) in all files
- [X] standard libraries in .hpp files
- [X] ANSI colors in Color.cpp
- [X] create Makefile template
	- [X] take the Class names and write them as sources
	- [X] ask and input executable
- [X] Class template in .cpp and .hpp class files

### ./cpydir

- [ ] copy the whole directory with all the files
- [ ] prompt for new Classes and new Executable
- [ ] treat myself to a coffee!


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

	`echo "Creeper Aww Man" | cat -e`

		Creeper Aww Man$

	`echo -e "Creeper Aww Man \n" | cat -e`

		Creeper Aww Man$
		$


## 🌱 Resources that helped me

_coming soon..._

