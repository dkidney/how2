# pyenv

> Simple Python Version Management

<a name="top"></a>

* [setup](#setup)
* [basics](#basics)
* [pyenv with venv](#pyenv-with-venv)
* [pyenv with virtualvenv](#pyenv-with-virtualenv)

<!-- ## faqs -->

## links

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

<a class="top-link hide" href="#top">↑</a>

## basics

```sh
# show latest available python version
pyenv install --list | grep -E "^\s*(\d+\.\d+\.\d+)$" | tail -1

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

<a class="top-link hide" href="#top">↑</a>

## pyenv with venv 

```sh
# show current python version
python --version && which python 
pyenv version && pyenv which python 

# install required version and set as local version
pyenv install 3.8.19

# set as local version and create virtual env
pyenv local 3.8.19
python -m venv .venv

# alternatively use an explicit python executable
$(pyenv root)/versions/3.8.19/bin/python -m venv .venv

# activate 
source .venv/bin/activate

# recheck 
python --version && which python # this might show pyenv global if no local version
pyenv version && pyenv which python # this should be correct for your new env

# install packages
pip install -U pip
pip install pandas ipykernel matplotlib
pip list
```

## misc

```sh
# show pyenv root directory
pyenv root

# show subfolder names for installed python versions
ls $(pyenv root)/versions/  

# use explicit path to executable
$(pyenv root)/versions/3.12.5/bin/python --version
```

<a class="top-link hide" href="#top">↑</a>
