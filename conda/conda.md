conda
================

> Conda is an open source package management system and environment
> management
system

<https://docs.conda.io>

<https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf>

-----

#### installation

``` sh
# install
brew cask install anaconda

# update your bash/zsh profile
conda init bash
conda init zsh

# check installation
conda --version
which conda
conda info

# update
conda update conda

# help
conda --help
```

-----

#### python

``` sh
# check installation
python --version
which python

# list versions that are available to install
conda search python
```

-----

#### environments

``` sh
# list the current environment
echo $CONDA_PREFIX

# get list of of all my environments
conda info --envs
conda env list

# create new environments
conda create --name dev2 python=2.7
conda create --name dev3 python=3.6

# activate an environment
conda activate dev3
python --version
which python

# deactivate an environment
conda deactivate
python --version
which python

# add a line to .zshrc/.bash_profile to use a particular env by default (if you want to)
echo 'conda activate dev3' >> ~/.zshrc
echo 'conda activate dev3' >> ~/.bash_profile
```

-----

#### packages

``` sh
# list all packages and versions installed in active environment
conda list

# install a package to the active environment
conda install numpy matplotlib pandas scipy scikit-learn

# install a package to a named environment
conda install --name dev2 scipy

# update a package in the active environment
conda update numpy

# update all packages in the active environment
conda update --all

# update all packages in a named environment
conda update --all --name dev2
```

-----

#### channels

``` sh
# allow installation of conda-forge packages
conda config --add channels conda-forge
```
