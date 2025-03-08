# miscellaneous commands

* https://towardsdatascience.com/rock-the-command-line-52c4b2ea34b7  

## apropos

Search all of the available commands and their descriptions.

```sh
apropos editor
```

## awk {#awk}

Good for extracting strings and patterns from files and analysing them...

## bc {#bc}

Bench calculator.

```sh
echo "22 / 7" | bc -l
echo "4.2 * 9.15" | bc -l
echo "(6.5 / 0.5) + (6 * 2.2)" | bc -l
```

## cd {#cd}

Change directory.

```sh
cd /  # root
cd    # home
cd ~  # home
cd .. # parent 
cd -  # previous 
```

## chflags {#chflags}

```sh
# unhide a file/folder
chflags nohidden PATH

# hide a file/folder
chflags hidden PATH
```


## chown {#chown}

**TODO**

## clear

```sh
# type 
clear
# to clear the screen
```

## cp {#cp}

Copy files.

```sh
cp src-file dest-file
cp src-file dest-dir
cp -r src-dir dest-dir
```

## cut {#cut}

Like head and tail but selects colums not rows.

```sh
# print fields 1-5 and 10 from a comma delimited file
cut -f 1-5,10 -d , path/to/file
```

## date {#date}

https://www.howtogeek.com/410442/how-to-display-the-date-and-time-in-the-linux-terminal-and-use-it-in-bash-scripts/

```sh
echo $(date)
echo $(date +%Y/%m/%d)
```

## diff {#diff}

Examine differences between files.

```sh
diff path-to-file1 path-to-file2
```

See also `sdiff`

## expr {#expr}

Mathematical expressions.

```sh
expr 5 + 2
expr 5 - 2
expr 5 \* 2
expr 5 / 2
```

Note that bash does integer division, which means that the result of dividing one number by another is always rounded down to the nearest integer.

*********************************************************************

## find {#find}

Find the location of a file or the location of a group of files.

```sh
find . -name "abc.txt" # find abc.txt in the current directory
find . -name "*.jpg"   # find all jpg files in the current directory
```

*********************************************************************

## head {#head}

```sh
# print the first 10 lines of a file
head -n 5 path/to/file

# shorthand
head -5 path/to/file
```

*********************************************************************

## history {#history}

Browse your command history.

```sh
history # prints everything!
history | tail -10         # last ten commands
tail -10 ~/.zsh_history    # last ten commands in .zsh_history
tail -10 ~/.bash_history   # last ten commands in .bash_history
tail -10 ~/.python_history # last ten commands in .python_history
```

*********************************************************************

## less {#less}

* like `cat`, but pages output instead of printing everything  
* one page is displayed at a time
* up and down keys to scroll line-by-line
* space bar to page down
* q to quit  

```sh
less path/to/file
```

* for more than one fileIf you give less the names of several files, you can type  
  * `:n` : move to the next file  
  * `:p` : go back to the previous file  
  * `:q` : quit  

```sh
less path/to/file1 path/to/file2 ...
```

### Searching

* `/` to search
* `n` for next match
* `SHIFT + n` or `p` for previous match


*********************************************************************

## let {#let}

Evaluates arithmetic expressions.

```sh
let "myvar = 5"; echo $myvar
# 5

let "myvar = 5, myvar *= 2"; echo $myvar
# 10

# set varone to 1, set vartwo to the value of varone, then increment the value of varone by one
let "varone = 1" "vartwo = varone++"; echo $varone, $vartwo
# 2, 1
``


*********************************************************************

## ln {#ln}

```{sh, eval=FALSE}
# create a file link
ln -sv ~/Github/dotfiles/.Rprofile ~
ln -sv ~/Github/dotfiles/.R/snippets/c_cpp.snippets ~/.R/snippets
ln -sv ~/Github/dotfiles/.R/snippets/css.snippets ~/.R/snippets
ln -sv ~/Github/dotfiles/.R/snippets/html.snippets ~/.R/snippets
ln -sv ~/Github/dotfiles/.R/snippets/java.snippets ~/.R/snippets
ln -sv ~/Github/dotfiles/.R/snippets/javascript.snippets ~/.R/snippets
ln -sv ~/Github/dotfiles/.R/snippets/markdown.snippets ~/.R/snippets
ln -sv ~/Github/dotfiles/.R/snippets/python.snippets ~/.R/snippets
ln -sv ~/Github/dotfiles/.R/snippets/r.snippets ~/.R/snippets
ln -sv ~/Github/dotfiles/.R/snippets/sql.snippets ~/.R/snippets
ln -sv ~/Github/dotfiles/.R/snippets/stan.snippets ~/.R/snippets
ln -sv ~/Github/dotfiles/.R/snippets/tex.snippets ~/.R/snippets
```

`-s` symbolic


*********************************************************************

## ls {#ls}

List files.

```sh
# list files in the current directory
ls

# list files in a particular directory
ls path/to/file # e.g. ls ~/.Trash

# print list with extra info
ls -l

# include hidden files
ls -a

# list directories only
ls -d

# print trailing / after all directories and * after programes
ls -F

