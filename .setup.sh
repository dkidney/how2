# use the latest 3.11
py_version=$(pyenv install --list | grep -E "^\s*3\.11.\d+$" | tail -1 | sed "s/^[ ]*//")
echo ${py_version}
pyenv install ${py_version}
$(pyenv root)/versions/${py_version}/bin/python -m venv .venv
source .venv/bin/activate
pip install -U pip ipykernel pandas matplotlib scikit-learn biopython
python --version && which python 
