# git

<a name="top"></a>

* [git commit](#git-commit)  
* [git merge](#git-merge)  
* [git rebase](#git-rebase)  
* [git reset](#git-reset)  
* [git restore](#git-restore)  
* [git revert](#git-revert)  
* [.gitignore](#gitignore)  

**************************************************

## links

https://www.atlassian.com/git/tutorials

**************************************************

## terminology 

* **HEAD** - the snapshot of your last commit on the current branch, includes commits that haven't been pushed  

* **index** - i.e.the staging area = your proposed next commit

* **working directory** - aka **working tree** = a sandbox, where you can try changes out before committing them to your staging area (index)

<a class="top-link hide" href="#top">↑</a>

**************************************************

## git commit

```sh
git commit -m "informative message"    # do this after files have been staged

git commit -a -m "informative message" # stages all files first 
```

<a class="top-link hide" href="#top">↑</a>

**************************************************

## git merge

* integrates changes from one branch into another (see also [git rebase](#git-rebase))
* does not re-write project history - creates a new “merge commit” in the feature branch
* can result in a messy project history

```sh
git checkout feature
git merge origin/main

git merge feature origin/main  # combines the two steps above into a single command
```

### conflicts 

* conflicts are indicated by the conflict marker `<<<<<<<`

<a class="top-link hide" href="#top">↑</a>

**************************************************

## git rebase

* integrates changes from one branch into another (see also [git merge](#git-merge))
* re-writes the project history - creates brand new commits for each commit in the original branch
* results in a much cleaner project history
* golden rule: **never use it on public branches** - e.g. never rebase the `main` branch onto your feature branch and never rebase a feature branch if other people are working on it as well
* usually a good idea to clean up your code with an interactive rebase before submitting your merge/pull request

### standard use 

E.g. you are checked out on `feature` which is branched off of `main`, but main has since changed - you can change the base of `feature` to be on the tip of `main`:

```sh
git checkout feature
git rebase origin/main

git rebase --abort  # undo the rebase
```

### interactive use 

* gives you the opportunity to alter commits as they are moved to the new branch.

```sh
git checkout feature
git rebase -i origin/main
```

### advanced use 

E.g. if `featureA` is branched off of `main`, and `featureB` is branched off of `featureA`, then you can rebase `featureB` so that it's base is the tip of `main`:

```sh
git rebase --onto origin/main featureA featureB
```

<a class="top-link hide" href="#top">↑</a>

**************************************************

## git reset

* undo local changes: unstaged, staged or committed (but not pushed)  
* see also [git restore](#git-restore)  

### undo all unstaged / staged changes {-#undoallunstagedstaged}

```sh
git reset         # unstage all files but keep changes
git reset --hard  # unstage all files and undo changes
```

### undo committed changes {-#undocommit}

* deletes commits (unlike [git revert](#gitrevert) which makes a new commit)

```sh
git reset HEAD~1         # undo the last commit but don't unstage files or undo changes
git reset --soft HEAD~1  # undo the last commit but don't unstage files or undo changes
git reset --mixed HEAD~1 # undo the last commit and unstage files but don't undo changes
git reset --hard HEAD~1  # undo the last commit, unstage all files and undo all changes
```

Other ways to specify the previous state:  
* `origin/HEAD` last commit on the remote  
* `<commit hash>` specific commit  

<a class="top-link hide" href="#top">↑</a>

**************************************************

## git restore

* see also [git reset](#git-reset)  
* see also [git revert](#git-revert)  

#### undo unstaged / staged changes to specific files {-#undofileunstagedstaged}

```sh
git restore --staged file1  # unstage file1 but keep changes
git restore file1           # unstage file1 and undo changes
```

<a class="top-link hide" href="#top">↑</a>

**************************************************

## git revert

* undo commits by creating a new 'reverting commit`
* unlike [git reset](#gitreset) which deletes commits

<a class="top-link hide" href="#top">↑</a>

**************************************************

## .gitignore

<a class="top-link hide" href="#top">↑</a>