# recursive
ls -R

# combine flags
ls -alF
```


*********************************************************************

## man {#man}

```sh
# get help
man ls
```

The controls for navigating man pages are the same as they are for less.


*********************************************************************

## md5 {#md5} 

Compute the MD5 hash (i.e. checksum) of a file.

```sh
md5 path-to-file
```

See also `shasum`

*********************************************************************

## mkdir {#mkdir} 

```sh
# make a directory
# -p ???
mkdir -p new_dir/new_subdir
cd !$ && pwd
```

*********************************************************************

## mv {#mv}

Move files.

```sh
mv src-file dest-file
mv src-file dest-dir
mv src-dir dest-dir
```

*********************************************************************

## nano {#nano}

Text editor.

```sh
nono my-file.txt
```

* `Control + O` save changes  
* `Control + X` exit   

You can create a new text file by using a path to a file that doesn't exist yet and saving the changes.


*********************************************************************

## nvram {#nvram}

nonvolatile random-access memory

```sh
# disable the startup chime
sudo nvram SystemAudioVolume=%80
```

*********************************************************************

## pbcopy {#pbcopy}

```sh
# copy to clipboard
pbcopy < ~/.ssh/id_rsa.pub
```

*********************************************************************

## read {#read}

User imput.

```sh
echo "Type in a string and then press Enter:"
read response
echo "You entered: $response"
```

*********************************************************************

## rm {#rm}

```sh
rm path-to-file         # delete file
rm -r path-to-folder    # delete folder
rm -rf path-to-folder/* # delete contents of folder but not the folder itself
```

*********************************************************************

## sed {#sed}

Stream editor.

*********************************************************************

## scp {#scp}

E.g. copy all R files

```sh
scp *.R $DNS:~
```

*********************************************************************

## sdiff {#sdiff}

Like `diff` but allows you to compare side by side.

```sh
sdiff path-to-file1 path-to-file2
```

See also `diff`

*********************************************************************

## sed {#sed}

Good for one-to-one replacement of strings in files.

*TODO*

*********************************************************************

## shasum {#shasum} 

Compute the SHA-1 hash (i.e. checksum) of a file.

```sh
shasum path-to-file
```

See also `md5`


*********************************************************************

## sort {#sort}

*TODO*


*********************************************************************

## ssh {#ssh}

*TODO*

```sh
# ssh keys
ssh-keygen -t rsa -C "your_email@example.com"
```

```
ssh-keygen
https://www.ssh.com/ssh/keygen/
https://www.git-tower.com/learn/git/ebook/en/command-line/advanced-topics/ssh-public-keys
ssh-copy-id
ssh-add
https://www.ssh.com/ssh/agent
ssh-agent
ssh -p, -A, 
https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys
```

*********************************************************************

## su {#su}

* switch user

*TODO*

*********************************************************************

## sudo {#sudo}

```sh
sudo !!
```

*TODO*


*********************************************************************

## tail {#tail}

```sh
# print the last 5 of a file
tail -n 5 path/to/file

# shorthand
tail -5 path/to/file

# print lines starting from line 5
tail -n +5 path/to/file

# print live as file gets appended
tail -f path/to/file
```


*********************************************************************

## tar {#tar}

```sh
# tar files
tar -zczf path/to/file.tar.gz path/to/file1 path/to/file2

# tar a directory
tar -zcvf path/to/file.tar.gz path/to/dir

# untar to current directory
tar -xvf ~/Downloads/install-tl-unx.tar.gz

# untar to specified directory
tar -C ~/Downloads/ -xvf ~/Downloads/install-tl-unx.tar.gz
```

`c`: create a new archive  
`C`: directory name  
`f`: file name  
`v`: verbose  
`x`: extract from archive  
`z`: compress using gzip  



*********************************************************************

## touch {#touch}

```sh
# make a file
touch temp.txt
echo "hello" > temp.txt
cat temp.txt
```


*********************************************************************

## uniq {#uniq}

*TODO*


*********************************************************************

## unzip {#unzip}

```sh
unzip path/to/file

# list files that would be unzipped but dont unzip
unzip -l path/to/file

# don't overwrite if unzipped file already exists
unzip -n path/to/file

# overwrite without prompting
unzip -o path/to/file

# specify directory
unzip path/to/file -d destination/folder
```

*********************************************************************

## vim {#vim}

Text editor.

https://vim.rtorr.com  
https://github.com/hackjutsu/vim-cheatsheet  

edit:

`i` - insert before the cursor  
Esc to exit insert mode  

save and exit:

`:w` write (save) the file (but don't quit)  
`:wq` write (save) and quit  
`:q` quit (fails if there are unsaved changes)  
`:q!` quit and throw away unsaved changes  
`:qa` quit all files (fails if there are unsaved changes)  
`:qa!` quit all files and throw away unsaved changes  

*********************************************************************

## wc {#wc}

Word count.

```sh
# print number of lines, words and bytes/characters
wc path/to/file

# print number of lines
wc -l path/to/file

# print number of words
wc -w path/to/file

# print number of bytes
wc -c path/to/file
```

*********************************************************************

