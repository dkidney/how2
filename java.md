java
================

  - [weblinks](#weblinks)
  - [install](#install)
  - [R](#r)

-----

#### weblinks

-----

#### install

``` sh
# install
brew tap caskroom/versions
brew cask install java8

# check version
java -version
which java
```

-----

#### R

``` r
install.packages("rJava")
```

``` sh
# reconfigue Java
R CMD javareconf # need to restart RStudio after this has run
```
