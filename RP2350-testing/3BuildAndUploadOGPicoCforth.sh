#! /usr/bin/env bash

set -e

source ./set_envars

pushd ..
  source $PIO_VENV/bin/activate
    echo "Building and uploadin OG Pico cforth"
    pio run --verbose \
      --environment pico \
      --target upload \
    > $LOGFILES/og-pico-cforth.log 2>&1
  deactivate
popd

echo "Finished"
