# vscode

## python environments

I found the only way to get VSCode to recognise python virtual environments was to put them in `.venv` e.g.

```sh
py_version=3.8.19
pyenv install ${py_version}
$(pyenv root)/versions/${py_version}/bin/python -m venv .venv
source .venv/bin/activate
pip install -U pip ipykernel pandas matplotlib
```