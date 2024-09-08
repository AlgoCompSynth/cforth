#! /usr/bin/env bash

set -e

source ./set_envars
source $PIO_VENV/bin/activate
export LOGFILE=$LOGFILES/host-cforth.log
rm $LOGFILE

echo "Clearing caches"
rm -fr $HOME/.platformio ../.pio

pushd ..
  date \
    >> $LOGFILE 2>&1
  echo "Building host cforth"
  /usr/bin/time pio run --verbose \
    >> $LOGFILE 2>&1
  date \
    >> $LOGFILE 2>&1
popd

deactivate

echo "Finished"
