#! /usr/bin/env bash

set -e

source ./set_envars
source $PIO_VENV/bin/activate

echo "Clearing caches"
rm -fr $HOME/.platformio ../.pio

pushd ..
  echo "Building host cforth"
  pio run --verbose \
    2>&1 | tee $LOGFILES/host-cforth.log
popd

deactivate

echo "Finished"
