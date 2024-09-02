#! /usr/bin/env bash

set -e

echo "Your device must be in BOOTSEL mode for the upload to work!"
echo ""
echo "Sleeping 20 seconds in case you need to CTL-C and restart."
sleep 20

source ./set_envars
source $PIO_VENV/bin/activate

pushd ..
  echo "Building and uploading Pico W cforth"
  pio run --verbose \
    --environment test_pico_w \
    --target upload \
    2>&1 | tee $LOGFILES/test-pico-w-cforth.log 2>&1
popd

deactivate

echo "Finished"
