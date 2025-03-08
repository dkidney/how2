# vscode

https://www.datacamp.com/tutorial/setting-up-vscode-python

## keyboard shortcuts

shortcut | action
-------- | ------ 
`CMD + N` | create a new file  
`CMD + SHIFT + X` | open extension panel
`CMD + SHIFT + V` | preview markdown

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


