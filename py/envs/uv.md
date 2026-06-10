# uv

> ?

## contents

* [create a new env](#create-a-new-env)

## links

* https://realpython.com/python-uv/

## setup

### install

```sh
brew install uv
```

### check version

```sh
uv --version
```

# use in an existing project

```sh
uv python pin 3.12
uv init
uv add pandas
uv add --dev ipykernel pytest
uv sync # e.g. if toml file has changed 
```

activate an env in the terminal

```sh
source .venv/bin/activate
which python && python --version
```

