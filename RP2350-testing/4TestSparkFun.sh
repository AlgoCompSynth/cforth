#! /usr/bin/env bash

set -e

source ./set_envars
source $PIO_VENV/bin/activate

pushd ..
  echo "Building and uploading Pico W cforth"
  pio run --verbose \
    --environment test_sparkfun \
    --target upload \
    2>&1 | tee $LOGFILES/test-sparkfun-cforth.log 2>&1
popd

deactivate

echo "Finished"
