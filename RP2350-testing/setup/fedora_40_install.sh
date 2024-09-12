#! /usr/bin/env bash

set -e

source ./set_envars

echo "Installing Linux dependencies"
sudo dnf install -y \
  gcc \
  glibc-devel.i686 \
  screen \
  usbutils \
  > $LOGFILES/dnf.log 2>&1

echo "Creating fresh $PIO_VENV"
rm -fr $PIO_VENV
python3 -m venv --upgrade-deps $PIO_VENV

echo "Installing PlatformIO in $PIO_VENV"
source $PIO_VENV/bin/activate
pip3 install --upgrade platformio \
  > $LOGFILES/platformio_install.log 2>&1
deactivate

echo "Finished"
