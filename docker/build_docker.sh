#!/usr/bin/env bash
export DOCKER_BUILDKIT=0
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
EXEC_PATH=$PWD

cd $ROOT_DIR

    docker build -t rt1-img -f $ROOT_DIR/docker/Dockerfile $ROOT_DIR \
                                  --network=host \

cd $EXEC_PATH
