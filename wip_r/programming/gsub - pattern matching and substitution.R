## ------------------------------------------------------------------------- ## 
## ------------------------------------------------------------------------- ## 

## gsub - examples

## ------------------------------------------------------------------------- ## 
## ------------------------------------------------------------------------- ## 


# syntax ------------------------------------------------------------------

# \\d   Digit, 0,1,2 ... 9
# \\D	  Not Digit
# \\s	  Space
# \\S	  Not Space
# \\w	  Word
# \\W   Not Word
# \\t	  Tab
# \\n	  New line
# ^	    Beginning of the string
# $	    End of the string
# \	    Escape special characters, e.g. \\ is '\', \+ is '+'
# |	    Alternation match. e.g. /(e|d)n/ matches 'en' and 'dn'
# •	    Any character, except \n or line terminator

# [ab]	a or b
# [^ab]	Any character except a and b
# [0-9]	All Digit
# [A-Z]	All uppercase A to Z letters
# [a-z]	All lowercase a to z letters
# [A-z]	All Uppercase and lowercase a to z letters

# i+	i at least one time
# i*	i zero or more times
# i?	i zero or 1 time
# i{n}	i occurs n times in sequence
# i{n1,n2}	i occurs n1 - n2 times in sequence
# i{n1,n2}?	non greedy match, see above example
# i{n,}	i occures >= n times

# [:alnum:]	Alphanumeric characters: [:alpha:] and [:digit:]
# [:alpha:]	Alphabetic characters: [:lower:] and [:upper:]
# [:blank:]	Blank characters: e.g. space, tab
# [:cntrl:]	Control characters
# [:digit:]	Digits: 0 1 2 3 4 5 6 7 8 9
# [:graph:]	Graphical characters: [:alnum:] and [:punct:]
# [:lower:]	Lower-case letters in the current locale
# [:print:]	Printable characters: [:alnum:], [:punct:] and space
# [:punct:]	Punctuation character: ! ' # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
# [:space:]	Space characters: tab, newline, vertical tab, form feed, carriage return, space
# [:upper:]	Upper-case letters in the current locale
# [:xdigit:]	Hexadecimal digits: 0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f



# examples ----------------------------------------------------------------

txt = '  some  tEXT  1.2.3.4  '

gsub(' ',   '', txt)  # delete all spaces
gsub('^ ',  '', txt)  # delete first space
gsub('$ ',  '', txt)  # delete last space
gsub('^ +', '', txt)  # delete leading spaces
gsub(' +$', '', txt)  # delete trailing spaces
gsub(' +',  ' ', txt) # replace runs of spaces with single space

gsub('\\.', '_', txt) # change dots to underscores
gsub('^',   '.', txt) # put a dot at the beginning
gsub('$',   '.', txt) # put a dot at the end

gsub('[[:digit:]]',  '', txt) # delete all digits
gsub('[[:alpha:]]',  '', txt) # delete all letters
gsub('[^[:digit:]]', '', txt) # delete anything that isn't a digit
gsub('[^[:alpha:]]', '', txt) # delete anything that isn't a letter
gsub('[[:alnum:]]',  '', txt) # delete all alpha numeric
gsub('[1-3]',        '', txt) # delete digits 1-3
gsub('[[:upper:]]',  '', txt) # delete all upper case
gsub('[[:lower:]]',  '', txt) # delete all lower case
gsub('[m-t]',        '', txt) # delete lower case m to t
gsub('[^m-t]',       '', txt) # delete anything that isn't lower case m to t

gsub('([[:upper:]])', '\\L\\1', txt, perl=TRUE) # change to lower case
gsub('([[:lower:]])', '\\U\\1', txt, perl=TRUE) # change to upper case
sub('([[:alpha:]])',  '\\U\\1', txt, perl=TRUE) # change first letter to upper case
gsub("\\b(\\w)",      "\\U\\1", txt, perl=TRUE) # change first letter of each word to upper

gsub("([em])", "\\1_\\1_", txt) # repeat all e and m and separate with _


# things to find out ------------------------------------------------------

# delete first digit
# delete first word
# what does \\b mean

## ------------------------------------------------------------------------- ## 
## ------------------------------------------------------------------------- ## 
