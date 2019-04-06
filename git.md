git
================

-   [check which version](#check-which-version)
-   [check commit history](#check-commit-history)
-   [check status](#check-status)
-   [checkout onto a branch](#checkout-onto-a-branch)
-   [clone a repo via https](#clone-a-repo-via-https)
-   [commit a change](#commit-a-change)
-   [install Git](#install-git)
-   [make a branch](#make-a-branch)
-   [merge a branch](#merge-a-branch)
-   [osxkeychain helper](#osxkeychain-helper)
-   [stash changes](#stash-changes)

#### check which version

``` sh
git --version
```

#### check commit history

``` sh
git log
```

#### check status

``` sh
git status
```

#### checkout onto a branch

``` sh
git checkout [branch-name]
```

#### clone a repo via https

``` sh
git clone https://github.com/USERNAME/REPOSITORY.git
```

Check it was cloned successfully:

``` sh
git remote --verbose
```

#### commit a change

``` sh
git add foo.txt
git commit --message "A commit message"
```

#### install Git

``` sh
brew install git
```

#### make a branch

``` sh
git branch [branch-name]
git checkout [branch-name]
```

#### merge a branch

Merge into master:

``` sh
git checkout master
git merge [branch-name]
```

#### osxkeychain helper

Check if the osxkeychain is already installed:

``` sh
git credential-osxkeychain
```

Tell Git to use osxkeychain helper:

``` sh
git config --global credential.helper osxkeychain
```

#### stash changes

``` sh
git stash
git pop
```
