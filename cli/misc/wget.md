## wget

https://www.gnu.org/software/wget/manual/wget.html

### examples

```sh
url=http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz

wget -nv -N -P ~/Downloads/ ${url}
```

### args

```
-N: don't overwrite if already downloaded unless an updated version is available

-nv, --no-verbose: no printing apart from errors

-P: specify target directory
```
