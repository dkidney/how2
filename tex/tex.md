tex
================

  - [links](#links)
  - [installation](#installation)
      - [brew](#brew)
      - [manually upgrade texlive](#manually-upgrade-texlive)
      - [check installation](#check-installation)
  - [tlmgr](#tlmgr)
  - [test](#test)

-----

## links

  - <https://tug.org/texlive/upgrade.html>  
  - <https://sourabhbajaj.com/mac-setup/LaTeX/>

-----

## installation

### brew

Some available options:

``` sh
# view your options
brew search latex 

# three versions of MacTeX
brew cask install basictex # 100MB - doesn't include lots of packages and programs
brew cask install mactex # 3GB+ - includes additional packages and programs
brew cask install mactex-no-gui # as above but without the gui :)
```

### manually upgrade texlive

<https://riptutorial.com/latex/example/7452/installation-and-setup>

``` sh
cd ~/Downloads/
wget "http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
tar -xf install-tl-unx.tar.gz
cd ~/Downloads/
ls . | grep "install-tl-2019"
cd install-tl-20190731
sudo ./install-tl -gui text 
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

  - command line package manager

<!-- end list -->

``` sh
brew cask install tex-live-utility # a gui for tlmgr
```

``` sh
# update tlmgr itself
tlmgr update --self # might need sudo

# see a list of the updatable packages
tlmgr update --list

# update all packages
tlmgr update --all # might need sudo

# install a package
tlmgr install ctex # might need sudo
```

-----

## test

``` sh
rm ~/temp.tex
touch ~/temp.tex
echo '\\documentclass{article}' >> ~/temp.tex
echo '\\begin{document}' >> ~/temp.tex
echo 'Hello World!' >> ~/temp.tex
echo '\\end{document}' >> ~/temp.tex
cat ~/temp.tex
## \documentclass{article}
## \begin{document}
## Hello World!
## \end{document}
```

``` sh
pdflatex ~/temp.tex
open -na 'Preview.app' ~/temp.pdf
```
