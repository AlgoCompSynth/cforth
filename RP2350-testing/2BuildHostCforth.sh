#! /usr/bin/env bash

set -e

source ./set_envars

pushd ..
  source $PIO_VENV/bin/activate
    echo "Building host cforth"
    pio run --verbose \
    > $LOGFILES/host-cforth.log 2>&1
  deactivate
popd

echo "Finished"
