#! /usr/bin/env bash

set -e

source ./set_envars
source $PIO_VENV/bin/activate

pushd ..
  echo "Building and uploading OG Pico cforth"
  pio run --verbose \
    --environment pico \
    --target upload \
    2>&1 | tee $LOGFILES/og-pico-cforth.log
popd

deactivate

echo "Finished"
