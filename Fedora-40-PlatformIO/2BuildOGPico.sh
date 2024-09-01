#! /usr/bin/env bash

set -e

echo "Creating logfile direcotry"
export LOGFILES=$PWD/Logfiles
mkdir --parents $LOGFILES
export PIO_VENV=$PWD/platformio

pushd ..
  source $PIO_VENV/bin/activate
    echo "Building host cforth"
    pio run --verbose \
    > $LOGFILES/host-build.log
    echo "Building and uploading pico cforth"
    pio run --verbose \
      --environment pico \
      --target upload \
      > $LOGFILES/pico-build.log
  deactivate
popd

echo "Finished"
