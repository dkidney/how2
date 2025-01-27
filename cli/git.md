# git

<a name="top"></a>

* [git branch](#git-branch)
* [git checkout](#git-checkout)
* [git commit](#git-commit)  
* [git merge](#git-merge)  
* [git rebase](#git-rebase)  
* [git reset](#git-reset)  
* [git restore](#git-restore)  
* [git revert](#git-revert)  
* [.gitignore](#gitignore)  

## faqs

* [create a new branch](#create-a-new-branch)
* [delete a branch](#delete-a-branch)
* [unstage multiple files](#unstage-multiple-files)
* [undo an unpushed commit](#undo-an-unpushed-commit)
* [undo a pushed commit](#undo-a-pushed-commit)

## links

https://www.atlassian.com/git/tutorials

## terminology 

* **HEAD** - the snapshot of your last commit on the current branch, includes commits that haven't been pushed  

* **index** - i.e.the staging area = your proposed next commit

* **working directory** - aka **working tree** = a sandbox, where you can try changes out before committing them to your staging area (index)

<a class="top-link hide" href="#top">↑</a>

## git branch

### list all branches

```sh
git branch -a
q
```

### delete a branch

```sh
branch_to_delete=my_old_branch
git branch -d ${branch_to_delete} # delete on local
# git branch -D ${branch_to_delete} # force delete locally
git push origin -d ${branch_to_delete} # delete on remote
```

## git checkout

### create a new branch

```sh
new_branch=my_new_branch
base_branch=origin/main # for example
git checkout -b ${new_branch} ${base_branch}
git push -u origin ${new_branch}
```

## git commit

```sh
# specific files
git add file1 file2 
git commit -m "informative message"

# all files
git add --all
git commit -m "informative message"

# all files shortchut
git commit -am "informative message"
```

<a class="top-link hide" href="#top">↑</a>

## git merge

* integrates changes from one branch into another (see also [git rebase](#git-rebase))
* does not re-write project history - creates a new “merge commit” in the feature branch
* can result in a messy project history

```sh
receiving_branch=main            # the branch that will be update via the merge
merging_branch=my_feature_branch # the branch that will merge into the receiving branch

# update local copies of both branches
git checkout ${merging_branch} && git fetch # you don't need to do this for origin/... branches
git checkout ${receiving_branch} && git fetch

# checkout the receiving branch and merge the other branch into it
git checkout ${receiving_branch}
git merge ${merging_branch}

# push changes 
git add --all 
git commit -m 'merged ${merging_branch}'
git push

# optionally delete the merging branch
git branch -d ${merging_branch} # delete on local
git push origin -d ${merging_branch} # delete on remote
```

### conflicts 

* conflicts are indicated by the conflict marker `<<<<<<<`

<a class="top-link hide" href="#top">↑</a>

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

## git reset

* undo local changes - staged or unstaged
* delete (unpushed) commits
* reset to a different commit

### unstage multiple files
```sh
git reset         # unstage all files but keep changes
git reset --mixed # unstage all files but keep changes
git reset --hard  # unstage all files and DISCARD changes
```

### undo an unpushed commit

```sh
# undo last unpushed commit
git reset HEAD~1         # don't unstage changes
git reset --soft  HEAD~1 # don't unstage changes
git reset --mixed HEAD~1 # unstage but don't delete changes
git reset --hard  HEAD~1 # unstage and delete changes
```

### reset to a specific commit

```sh
git reset <commit hash> # reset to a specific commit (but don't unstage changes)
```

### reset to the remote state

```sh
git fetch origin # fetch latest changes on the remote branch
git reset origin/HEAD # reset local to the remote state (but don't unstage changes)
```

<a class="top-link hide" href="#top">↑</a>

## git restore

### undo unstaged changes
```sh
git restore <file>           # undo unstaged changes single file   
git restore <file1> <file2>  # undo unstaged changes multiple files
```

### unstage a single file
```sh
git restore --staged <file>  # unstage single file (but keep changes)
```

### amend an unpushed commit

### undo a pushed commit

<a class="top-link hide" href="#top">↑</a>

## git revert

* undo commits by creating a new 'reverting commit`

<a class="top-link hide" href="#top">↑</a>

## .gitignore

<a class="top-link hide" href="#top">↑</a>

