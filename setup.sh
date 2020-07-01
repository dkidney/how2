conda deactivate
conda env remove --name how2
conda create -y --name how2 python=3.8.0
conda activate how2
which python && python --version
pip install --upgrade pip
pip install pandas
pip list