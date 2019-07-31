zsh
================

  - [oh-my-zsh](#oh-my-zsh)
  - [powerline fonts](#powerline-fonts)
  - [.zshrc](#zshrc)
  - [RStudio](#rstudio)

The Z-shell - a Unix shell built on top of `bash` with additional
features.

``` sh
# install zsh
brew install zsh

# check version
zsh --version

# check path 
which zsh
```

Make `zsh` your default shell

``` sh
# check if it's already your default shell
echo $SHELL # expect /usr/local/bin/zsh
$SHELL --version # expect zsh 5.7.1 or higher

# check that zsh path is listed in /etc/shells - add it if necessary
cat /etc/shells
sudo sh -c "echo $(which zsh) >> /etc/shells"

# make zsh your default shell
chsh -s $(which zsh)

# relaunch the terminal and check the default shell again
echo $SHELL
$SHELL --version
```

-----

#### oh-my-zsh

<https://github.com/robbyrussell/oh-my-zsh>

> an open source, community-driven framework for managing your zsh
> configuration

``` sh
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

-----

#### powerline fonts

``` sh
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
```

-----

#### .zshrc

My `.zshrc`

User: `darrenkidney` `~/.zshrc`

``` zshrc
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# zsh --------------------------------------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH="/Users/darrenkidney/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# COMPLETION_WAITING_DOTS="true"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
plugins=(
  aws
  brew
#  colored-man-pages
#  colorize
#  docker
  git
#  jsontools
#  macports
  osx
#  pip
  python
#  sudo
#  web-search
)

source $ZSH/oh-my-zsh.sh

# zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# conda ------------------------------------------------------------------------

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda activate py3

# vars -------------------------------------------------------------------------

export DEFAULT_USER="$(whoami)"
export OPTS="-o StrictHostKeyChecking=no"

# aliases ----------------------------------------------------------------------

alias scpo="scp $OPTS"
alias ssho="ssh $OPTS"

# apps
alias jn="jupyter notebook"
alias pc="open -na 'PyCharm CE'"
alias rs="open -na Rstudio"

# files
alias bash_profile="atom ~/.bash_profile"
alias zshrc="atom ~/.zshrc"

# web pages
alias gh="open -a 'Google Chrom' https://github.com/dkidney"

# aws
alias acp="aws s3 cp"
alias als="aws s3 ls"

# brew
alias brewup="brew update && brew upgrade && brew cask upgrade && mas upgrade && brew cleanup"

# conda
alias condaup="conda update --all --name py3 && conda update --all --name py2 && conda update --all --name base"
```

-----

#### RStudio

  - Go to Tools \>\> Global Options \>\> Terminal

  - change **Custom shell binary** to `/usr/local/bin/zsh`

  - Go to Tools \>\> Global Options \>\> Appearance

  - change **Editor font:** to `SourceCodeProForPowerline-Regular`
