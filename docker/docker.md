docker
================

  - [Links](#links)
      - [Installation](#installation)
  - [Intro](#intro)
  - [Dockerfile](#dockerfile)
      - [FROM](#from)
      - [RUN](#run)
      - [ARG](#arg)
      - [COPY](#copy)
  - [Commands](#commands)
      - [docker container](#docker-container)
      - [docker build](#docker-build)
      - [docker image](#docker-image)
      - [docker login](#docker-login)
      - [docker ps](#docker-ps)
      - [docker pull](#docker-pull)
      - [docker rm](#docker-rm)
      - [docker run](#docker-run)
      - [docker stop](#docker-stop)
  - [Examples](#examples)

-----

> Docker provides a way to run applications securely isolated in a
> container, packaged with all its dependencies and libraries

-----

## Links

<https://docs.docker.com/>  
<https://docker-curriculum.com/>  
<https://colinfay.me/docker-r-reproducibility/>

Rocker:

<https://hub.docker.com/u/rocker>  
<https://github.com/noamross/nyhackr-docker-talk>  
<https://ropenscilabs.github.io/r-docker-tutorial/>  
<https://www.r-bloggers.com/running-your-r-script-in-docker/amp>

-----

### Installation

``` sh
# install 
brew install docker # command line tools
brew cask install docker # docker app
# check installation
docker --version
which docker
# view more details - need to have opened the docker app first
docker info
```

-----

## Intro

  - A container is launched by running an image
      - An **image** is an executable package that includes everything
        needed to run an application–the code, a runtime, libraries,
        environment variables, and configuration files  
      - A **container** is a runtime instance of an image

-----

## Dockerfile

  - the configuration file
  - e.g. describes
      - the template docker image you are building from one
      - how to configure the OS
      - what happens when you run the container
  - contains statements:
      - `FROM`
      - `RUN`
      - `ARG` (optional)
      - `COPY` (optional?)
      - `CMD`

### FROM

  - Describes image dependencies  
  - Describes what image the image is being built from - e.g. local or
    official  
  - asdf

**rocker**

<https://www.rocker-project.org/>

  - A collection of Docker images for R
      - `rocker/r-base` is the basic image  
      - `rocker/r-ver` are images containing a fixed version of R -
        e.g. `rocker/r-ver:3.4.4`

### RUN

  - Commands which mimic command line commands  
  - e.g. 
      - `RUN mkdir ~/analysis`  
      - `RUN R -e "some R code"`

### ARG

  - Create variables whose values will get set using the `--build-arg`
    flag (see [docker build](#docker-build))

### COPY

  - Instructions to copy files from local into the container

-----

## Commands

### docker container

``` sh
docker container
```

### docker build

``` sh
docker build --build-arg WHEN=2019-01-06 -t analysis .
```

### docker image

``` sh
# list images - e.g. see if the hello-world image was downloaded onto your machine
docker image ls

# same as above
docker images

# show image ids only
docker images -q
```

### docker login

``` sh
docker login
```

### docker ps

``` sh
# show running containers
docker ps

# show all containers
docker ps -a

# show all containers (numeric ids only)
docker ps -a -q
```

### docker pull

``` sh
docker pull
```

### docker rm

``` sh
# remove all containers
docker rm $(docker ps -a -q)

# remove a particular image
docker rmi image-id
```

### docker run

``` sh
docker run --help

# test that your installation works by running this image
docker run hello-world
```

``` sh
# create a local folder to recieve the results
mkdir ~/mydocker/results 
docker run -v ~/mydocker/results:/home/results analysis
```

### docker stop

``` sh
# stop all containers
docker stop $(docker ps -a -q)
```

-----

## Examples

    FROM rocker/r-ver:3.4.4
    
    ARG WHEN
    
    RUN mkdir /home/analysis
    
    RUN R -e "options(repos = \
      list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/${WHEN}')); \
      install.packages('apackage')"
    
    COPY myscript.R /home/analysis/myscript.R
    
    CMD cd /home/analysis \
      && R -e "source('myscript.R')" \
      && mv /home/analysis/p.csv /home/results/p.csv

Instead of using the snbapshot as defined by `WHEN`, you could install
specific package versions - e.g.

    RUN R -e "install.packages('remotes'); \
      remotes::install_version('apackage', '0.1.2')"
