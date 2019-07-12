docker
================

  - [Links](#links)
  - [Dockerfile](#dockerfile)
      - [FROM](#from)
      - [RUN](#run)
      - [ARG](#arg)
      - [COPY](#copy)
  - [Commands](#commands)
      - [docker build](#docker-build)
      - [docker login](#docker-login)
      - [docker pull](#docker-pull)
      - [docker run](#docker-run)
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

### docker build

``` sh
docker build --build-arg WHEN=2019-01-06 -t analysis .
```

### docker login

``` sh
docker login
```

### docker pull

``` sh
docker pull
```

### docker run

``` sh
# create a local folder to recieve the results
mkdir ~/mydocker/results 
docker run -v ~/mydocker/results:/home/results analysis
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
