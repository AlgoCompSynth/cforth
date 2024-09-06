#! /usr/bin/env bash

set -e

echo "If the upload fails, you will have to put the device"
echo "in BOOTSEL mode and re-run."
echo ""
echo "    picotool info -a -F"
echo ""
echo "should do it once you've done a successful upload."
echo "If you get no response that way, you'll need to do"
echo "it manually."
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

echo "Fetching firmware file"
cp ../.pio/build/test_pico_w/firmware.uf2 test-pico-w-cforth.uf2
echo "Disassembling"
$HOME/.platformio/packages/toolchain-rp2040-earlephilhower/arm-none-eabi/bin/objdump \
  -d \
  ../.pio/build/test_pico_w/firmware.elf \
  > test-pico-w-cforth.dis

echo "Finished"
