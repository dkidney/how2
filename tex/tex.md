tex
================

  - [links](#links)
  - [installation](#installation)
      - [brew](#brew)
      - [manually install texlive](#manually-install-texlive)
      - [check installation](#check-installation)
  - [tlmgr](#tlmgr)

-----

## links

  - <https://sourabhbajaj.com/mac-setup/LaTeX/>

-----

## installation

### brew

Some available options:

``` sh
# view your options
brew search latex 

# three options
brew cask install basictex # 100MB - doesn't include lots of packages and programs
brew cask install mactex # 3GB+ - includes additional packages and programs
brew cask install mactex-no-gui # as above but without the gui :)
```

### manually install texlive

Linux

``` sh
wget -P ~/Downloads/ "http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
```

### check installation

``` sh
which tex
## /Library/TeX/texbin/tex
```

``` sh
tex --version
## TeX 3.14159265 (TeX Live 2018)
## kpathsea version 6.3.0
## Copyright 2018 D.E. Knuth.
## There is NO warranty.  Redistribution of this software is
## covered by the terms of both the TeX copyright and
## the Lesser GNU General Public License.
## For more information about these matters, see the file
## named COPYING and the TeX source.
## Primary author of TeX: D.E. Knuth.
```

-----

## tlmgr

``` sh
brew cask install tex-live-utility # a gui for tlmgr
```
