#! /usr/bin/env bash

set -e

echo "Creating logfile direcotry"
export LOGFILES=$PWD/Logfiles
mkdir --parents $LOGFILES

pushd ..
  echo "Building host cforth"
  pio run 2>&1 | tee $LOGFILES/host-build.log
  echo "Building and uploading pico cforth"
  pio run --environment pico --target upload 2>&1 | tee LOGFILES/pico-build.log
popd

echo "Finished"
