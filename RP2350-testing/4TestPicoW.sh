#! /usr/bin/env bash

set -e

source ./set_envars

pushd ..
  source $PIO_VENV/bin/activate
    echo "Building and uploading Pico W cforth"
    pio run --verbose \
      --environment test_pico_w \
      --target upload \
      2>&1 | tee $LOGFILES/test-pico-w-cforth.log 2>&1
  deactivate
popd

echo "Finished"
