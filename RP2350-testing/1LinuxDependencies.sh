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

echo "Finished"
