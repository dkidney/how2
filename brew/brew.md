Homebrew
================

> The missing package manager for macOS (or Linux)

<https://brew.sh> (homepage)  
<https://github.com/Homebrew/brew> (github repo)  
<https://docs.brew.sh/Formula-Cookbook#homebrew-terminology> (glossary)

``` sh
# install command line tools
xcode-select --install

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# update your bash profile
echo '' >> ~/.bash_profile
echo '# Homebrew' >> ~/.bash_profile
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bash_profile
```

-----

#### brew

``` sh
# print an overiview of available commands
brew help

# check homebrew version
brew --version

# update homebrew
brew update

# install a given formula
brew install awscli
brew install gcc
brew install git
brew install htop
brew install jenv
brew install jupyter
brew install libxml2
brew install mas 
brew install p7zip
brew install pyenv
brew install r
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

<https://formulae.brew.sh/formula> (list of all available formulae)

-----

#### tap

Use **brew tap user/repo** to add a third-party git repo of formulae to
the list of formulae that brew tracks

``` sh
brew tap homebrew/bundle
brew tap homebrew/cask
brew tap homebrew/cask-versions
brew tap homebrew/core
brew tap mas-cli/tap
```

-----

#### cask

Homebrew Cask extends Homebrew to allow installation and management of
GUI macOS applications.

``` sh
# list available commands
brew cask

# install a given Cask - use --force if its already in /Applications
brew cask install adobe-acrobat-reader --force
brew cask install adobe-photoshop-lightroom --force
brew cask install anaconda --force
brew cask install atom --force
brew cask install bbc-iplayer-downloads --force
brew cask install caffeine --force
brew cask install docker --force
brew cask install dropbox --force
brew cask install google-chrome --force
brew cask install iterm2 --force
brew cask install java --force
brew cask install mactex-no-gui --force
brew cask install rstudio --force
brew cask install sequel-pro --force
brew cask install skype --force
brew cask install slack --force
brew cask install the-unarchiver --force
brew cask install tunnelblick --force
brew cask install vitualbox --force
brew cask install xquartz --force

# list installed Casks
brew cask list --versions

# display information about a given Cask
brew cask info atom

# list the outdated installed Casks
brew cask outdated

# upgrade a particular cask
brew cask upgrade atom

# upgrades all outdated casks
brew cask upgrade
```

<https://formulae.brew.sh/cask/>  
<https://github.com/Homebrew/homebrew-cask>

-----

#### mas

``` sh
# list all apps installed via the app strore
mas list

# search for an app in the app store
mas search Xcode

# install an app from the app store
mas install 497799835 # Xcode (10.2.1)
mas install 408981434 # iMovie (10.1.12)
409201541  Pages                                                         (8.0)
 409203825  Numbers          (6.0)
 
```

-----

#### Brewfile

`homebrew-bundle` is an extension of `homebrew`.

``` sh
# generate a Brewfile listing all of the installed packages and apps
brew bundle dump --force --file=./Brewfile
```

Example Brewfile:

``` sh
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-versions"
tap "homebrew/core"
tap "mas-cli/tap"
brew "awscli"
brew "gcc"
brew "git"
brew "htop"
brew "jenv"
brew "keychain"
brew "libxml2"
brew "mas"
brew "wget"
brew "zsh"
brew "zsh-autosuggestions"
brew "zsh-completions"
brew "zsh-syntax-highlighting"
cask "adobe-acrobat-reader"
cask "anaconda"
cask "atom"
cask "bbc-iplayer-downloads"
cask "caffeine"
cask "docker"
cask "dropbox"
cask "flux"
cask "iterm2"
cask "mactex-no-gui"
cask "rstudio"
cask "skype"
cask "slack"
cask "the-unarchiver"
cask "virtualbox"
cask "xquartz"
mas "iMovie", id: 408981434
mas "Keynote", id: 409183694
mas "Numbers", id: 409203825
mas "Pages", id: 409201541
mas "Xcode", id: 497799835
```

``` sh
# install everything in Brewfile (run in dir containing Brewfile)
brew bundle
```
