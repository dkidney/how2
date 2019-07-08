git
================

  - [Links](#links)
  - [Installation](#installation)
  - [Commands](#commands)
      - [git add](#git-add)
      - [git annotate](#git-annotate)
      - [git branch](#git-branch)
      - [git checkout](#git-checkout)
      - [git clone](#git-clone)
      - [git commit](#git-commit)
      - [git config](#git-config)
      - [git diff](#git-diff)
      - [git fetch](#git-fetch)
      - [git init](#git-init)
      - [git log](#git-log)
      - [git merge](#git-merge)
      - [git pull](#git-pull)
      - [git push](#git-push)
      - [git rebase](#git-rebase)
      - [git reset](#git-reset)
      - [git remote](#git-remote)
      - [git revert](#git-revert)
      - [git show](#git-show)
      - [git stash](#git-stash)
      - [git status](#git-status)
  - [Terminology](#terminology)
      - [blob](#blob)
      - [branch](#branch)
      - [commit](#commit-term)
      - [hash](#hash)
      - [HEAD](#head)
      - [origin](#origin)
      - [remote](#remote)

<!-- ##### {#top} -->

-----

### Links

<https://git-scm.com/docs/gitglossary> <https://git-scm.com/docs>  
<https://git-scm.com/book/en/v2>

<https://help.github.com/en/articles/github-glossary>  
<https://github.github.com/training-kit/downloads/github-git-cheat-sheet.pdf>

<https://www.atlassian.com/git/glossary/terminology>  
<https://www.atlassian.com/git/tutorials>

<https://www.git-tower.com/learn/git/ebook/en/command-line/>

<https://happygitwithr.com/>

-----

### Installation

``` sh
# install 
brew install git
# check installation
git --version
which git
```

-----

### Commands

#### git add

``` sh
# add a file to the staging area
git add path/to/file
```

<!-- [Back to top](#top) -->

#### git annotate

A bit like [git log](#git-log) but shows more information.

``` sh
git annotate file
```

<!-- [Back to top](#top) -->

#### git branch

``` sh
# list all the branches in the repo (* indicates current branch)
git branch

# delete a local branch
git branch -d branch-name # --delete
git branch -D branch-name # --delete --force

# ???
git branch -va
```

(see [git push](#git-push) for deleting remote branches)

<!-- [Back to top](#top) -->

#### git checkout

``` sh
# discard unstaged changes to a particular file
git checkout -- path/to/file

# discard unstaged changes to all files in a particular directory
git checkout -- path/to/dir

# discard unstaged changes to all files in the current directory
git checkout -- .

# replace the current version of a file with the version in commit xxxxx
git checkout xxxxx path/to/file

# switch to a branch
git checkout branch-name

# create a branch then switch to it in one step
# and setup local branch to track remote branch from origin
git checkout -b branch-name
git push -u origin branch-name

# create a new branch from an old revision of an exising project 
# (a safer alternative to git reset)
git checkout -b old-project-state xxxxxxxx
git push -u origin old-project-state

# resolve merge conflicts by chosing one of the two versions
git checkout --ours path/to/file
git checkout --theirs path/to/file
```

<!-- [Back to top](#top) -->

#### git clone

Create a copy of an existing repo.

``` sh
# clone using https
git clone https://github.com/dkidney/how2.git

# clone using ssh
git clone git@github.com:dkidney/how2.git

# clone a repo on the local file system
git clone path/to/existing/project

# clone a repo on the local file system and specify a new project name
git clone path/to/existing/project new-project-name
```

<!-- [Back to top](#top) -->

#### git commit

``` sh
# save the changes in the staging area
git commit

# use a commit message
git commit -m "infrmtv mssg"

# change the commit message
git commit --amend - m "informative message"
```

<!-- [Back to top](#top) -->

#### git config

View or change default settings.

  - `--system` : settings for every user
  - `--global` : settings for current user
  - `--local` : settings for current project

<!-- end list -->

``` sh
# view all settings
git config --list --system
git config --list --global # overrides system
git config --list --local # overrides global

# view a particular setting
git config --system user.name
git config --global user.name
git config --local user.name

# change a particular setting
git config --global user.name dkidney
git config --global http.postBuffer 524288000
```

<!-- [Back to top](#top) -->

#### git diff

Compare differences between revisions.

``` sh
# show all unstaged changes in working copy files
git diff

# show differences between staged files and the last commit
git diff --staged

# show differences between working copy files and those in a particular revision
# e.g the most recent commit
git diff -r HEAD

# show differences between a particular working copy file and that in a particular revision
# e.g the most recent commit
git diff -r HEAD path/to/file

# show differences between two branches
git diff master..contact-form

# show differences between two commits
git diff 0023cdd..fcd6199

# show differences between the previous commit and the one before that
git diff HEAD~1..HEAD~2

# general pattern : show differences between revision 1 and revision 2
git diff revision-1..revision-2

# general pattern : show differences between branch 1 and branch 2
git diff branch-1..branch-2
```

<!-- [Back to top](#top) -->

#### git fetch

``` sh
git fetch
```

<!-- [Back to top](#top) -->

#### git init

Create a new repo.

``` sh
# convert existing project into a repo (while in the project root directory)
git init

# convert existing project into a repo (from anywhere)
git init /path/to/project

# create a repo for a new project
git init project-name
```

<!-- [Back to top](#top) -->

#### git log

``` sh
# view a project's history
git log

# view a history for a particular file or directory
git log path

# view a the last three items in the history for a particular file or directory
git log -3 path
```

<!-- [Back to top](#top) -->

#### git merge

  - integrates changes from one branch into another

<!-- end list -->

``` sh
git checkout master
git pull
git merge feature-branch
git push

# or in one step?
git merge source destination

# undo the merge 
git merge --abort
```

See also: [git rebase](#git-rebase)

<!-- [Back to top](#top) -->

#### git pull

``` sh
# get changes in a particular branch from a particular repo (repo identified by remote)
git pull remote-name branch-name

# e.g.
git pull origin master
```

<!-- [Back to top](#top) -->

#### git push

``` sh
# apply changes to a particular branch from a particular repo (repo identified by remote)
git push remote-name branch-name

# e.g.
git push origin master

# delete a remote branch
git push origin --delete branch-name
```

(see [git branch](#git-branch) for deleting local branches)

<!-- [Back to top](#top) -->

#### git rebase

  - integrates changes from one branch into another  
  - rewrites your commit history
  - golden rule: never rebase published commits

<!-- end list -->

``` sh
```

See also: [git merge](#git-merge)

<!-- [Back to top](#top) -->

#### git reset

  - restores the project at any previous commit/revision  
  - undoes all the commits after that revision  
  - `soft` (default) preserves changes in undone revisions as unstaged
    changes
  - `hard` deletes changes in undone revisions

<!-- end list -->

``` sh
# unstage all unstaged files
git reset HEAD

# unstage a particular unstaged file
git reset HEAD path/to/file

# unstage any staged files in a particular directory
git reset HEAD path/to/dir

# undo the last commit - preserving changes in undone revisions
git reset --soft HEAD~1

# undo the last commit - DELETING changes in undone revisions
git reset --hard HEAD~1
```

See [git checkout](#git-checkout) for an alternative (and safer) method.

<!-- [Back to top](#top) -->

#### git remote

``` sh
# list the names of a repos remotes
git remote

# list more information about a repos remotes (v : verbose)
git remote -v

# add a remote
git remote add remote-name URL

# remove an existing remote
git remote rm remote-name
```

<!-- [Back to top](#top) -->

#### git revert

  - undoes the effect of a particular commit
  - but doesn’t undo the effects of commits after that one
  - doesn’t actually delete any commits
  - makes a **new** commit to create the change

<!-- end list -->

``` sh
git revert xxxxxxxx
```

See also: [git reset](#git-reset)

<!-- [Back to top](#top) -->

#### git show

View the details of a specific commit

``` sh
# show a particular commit
git show xxxxxxxx

# show the most recen commit
git show HEAD~1
```

<!-- [Back to top](#top) -->

#### git stash

  - temporarily store uncommitted local changes

<!-- end list -->

``` sh
git stash 
git pull
git stash pop
```

#### git status

Shows you:

  - which files are in the staging area  
  - which files have changes that haven’t yet been staged

<!-- end list -->

``` sh
git status
```

<!-- [Back to top](#top) -->

-----

### Terminology

#### blob

  - short for *binary large object* - an SQL database term for “may
    contain data of any kind”

#### branch

  - an independent line of development  
  - by default, every Git repository has a branch called master

#### commit

  - contains metadata such as the author, the commit message, and the
    time the commit happened  
  - each commit has a tree, which tracks the names and locations in the
    repository when that commit happened  
  - for each of the files listed in the tree, there is a [blob](#blob)
    which contains a compressed snapshot of the contents of the file
    when the commit happened

#### hash

  - a unique identifier associated with a commit  
  - generated by running the changes through a pseudo-random number
    generator (ash function)  
  - normally written as a 40-character hexadecimal string  
  - most of the time you only have to give Git the first 6 or 8
    characters of the hash  
  - they enable Git to share data efficiently between repositories - if
    two commits contain the same files and have the same ancestors, they
    will have the same hash

#### HEAD

  - a special label that refers to the most recent commit  
  - `HEAD~1` refers to the commit before `HEAD`  
  - `HEAD~2` refers to the commit before `HEAD~1`

#### origin

See [remote](#remote)

#### remote

  - a record of the original repo when a repo was cloned (e.g.as a copy
    on the website)  
  - when you clone a repo, Git creates a remote called **origin** that
    points to the original repo

<!-- [Back to top](#top) -->

-----

``` sh
# check commit history
git log

# check status
git status

# checkout onto a branch
git checkout [branch-name]

# clone a repo via https
git clone https://github.com/USERNAME/REPOSITORY.git

# Check it was cloned successfully:
git remote --verbose

# commit a change
git add foo.txt
git commit --message "A commit message"

# make a branch
git branch [branch-name]
git checkout [branch-name]

# merge a branch
# E.g. merge into master:
git checkout master
git merge [branch-name]

# osxkeychain helper
git credential-osxkeychain

# Tell Git to use osxkeychain helper:
git config --global credential.helper osxkeychain

# stash changes
# E.g. when pulling conflicting changes:
git stash
git pull
git stash pop
```
