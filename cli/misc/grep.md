## grep 

Print lines matching a pattern - 'lines' is wrt to the console output, so can search file contents or files in a list of files, etc.


```sh
# match pattern
grep pattern path/to/file

# match pattern1 OR pattern2
grep 'pattern1\|pattern2' path/to/file
grep -E '(pattern1|pattern2)' path/to/file
egrep '(pattern1|pattern2)' path/to/file

# inverse match pattern
grep -v pattern path/to/file

# search the contents of files
grep -rnw 'pattern' path
```

`-c` count the number of matching lines  
`-h` don't print the names of files when searching multiple files  
`-i` case insensitive  
`-l` print the names of files that contain matches, not the matches  
`-n` print line numbers for matching lines  
`-r` recursive
`-v` invert/complement/negation - i.e. show non-matching lines  
`-w` expression is searched for as a word


## egrep

Like `grep -E`.

```sh
egrep "i.g" path(s)/to/file(s)
egrep "[aeiou]" path(s)/to/file(s)
egrep "[^aeiou]" path(s)/to/file(s)
egrep -v "\w" path(s)/to/file(s)
```

