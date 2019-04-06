bash
================

-   [change directory](#change-directory)
-   [copy to clipboard](#copy-to-clipboard)
-   [get help](#get-help)
-   [list files](#list-files)
-   [make a directory](#make-a-directory)
-   [make a file](#make-a-file)
-   [make a variable](#make-a-variable)
-   [print the tail of a file](#print-the-tail-of-a-file)

#### change directory

``` sh
pwd
cd ~ && pwd
cd -
cd ~/Downloads && pwd
cd -
cd ../ && pwd
cd -
```

#### copy to clipboard

``` sh
pbcopy < ~/.ssh/id_rsa.pub
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
cd !$ && pwd
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

#### print the tail of a file

``` sh
tail -f path_to_file
```
