#! /usr/bin/env bash

set -e

source ./set_envars

echo "Installing Linux dependencies"
rpm-ostree install --idempotent \
  gcc \
  glibc-devel.i686 \
  screen

echo "Creating fresh $PIO_VENV"
rm -fr $PIO_VENV
python3 -m venv --upgrade-deps $PIO_VENV

echo "Installing PlatformIO in $PIO_VENV"
source $PIO_VENV/bin/activate
pip3 install --upgrade platformio \
  > $LOGFILES/platformio.log 2>&1
deactivate

echo "Finished"
