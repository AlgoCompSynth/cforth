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
  echo "Building and uploading OG Pico cforth"
  pio run --verbose \
    --environment pico \
    --target upload \
    2>&1 | tee $LOGFILES/pico-ice-cforth.log
popd

deactivate

echo "Fetching firmware file"
cp ../.pio/build/pico/firmware.uf2 pico-ice-cforth.uf2
echo "Disassembling"
$HOME/.platformio/packages/toolchain-gccarmnoneeabi/arm-none-eabi/bin/objdump \
  -d \
  ../.pio/build/pico/firmware.elf \
  > pico-ice-cforth.dis

echo "Finished"
