# pyenv

> Simple Python Version Management

* https://github.com/pyenv/pyenv  
* https://realpython.com/intro-to-pyenv/  
 

## setup

```sh
# make sure Xcode Command Line Tools are installed
xcode-select --install

# make sure python build dependencies are installed
brew install openssl readline sqlite3 xz zlib

# install pyenv
brew install pyenv

# put eval "$(pyenv init -)" in your shell configuration file
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc

# restart your shell so the path changes take effect
exec "$SHELL"
```

## manage python installations

```sh
# show latest available python version
pyenv install --list | grep -E "^\s*\d+\.\d+\.\d+$" | tail -1

# install/uninstall a specific version
pyenv install 3.12.5
pyenv uninstall 3.12.5

# show python version(s)
pyenv versions # display all installed python versions
pyenv version # display currently active python version
pyenv which python # display path of currently selected pyenv interpreter

# set a global/local/shell level python version
pyenv global 3.12.5 # uses ~/.pyenv/version
pyenv local 3.12.5 # uses .python-version file
pyenv shell 3.12.5 # uses $PYENV_VERSION
```

## create a virtual environment

```sh
# show current python version
python --version && which python 
#pyenv version && pyenv which python 

# decide the version you want to use
py_version=3.8.19

# alternatively use the latest minor version for a specific major version
py_version=$(pyenv install --list | grep -E "^\s*3\.11.\d+$" | tail -1 | sed "s/^[ ]*//")
echo ${py_version}

# install it and create a virtual env
pyenv install ${py_version} 
$(pyenv root)/versions/${py_version}/bin/python -m venv .venv

# activate and check version
source .venv/bin/activate
python --version && which python

# install packages
pip install -U pip
pip install ipykernel pandas matplotlib scikit-learn
pip list
```

Note that if you have activated an environment then the python version of the environment will not necessarily be the same as the pyenv local version which may or may not have been set - if pyenv local has been set, then the version will be independent of the venv version.

## misc

```sh
# show pyenv root directory
pyenv root

# show subfolder names for installed python versions
ls $(pyenv root)/versions/  

# use explicit path to executable
$(pyenv root)/versions/3.12.5/bin/python --version
```
