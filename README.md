# LMA Development Container

This Docker container will provides `lma_analysis` and `lma_data` utilities that
you can run on any Docker host. It also provides the necessary environment setup
required, along with shape files for plotting.

## Installation

1. Download [Docker](https://docs.docker.com/engine/install/) on your system. If
you plan to install these utilities on a Windows or macOS machine, you can install
[Docker Desktop](https://www.docker.com/products/docker-desktop/) to provide a
user-friendly interface for installing and managing Docker.

2. Install this Git repository:

```
git clone https://github.com/XR-at-CISESS/lma-dev.git
```

## Usage

To start the container, you can utilize the `lma.sh` script. The first time you
run this script, it will build the container image and get all the utilities/packages
needed, which can take around 10-15 minutes to complete. 

```
$ ./lma.sh

lma@...$ lma_analysis
```
You can optionally specify a directory on your machine to `lma.sh`. This will cause
the specified host directory to be available within the container under the `/host/`
directory. This is useful for referencing data on your host machine and exporting
generated plots and figures. For example:

```
$ mkdir test/
$ echo "hello world" > test/hello.txt
$ ./lma.sh ./test/

lma@...$ cat /host/hello.txt
hello world
lma@...$
```