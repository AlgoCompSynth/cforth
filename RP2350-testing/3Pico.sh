#! /usr/bin/env bash

set -e

source ./set_envars

pushd ..
  source $PIO_VENV/bin/activate
    echo "Building and uploading OG Pico cforth"
    pio run --verbose \
      --environment pico \
      --target upload \
      2>&1 | tee $LOGFILES/og-pico-cforth.log
  deactivate
popd

echo "Finished"
