# copier

> ?

## setup

```sh
brew install copier
```

## basics

```sh
# copy from local folder
copier copy <project template path> <new project path>

# if template contains jinja templates
copier copy <project template> <new project path> --trust

# use a latest changes
copier copy <project template> <new project path> --trust --vcs-ref HEAD

# use a specific tag
copier copy <project template> <new project path> --trust --vcs-ref v0.1.0

# copy from remote
copier copy https://github.com/<user>/<project template>.git <new project path> --trust --vcs-ref v0.1.0

