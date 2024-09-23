#! /usr/bin/env bash

set -e

source ./set_envars
source $PIO_VENV/bin/activate
export PIO_ENVIRONMENT=${1-rpipico}
export BOARD_TAG=${2-""}
export LOGFILE="${LOGFILES}/${PIO_ENVIRONMENT}${BOARD_TAG}.log"
rm -f $LOGFILE

pushd ..
  echo "Listing USB devices"
  echo "" >> $LOGFILE 2>&1; echo "" >> $LOGFILE 2>&1
  lsusb \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE 2>&1; echo "" >> $LOGFILE 2>&1
  echo "Listing relevant TTYs"
  ls -l /dev/ttyACM* \
    >> $LOGFILE 2>&1 || true
  echo "" >> $LOGFILE 2>&1; echo "" >> $LOGFILE 2>&1
  echo "Building and uploading"
  /usr/bin/time pio run --verbose \
    --environment $PIO_ENVIRONMENT \
    --target upload \
    >> $LOGFILE 2>&1
  echo "Sleeping 20 seconds for devices to settle"
  sleep 20
  echo "" >> $LOGFILE 2>&1; echo "" >> $LOGFILE 2>&1
  echo "Listing USB devices"
  lsusb \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE 2>&1; echo "" >> $LOGFILE 2>&1
  echo "Listing relevant TTYs"
  ls -l /dev/ttyACM* \
    >> $LOGFILE 2>&1 || true
popd

deactivate

echo "Fetching firmware files"
cp ../.pio/build/$PIO_ENVIRONMENT/firmware.elf "${PIO_ENVIRONMENT}${BOARD_TAG}.elf"
cp ../.pio/build/$PIO_ENVIRONMENT/firmware.uf2 "$PIO_ENVIRONMENT${BOARD_TAG}.uf2"
echo "Disassembling"
$OBJDUMP_PATH/objdump \
  -d \
  "${PIO_ENVIRONMENT}${BOARD_TAG}.elf" \
  > "${PIO_ENVIRONMENT}${BOARD_TAG}.dis"

echo "Active TTYs"
ls -l /dev/ttyACM* || true

echo "Finished"
