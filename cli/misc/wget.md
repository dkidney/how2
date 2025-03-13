## wget

https://www.gnu.org/software/wget/manual/wget.html

```sh
url=http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz

# download to current directory
wget ${url}

# download to current directory but don't print anything out (except errors)
wget --no-verbose ${url}

# download to specified directory prefix
wget --no-verbose -P ~/Downloads/ ${url}
```

