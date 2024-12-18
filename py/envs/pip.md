# pip

> 'preferred installer program' 

> the standard package manager for python

## contents

* [pip install](#pip-install)
* [pip freeze](#pip-freeze)

## links

* https://realpython.com/what-is-pip/  
* https://www.datacamp.com/community/tutorials/python-developer-set-up

## setup

### install

If you have installed python you should alredy have `pip` (see this link if you dont have it: https://pip.pypa.io/en/stable/installing/)

### check version

```{sh}
which pip
pip --version
```

### upgrade

```sh
pip install --upgrade pip
```

### help

```sh
pip help
```

## pip install

```sh
pip install 'PackageName'
pip install 'PackageName==1.4'
pip install --upgrade PackageName 
pip uninstall PackageName
```

## pip freeze

```sh
# declare the dependencies in a requirements.txt file
pip freeze

# install dependencies from a requirements.txt file
pip install -r requirements.txt
```

