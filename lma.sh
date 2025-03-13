#!/bin/sh
# A script to assist in utilizing the LMA developer container.

if [[ $# -eq 1 ]]
then
    DOCKER_MOUNT_PATH="$(realpath $1)"
else
    DOCKER_MOUNT_PATH="$(pwd)"
fi

docker compose run -v $DOCKER_MOUNT_PATH:/host --rm lma_dev 