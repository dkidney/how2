# jupyterlab

> an open-source web application that allows you to create and share documents that contain live code, equations, visualizations and narrative text

> jupyter stands for julia, python, and r

## links

* https://jupyter.org/  
* https://www.datacamp.com/tutorial/installing-jupyter-notebook
* https://www.datacamp.com/community/tutorials/tutorial-jupyter-notebook  

## setup

### install

Several installation options e.g.

```sh
pip install jupyterlab
#brew install jupyterlab
#conda install -c conda-forge jupyterlab
```

### launch

```sh
jupyter lab
```

## kernels

The ipython kernel is the python execution backend for jupyter

```sh
# list all kernels
jupyter kernelspec list

# e.g. add a new python 2 kernel using an existing conda environment
conda activate py2
conda install ipykernel
conda install jupyter # I had to use pip instead to get this to work for python 2.
python -m ipykernel install --user --name py2 --display-name "py2" # manually register it

# e.g. add a new python 2 kernel using pip
python2 -m pip --version # need pip version >= 9
python2 -m pip install ipykernel
python2 -m ipykernel install --user

# delete a kernel
jupyter kernelspec uninstall unwanted-kernel
```

See which python you are using - i.e. the python associated with the kernel

```python
import sys
print(sys.executable)
print(sys.version)
```

See which python *jupyter notebook was launched from* - this is **not necessarily** the same as the python associated with the kernel (unless the environment you launched from is also the environment associated with the kernel)

```python
# python 3
import subprocess
print(subprocess.getoutput("which python"))
```

```python
# python 2
import commands
print(commands.getoutput("which python"))
```

Things I've noticed:

* I've added two kernels - `py2` and `py3`

  * if I launch jupyter from `py2` then the available kernels are `py2`, `py3` and `Python 2`, where `Python 2` is identical to `py2`
  
  * if I launch jupyter from `py3` then the available kernels are `py2`, `py3` and `Python 3`, where `Python 3` is identical to `py3`

  * if I launch jupyter from `base` then the available kernels are `py2`, `py3` and `Python 3`, where `Python 3` is identical to `base`

* so I think that whichever python environment you launch from gets assigned to a default kernel - either `Python 2` or `Python 3` - which exists is in addition to any kernels you have added manually.

### r

*TODO*

```sh
# install the R essentials in your current environment
conda install -c r r-essentials
```

this includes [dplyr](https://dkidney.github.io/how2/r_tidyverse.html#dplyr), [shiny](https://dkidney.github.io/how2/r_shiny.html), [ggplot2](https://dkidney.github.io/how2/r_tidyverse.html#ggplot2), [tidyr](https://dkidney.github.io/how2/r_tidyverse.html#tidyr), [caret](https://dkidney.github.io/how2/r_caret.html) and nnet

### julia 

*TODO*

## magic

* https://www.dataquest.io/blog/jupyter-notebook-tips-tricks-shortcuts/  

```python
# see which magic commands are available in your interpreter
%lsmagic
```

examples:

command | description
------------- | -------------
`%quickref` | show a quick reference sheet for IPython
`%matplotlib inline` | 
`%save` | 
`%clear` | 
`%debug` | 
`%time` | 
`%timeit` | 
`%pdb` | debug
`%prun` | performance run
`%writefile` | saves contents of a cell to an external file
`%pycat` | shows syntax highlighted contents of an external file
`%who` | list variables of global scope
`%store` | pass variables between notebooks
`%load` | insert code from external script
`%run` | execute python code
`%env` | set environment variables

* use `%%` for multiline expressions  
* use `?` before the command (or function) to get help  

### shell commands

* use `!` before the command

```python
!ls
!cd
!pwd
```

### mixing languages

```sh
pip install ipython-sql
pip install cython
pip install rpy2
```

```python
%load_ext sql
%load_ext cython
%load_ext rpy2.ipython
```

## shortcuts

* https://www.cheatography.com/weidadeyue/cheat-sheets/jupyter-notebook/  
* https://towardsdatascience.com/jypyter-notebook-shortcuts-bf0101a98330  
* https://www.dataquest.io/blog/jupyter-notebook-tips-tricks-shortcuts/  
* http://maxmelnick.com/2016/04/19/python-beginner-tips-and-tricks.html  

shortcut  | action
------------- | -------------
shift + enter | run cell, select below 

## latex

wrap latex code (e.g. equations) between double dollar signs `$$`

## docker

to run the official Jupyter Notebook image:

```sh
docker run --rm -it -p 8888:8888 -v "$(pwd):/notebooks" jupyter/notebook 
```

other images are available, e.g. 

* `jupyter/datascience-notebook`

## share

```sh
jupyter nbconvert --to html Untitled4.ipynb
```