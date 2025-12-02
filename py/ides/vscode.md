# vscode

https://www.datacamp.com/tutorial/setting-up-vscode-python

## keyboard shortcuts

### general

shortcut        | action
--------------- | ------------ 
CMD + K + S     | open keyboard shortcuts
CMD + N         | create a new file  
SHIFT + CMD + V | markdown open preview
SHIFT + CMD + X | open extension panel
CTRL + `        | open / close terminal pane

### notebooks

shortcut      | action
------------- | ------ 
CTRL + ENTER  | run cell
SHIFT + ENTER | run cell and jump to next cell 

### customise

new shortcut        | action
------------------- | ------ 
SHIFT + CMD + C     | toggle line comment (masks open new external terminal)
SHIFT + ENTER       | notebook execute cell (default = CTRL + ENTER)
CTRL + ENTER        | notebook execute notebook cell and select below (default = SHIFT + ENTER)
SHIFT + CMD + ENTER | notebook execute above cells
SHIFT + CMD + V     | markdown open preview to the side (masks markdown open preview)

## useful extensions

* python

* Indent-rainbow

* autoDocstring


## python environments

I found the only way to get VSCode to recognise python virtual environments was to put them in `.venv` e.g.

```sh
#py_version=$(pyenv install --list | grep -E "^\s*(\d+\.\d+\.\d+)$" | tail -1)
py_version=3.8.19
echo ${py_version}
pyenv install ${py_version}
$(pyenv root)/versions/${py_version}/bin/python -m venv .venv
source .venv/bin/activate
pip install -U pip ipykernel pandas matplotlib
```


