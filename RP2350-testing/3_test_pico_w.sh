#! /usr/bin/env bash

set -e

source ./set_envars
source $PIO_VENV/bin/activate
export PIO_ENVIRONMENT=test_pico_w
export LOGFILE=$LOGFILES/$PIO_ENVIRONMENT-cforth.log
rm -f $LOGFILE

pushd ..
  echo "Listing USB devices"
  echo "" \
    >> $LOGFILE 2>&1
  echo "" \
    >> $LOGFILE 2>&1
  echo "" \
    >> $LOGFILE 2>&1
  lsusb \
    >> $LOGFILE 2>&1
  echo "Listing relevant TTYs"
  ls -l /dev/ttyACM* \
    >> $LOGFILE 2>&1 || true
  echo "" \
    >> $LOGFILE 2>&1
  echo "" \
    >> $LOGFILE 2>&1
  echo "" \
    >> $LOGFILE 2>&1
  date \
    >> $LOGFILE 2>&1
  echo "Building and uploading"
  /usr/bin/time pio run --verbose \
    --environment $PIO_ENVIRONMENT \
    --target upload \
    >> $LOGFILE 2>&1
  echo "Sleeping 15 seconds for devices to settle"
  sleep 15
  date \
    >> $LOGFILE 2>&1
  echo "" \
    >> $LOGFILE 2>&1
  echo "" \
    >> $LOGFILE 2>&1
  echo "" \
    >> $LOGFILE 2>&1
  echo "Listing USB devices"
  echo "" \
    >> $LOGFILE 2>&1
  echo "" \
    >> $LOGFILE 2>&1
  echo "" \
    >> $LOGFILE 2>&1
  lsusb \
    >> $LOGFILE 2>&1
  echo "Listing relevant TTYs"
  echo "" \
    >> $LOGFILE 2>&1
  echo "" \
    >> $LOGFILE 2>&1
  echo "" \
    >> $LOGFILE 2>&1
  ls -l /dev/ttyACM* \
    >> $LOGFILE 2>&1 || true
popd

deactivate

echo "" \
  >> $LOGFILE 2>&1
echo "" \
  >> $LOGFILE 2>&1
echo "" \
  >> $LOGFILE 2>&1
echo "Fetching firmware file"
cp ../.pio/build/pico/firmware.uf2 $PIO_ENVIRONMENT-pico-cforth.uf2
echo "Disassembling"
$HOME/.platformio/packages/toolchain-gccarmnoneeabi/arm-none-eabi/bin/objdump \
  -d \
  ../.pio/build/pico/firmware.elf \
  > $PIO_ENVIRONMENT-cforth.dis

echo "Finished"
