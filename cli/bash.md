# bash

> Bourne-again shell

<a name="top"></a>

* [arrays](#arrays)  
* [boolean operators](#boolean-operators)  
* [braces](#braces)  
* [colours](#colours)  
* [conditions](#conditions)  
* [for loops](#for-loops)  
* [functions](#functions)  
* [if statements](#if-statements)  
* [multiple lines](#multiple-lines)  
* [redirection](#redirection)  
* [scripts](#scripts)  
* [variables](#variables)  
* [while statements](#while-statements)  
* [wildcards](#wildcards)  

## links

* https://devhints.io/bash

## arrays

```sh
myarray=(a b c d e f g h i j k l m n o p q r s t u v w)
echo ${myarray[0]}     # first element
echo ${myarray[*]}     # all elements
myarray[0]=A           # update element
echo ${myarray[*]:5:3} # 6th, 7th and 8th elements
myarray+=(x y z)       # append 
echo ${#myarray[*]}    # array length
```

<a class="top-link hide" href="#top">↑</a>

## for loops

`for [variable] in [list] ; do [body] ; done`

```sh
for ext in gif jpg png; do echo $ext; done
for file in dir/*.csv; do echo $file; done
```

```sh
for i in {1..3}
do
    echo "loop $i"
done
```

```sh
myarray=(abc def ghi)
for elem in ${myarray[*]}
do
    echo "Current element: $elem"
done
```

```sh
for file in $(ls)
do
    echo "file $file"
done
```

<a class="top-link hide" href="#top">↑</a>

## if statements

```sh
echo "Start"

if [[ condition ]]
then
  echo "a"
else
  echo "b"
fi

echo "End"
```

### elif

```sh
if [[ condition1 ]] && [[ condition2 ]]
then
  echo "a"
elif [[ condition3 ]] || [[ condition4 ]] || [[ condition5 ]]
then
  echo "b"
else
  echo "c"
fi
```

<a class="top-link hide" href="#top">↑</a>

## braces

```sh
echo {0..9} # 0 1 2 3 4 5 6 7 8 9
echo {a..e} # a b c d e
echo {W..Z} # W X Y Z
echo a{0..4} # a0 a1 a2 a3 a4
echo b{0..4}c # b0c b1c b2c b3c b4c
echo {1..3}{A..C} # 1A 1B 1C 2A 2B 2C 3A 3B 3C
start=4
end=9
echo {$start..$end} # {4..9}
eval echo {$start..$end} # 4 5 6 7 8 9
echo {Who,What,Why,When,How}\? # Who? What? Why? When? How?
```

<a class="top-link hide" href="#top">↑</a>

## boolean operators

### and / or 

`&&` the AND operator - rhs will only be executed if lhs has exit status 0 (i.e. true)
`||` the OR operator - rhs will only be executed if lhs has exit status non-0 (i.e. false)

```sh
true  && echo 'line 1' # gets printed
false && echo 'line 2'
true  || echo 'line 3'
false || echo 'line 4' # gets printed

true  && echo t || echo f # t
false && echo t || echo f # f
```

### other operators

`=` string equal to
`!=` string not equal to
`=~` regex match operator 
`!` not operator (leave a space between the operator and the string)

```sh
mystring=asdf
[[ $mystring = "hello" ]] && echo t || echo f
[[ $mystring != "hello" ]] && echo t || echo f
[[ $mystring =~ [aeiou] ]] && echo t || echo f
[[ ! $mystring =~ [aeiou] ]] && echo t || echo f
```

<a class="top-link hide" href="#top">↑</a>

## conditions

```sh
[[ 4 -gt 3 ]] # 4 > 3
[[-e path-to-file]] # file exists
[[-d path-to-dir]] # dir exists
[[-z string]] # length of string is zero
[[-n string]] # length of string is non-zero
```

`-gt`	Greater Than
`-ge`	Greater Than or Equal To
`-eq`	Equal
`-ne`	Not Equal
`-le`	Less Than or Equal To
`-lt`	Less Than
`-e`	A File Exists	[[ -e $taxes_2016 ]]
`-d`	A Directory Exists	[[ -d $photos ]]
`-z`	Length of String is Zero	[[ -z $name ]]
`-n`	Length of String is Non-Zero	[[ -n $name ]]

<a class="top-link hide" href="#top">↑</a>

## functions

```sh
function hello {
  echo "Hello"
}
hello
# Hello
```

You can use variables like `$1`, `$2`, and `$@` in order to provide arguments to functions, just like a Bash script.

Variables defined within functions are available globally by default. To avoid this, use the `local` keyword when assigning variables within a function to ensure that variables outside of the function are not overwritten.

```sh
function addseq {
  local sum=0

  for element in $@
  do
    let sum=sum+$element
  done

  echo $sum
}

my_sum=$(addseq 5 10 15 20)
echo $my_sum
```

You can use the `source` command to import functions defined in a Bash script.

```sh
source addseq.sh
my_sum=$(addseq 5 10 15 20)
echo $my_sum
```

<a class="top-link hide" href="#top">↑</a>

### redirection {-#bashredirect}

```sh
command > output-file # redirect output to new file  
command >> output-file # append output to existing file (create if it doesn't exist)
```

E.g. 

```sh
bash script.sh > output.out
```

stdout and stderr:

```sh
command > output-file 2>&1 # redirect stdout and stderr to output file
command >> output-file 2>&1 # redirect stdout and stderr to output file
```

* file descriptor `1` is the standard output (stdout)  
* file descriptor `2` is the standard error (stderr)  
* `2` : refers to the second file descriptor (i.e. stderr)  
* `>` :  means redirection  
* `&1` : means the target of the redirection should be the same location as the first file descriptor (i.e. stdout)  

<!-- ### regex {-#bashregex} -->

<!-- * http://regexr.com/ -->

<!-- ### metacharacters  -->

<!-- * `.` any character   -->
<!-- * `+` one or more occurrences of the preceeding expression   -->
<!-- * `*` zero or more occurrences of the preceding expression   -->
<!-- * `?` zero or one occurrences of the preceding expression   -->
<!-- * `{#}` specify the exact number of occurrences of the preceding expression   -->
<!-- * `{#,#}` specify the range of the number of occurrences of the preceding expression   -->
<!-- * `(...)` a capturing group -->
<!-- * `\w` 'word' characters -->
<!-- * `\d` 'digit' characters -->
<!-- * `\s` 'space' characters -->
<!-- * `\W` non-'word' characters -->
<!-- * `\D` non-'digit' characters -->
<!-- * `\S` non-'space' characters -->
<!-- * `[...]` explicit character set - e.g. `[aeiou]`, `[e-qE-Q]` -->
<!-- * `[^...]` explicit character set complement/negation/inverse - e.g. `[^aeiou]`, `[^e-qE-Q]` -->
<!-- * `\` escape - e.g. `\.`, `\+` -->
<!-- * `^` anchor start of line -->
<!-- * `$` anchor end of line -->
<!-- * `|` OR - e.g. `(a|b)` -->

<a class="top-link hide" href="#top">↑</a>

## scripts

```sh
echo 'echo "Arg list: $@"
echo "First arg: $1"
echo "Second arg: $2"
echo "Number of args: $#"
' > script.sh 
```

```sh
bash script.sh abc xyz
## Arg list: abc xyz
## First arg: abc
## Second arg: xyz
## Number of args: 2
```

* `$1` first command-line parameter given to the script
* `$2` second command-line parameter given to the script
* `$@` all of the command-line parameters given to the script
* `$#` all of the command-line parameters given to the script

<a class="top-link hide" href="#top">↑</a>

## while 

```sh
count=3
while [[ $count -gt 0 ]]
do
  echo "count is equal to $count"
  let count=$count-1
done
```

<a class="top-link hide" href="#top">↑</a>

## wildcards

* `*` match zero or more characters
* `?` match a single character 
* `[...]` matches any of the characters in the square brackets
* `{...}` matches any of the comma-separated patterns inside the brackets, e.g. `{*.txt, *.csv}`

```sh
ls 2016*
ls *.jpg
ls *abc*
mv 2017-* 2017/
```

<a class="top-link hide" href="#top">↑</a>

## variables

* `Environment variables` = permanent variables
* `Shell variables` = local variables

```{sh}
# shell version
echo $SHELL
```

```sh
# print all environment variables
set

# example environment variables
echo $PWD
echo $HOME
echo $USER
echo $SHELL

# make a new local variable
DIR=~/Downloads && echo $DIR
cd $DIR && pwd
cd - && pwd
```

```{sh}
# use the output of a command as a variable
echo 'my zsh is installed here:' $(which zsh)
```

```sh
WD=$(pwd)
echo $WD

TODAY=$(date +%Y%m%d)
echo $TODAY
```

<a class="top-link hide" href="#top">↑</a>

## multiple lines

### single commands 

```sh
use backslashes \
to break up commands \
across multiple \
lines
```

### multiple commmands 

`|` : the (standard) output of the command on left are used as the (standard) input to the command on right

`;` : command on right executed once the command on left has terminated

`&&` : command on right is only executed if the command on left returns an exit status of zero

`||` : command on right is only executed if the command on left returns an exit status of non-zero

`&` : command on left is executed the background - the shell does not wait for the command to finish and immediately returns exit code 0

`|&` : shorthand for `2>&1` - both standard output and standard error of command on left are are used as the (standard) input to the command on right

<a class="top-link hide" href="#top">↑</a>

## colours {-#bashcolours}

* https://en.wikipedia.org/wiki/ANSI_escape_code#Colors

```sh
black='\033[0;30m'  
dark_gray='\033[1;30m'
red='\033[0;31m'  
light_red='\033[1;31m'
green='\033[0;32m'  
light_green='\033[1;32m'
brown_orange='\033[0;33m'  
yellow='\033[1;33m'
blue='\033[0;34m'  
light_blue='\033[1;34m'
purple='\033[0;35m'  
light_purple='\033[1;35m'
cyan='\033[0;36m'  
light_cyan='\033[1;36m'
light_gray='\033[0;37m'  
white='\033[1;37m'
none='\033[0m'

echo ${black}black${none}\\n\
     ${dark_gray}dark_gray${none}\\n\
     ${red}red${none}\\n\
     ${light_red}light_red${none}\\n\
     ${green}green${none}\\n\
     ${light_green}light_green${none}\\n\
     ${brown_orange}brown_orange${none}\\n\
     ${yellow}yellow${none}\\n\
     ${blue}blue${none}\\n\
     ${light_blue}light_blue${none}\\n\
     ${purple}purple${none}\\n\
     ${light_purple}light_purple${none}\\n\
     ${cyan}cyan${none}\\n\
     ${light_cyan}light_cyan${none}\\n\
     ${white}white${none}
```

<a class="top-link hide" href="#top">↑</a>
