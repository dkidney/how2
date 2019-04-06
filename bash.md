bash
================

-   [change directory](#change-directory)
-   [get help](#get-help)
-   [list files](#list-files)
-   [make a directory](#make-a-directory)
-   [make a file](#make-a-file)
-   [make a variable](#make-a-variable)

#### change directory

``` sh
pwd
cd ~/Downloads && pwd
cd -
cd ../ && pwd
cd -
```

#### get help

``` sh
mkdir -help
```

#### list files

``` sh
ls -al
```

-   `-l` print list with extra info
-   `-a` include hidden files

#### make a directory

``` sh
mkdir -p new_dir/new_subdir
```

#### make a file

``` sh
touch temp.txt
echo "hello" > temp.txt
cat temp.txt
```

#### make a variable

``` sh
DIR=Downloads
echo $DIR
cd ~/$DIR && pwd
cd -
```
