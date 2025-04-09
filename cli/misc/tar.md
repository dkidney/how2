## tar

### examples

```sh
# tar files in a directory
tar my_directory

# untar
tar -xvzf archived_directory.tar.gz -C ~/Downloads/
```

### args

```
-x: tells tar to extract files from the archive. 

-v: (optional) verbose, list the names of files being extracted. 

-z: decompress the archive using gzip, which is common for .tar.gz files. 

-f: name of the archive to be opened

-C: target directory
```