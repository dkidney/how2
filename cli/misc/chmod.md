## chmod

* change file modes

```
 _____________  file type
|  ___________  user (i.e. owner) permissions
| |   ________  group permissions
| |  |   _____  others permissions
| |  |  |  
| |  |  | 
-rwxrwxrwx # symbolic notation e.g. as displayed by ls -l
```

### file type

`-` : regular file  
`d` : directory  
`c` : character special file  

### permissions

`-` : not permitted  
`r` : read  
`w` : write  
`x` : execute  

```sh
# generic usage
# who  : a | u | g | o
# op   : + | - | =
# perm : r | s | t | w | x | X | u | g | o
chmod [who][op][perm] path/to/file
```

### who

`u` : user  
`g` : group  
`o` : others  
`a` : all  

```sh
# add executable user permission
chmod u+x path/to/file

# remove executable user permission
chmod u-x path/to/file

# add user, group and others permissions to executable
chmod ugo+x path/to/file
chmod a+x path/to/file # same as above
chmod +x path/to/file # same as above
```
