# pyenv

> Simple Python Version Management

<a name="top"></a>

* [setup](#setup)
* [basics](#basics)

## faqs

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
# display all available versions
pyenv install --list | grep -E "^\s*(\d+\.\d+\.\d+)$" | tail -1

# install/uninstall a specific version
pyenv install 3.7.6
pyenv uninstall 3.7.6

# display all installed python versions
pyenv versions
ls ~/.pyenv/versions/

# display currently active python version
pyenv version

# display path of currently active interpreter
pyenv which python

# set a global/local/shell level python version
pyenv global 3.6.8 # uses ~/.pyenv/version
pyenv local 3.7.6 # uses .python-version file
pyenv shell 3.8.3 # uses $PYENV_VERSION
```

<a class="top-link hide" href="#top">↑</a>

## pyenv-virtualenv 

Manages virtual environments across varying versions of Python.

### setup

```sh
brew install pyenv-virtualenv

# put eval "$(pyenv virtualenv-init -)" in your shell configuration file
echo -e 'if which pyenv-virtualenv-init > /dev/null; then\n  eval "$(pyenv virtualenv-init -)"\nfi' >> ~/.zshrc

# restart your shell so the path changes take effect
exec "$SHELL"
```

### usage 

`pyenv virtualenv <python_version> <environment_name>`

```sh
# create an environment
pyenv virtualenv 3.6.8 myproject

# activate an environment
pyenv local myproject

# deactivate an active environment
pyenv deactivate
```

<a class="top-link hide" href="#top">↑</a>
