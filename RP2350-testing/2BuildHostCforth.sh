#! /usr/bin/env bash

set -e

source ./set_envars

pushd ..
  echo "Building host cforth"
  pio run --verbose \
  > $LOGFILES/host-cforth.log 2>&1
popd

echo "Finished"
