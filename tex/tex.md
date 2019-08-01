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

  - <http://tug.org/texlive/doc/install-tl.html>  
  - <https://riptutorial.com/latex/example/7452/installation-and-setup>

<!-- end list -->

``` sh
cd ~/Downloads/
wget "http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
tar -xf install-tl-unx.tar.gz
cd ~/Downloads/
#ls . | grep "install-tl-2019"
#cd install-tl-20190731
cd install-tl-*/

# set alternative env vars
TEXLIVE_INSTALL_PREFIX=/home/your_user/texlive
TEXLIVE_INSTALL_TEXDIR=/home/your_user/texlive/2019

# or create a setup config file to install all the packages you need:

cat > texlive.profile << 'EOF'
# selected_scheme scheme-full
# TEXDIR /opt/texlive
# TEXMFCONFIG ~/.texlive/texmf-config
# TEXMFHOME ~/texmf
# TEXMFLOCAL /opt/texlive/texmf-local
# TEXMFSYSCONFIG /opt/texlive/texmf-config
# TEXMFSYSVAR /opt/texlive/texmf-var
# TEXMFVAR ~/.texlive/texmf-var
# binary_x86_64-linux 1
instopt_adjustpath 1
# instopt_adjustrepo 0
# instopt_letter 0
# instopt_portable 0
# instopt_write18_restricted 1
# tlpdbopt_autobackup 1
# tlpdbopt_backupdir tlpkg/backups
# tlpdbopt_create_formats 1
# tlpdbopt_generate_updmap 0
# tlpdbopt_install_docfiles 0
# tlpdbopt_install_srcfiles 0
# tlpdbopt_post_code 1
# tlpdbopt_sys_bin /usr/local/bin
# tlpdbopt_sys_info /usr/local/share/info
# tlpdbopt_sys_man /usr/local/share/man
EOF
# start the installer
sudo ./install-tl -gui text --profile texlive.profile
```

To change the install directory use env var `TEXLIVE_INSTALL_TEXDIR`.

### check installation

``` sh
which tex
## /Library/TeX/texbin/tex
```

``` sh
tex --version
## TeX 3.14159265 (TeX Live 2019)
## kpathsea version 6.3.1
## Copyright 2019 D.E. Knuth.
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
## rm: /Users/darrenkidney/temp.tex: No such file or directory
## \documentclass{article}
## \begin{document}
## Hello World!
## \end{document}
```

``` sh
pdflatex ~/temp.tex
open -na 'Preview.app' ~/temp.pdf
```
