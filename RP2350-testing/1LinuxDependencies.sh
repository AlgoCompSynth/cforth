#! /usr/bin/env bash

set -e

source ./set_envars

echo "Installing Linux dependencies"
/usr/bin/time sudo apt-get install -y \
  gcc \
  libc6-dev-i386 \
  libc6-dev-i386-cross \
  python3-venv \
  usbutils \
  > $LOGFILES/apt-get.log 2>&1

echo "Removing platformio caches"
rm -fr $HOME/.platformio ../.pio

echo "Creating fresh $PIO_VENV"
rm -fr $PIO_VENV
python3 -m venv --upgrade-deps $PIO_VENV

echo "Installing platformio"
source $PIO_VENV/bin/activate
pip install platformio==$PIO_VERSION \
  > $LOGFILES/platformio.log 2>&1
deactivate

echo "Finished"
