# homebrew

> the missing package manager for macOS (or Linux)

* [brew](#brew)
* [tap](#tap)
* [cask](#cask)

## links

* https://brew.sh (homepage)  
* https://github.com/Homebrew/brew (github repo)  
* https://docs.brew.sh/Formula-Cookbook#homebrew-terminology (glossary)  
* https://www.datacamp.com/community/tutorials/homebrew-install-use  (tutorial)

## setup

### install

```sh
# install command line tools
xcode-select --install

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# update your bash profile
echo '' >> ~/.bash_profile
echo '# Homebrew' >> ~/.bash_profile
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bash_profile
```

## brew

* https://formulae.brew.sh/formula/

```sh
# print an overiview of available commands
brew help

# check homebrew version
brew --version

# update homebrew
brew update

# search for formulae/casks
brew search aws

# install a given formula
brew install apache-spark
brew install awscli
brew install docker
brew install gcc
brew install ghostscript
brew install git
brew install htop
brew install hugo
brew install jenv
brew install jupyter
brew install libxml2
brew install mas 
brew install p7zip
brew install pandoc
brew install pyenv
brew install r
brew install tree
brew install wget
brew install zsh
brew install zsh-autosuggestions
brew install zsh-completions
brew install zsh-syntax-highlighting

# list versions of all installed formulae
brew list --versions

# list outdated formulae
brew outdated

# upgrade a specific formula
brew upgrade git

# upgrade all outdated formulae
brew upgrade

# clean up files/downloads for out-of-date app versions
brew cleanup 

# verify that the installation was successful
brew doctor 

# miscellaneous
man brew # list the commands and options that can be used with brew
```

https://formulae.brew.sh/formula (list of all available formulae)

## tap

Use **brew tap user/repo** to add a third-party git repo of formulae to the list of formulae that brew tracks

```sh
brew tap homebrew/bundle
brew tap homebrew/cask
brew tap homebrew/cask-versions
brew tap homebrew/core
brew tap mas-cli/tap
```

## cask

* https://formulae.brew.sh/cask/

Homebrew Cask extends Homebrew to allow installation and management of
macOS native apps (e.g those with GUIs).

```sh
# list available commands
brew cask

# install a given Cask - use --force if its already in /Applications
brew cask install adobe-acrobat-reader
brew cask install adobe-photoshop-lightroom
brew cask install anaconda
brew cask install atom
#brew cask install basictex
brew cask install bbc-iplayer-downloads
brew cask install caffeine
brew cask install chromedriver
brew cask install cyberduck
brew cask install docker
brew cask install dropbox
brew cask install flash-player # adobe flash player
brew cask install google-backup-and-sync
brew cask install google-chrome
brew cask install google-drive-file-stream
brew cask install google-hangouts
brew cask install iterm2
brew cask install java
#brew cask install mactex
brew cask install mactex-no-gui
brew cask install openoffice
brew cask install postman
brew cask install pycharm-ce
brew cask install rstudio
brew cask install sequel-pro
brew cask install skype
brew cask install slack
brew cask install spotify
brew cask install stellarium
#brew cask install tex-live-utility
brew cask install the-unarchiver
brew cask install tunnelblick
brew cask install typora 
brew cask install vitualbox
brew cask install xquartz

# list installed Casks
brew cask list --versions

# display information about a given Cask
brew cask info atom

# list the outdated installed Casks
brew cask outdated

# upgrade a particular cask
brew cask upgrade atom

# upgrades all outdated casks
brew cask upgrade --greedy
```

https://formulae.brew.sh/cask/  
https://github.com/Homebrew/homebrew-cask

## mas

* https://github.com/mas-cli/mas

```sh
# list all apps installed via the app strore
mas list

# search for an app in the app store
mas search Xcode
mas search iMovie
mas search Keynote
mas search Numbers
mas search Pages

# install an app from the app store
mas install 497799835 # Xcode
mas install 408981434 # iMovie
<<<<<<< Updated upstream
mas install 409183694 # Keynote 
mas install 409203825 # Numbers
mas install 409201541 # Pages

# upgrade an app from the app store
mas upgrade
mas upgrade 497799835 # Xcode
mas upgrade 408981434 # iMovie
mas upgrade 409183694 # Keynote 
mas upgrade 409203825 # Numbers
mas upgrade 409201541 # Pages
```

## Brewfile

`homebrew-bundle` is an extension of `homebrew` to describe
dependencies.

```{sh, eval=FALSE}
# generate a Brewfile listing all of the installed packages and apps
brew bundle dump --force --file=Brewfile
```

Example Brewfile:
```{r, opts.label="cat_file"}
cat_file("Brewfile")
```

```sh
# install everything in Brewfile (run in dir containing Brewfile)
brew bundle
```

