#! /usr/bin/env bash

set -e

echo "Creating logfile direcotry"
export LOGFILES=$PWD/Logfiles
mkdir --parents $LOGFILES

echo "Installing Linux dependencies"
/usr/bin/time sudo dnf install -y \
  gcc \
  glibc-devel.i686 \
  screen \
  usbutils
  > $LOGFILES/dnf.log 2>&1

echo "Creating fresh platformio venv"
python3 -m venv --clear --upgrade-deps platformio

echo "Installing platformio"
source platformio/bin/activate
pip install --upgrade platformio \
  > $LOGFILES/platformio.log 2>&1
deactivate

echo "Finished"
