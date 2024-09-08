#! /usr/bin/env bash

set -e

source ./set_envars
source $PIO_VENV/bin/activate
export LOGFILE=$LOGFILES/test-pico-w-cforth.log
rm $LOGFILE

pushd ..
  echo "Listing USB devices"
  lsusb \
    >> $LOGFILE 2>&1
  echo "Listing relevant TTYs"
  ls -l /dev/ttyACM* /dev/ttyUSB* || true \
    >> $LOGFILE 2>&1
  date \
    >> $LOGFILE 2>&1
  echo "Building and uploading"
  /usr/bin/time pio run --verbose \
    --environment test_pico_w \
    --target upload \
    >> $LOGFILE 2>&1
  date \
    >> $LOGFILE 2>&1
  echo "Listing USB devices"
  lsusb \
    >> $LOGFILE 2>&1
  echo "Listing relevant TTYs"
  ls -l /dev/ttyACM* /dev/ttyUSB* || true \
    >> $LOGFILE 2>&1
popd

deactivate

echo "Fetching firmware file"
cp ../.pio/build/test_pico_w/firmware.uf2 test-pico-w-cforth.uf2
echo "Disassembling"
$HOME/.platformio/packages/toolchain-rp2040-earlephilhower/arm-none-eabi/bin/objdump \
  -d \
  ../.pio/build/test_pico_w/firmware.elf \
  > test-pico-w-cforth.dis

echo "Finished"
