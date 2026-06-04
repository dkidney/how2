# conda

> a cross-platform package and environment manager

## contents

* [create a new env](#create-a-new-env)

## links

* https://realpython.com/ref/tools/conda/

## setup

### install

install miniconda: https://www.anaconda.com/docs/getting-started/miniconda/install/overview

or install anaconda: https://www.anaconda.com/docs/getting-started/anaconda/install/overview

### check version

```sh
conda --version
```

## environments

### create a new env

Create a named env in a specific location

```sh
conda create -p ./.venv python=3.12
conda activate .venv 
python --version 
```

Create a named env in conda's central directory

```sh
conda create -n myproject python=3.12 
conda activate myproject 
python --version 
```

### manage active envs

```sh
conda info --envs
conda deactivate
```