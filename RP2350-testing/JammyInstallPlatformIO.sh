#! /usr/bin/env bash

set -e

source ./set_envars

echo "Installing Linux dependencies"
sudo apt-get install -y \
  build-essential \
  gcc-multilib \
  python3-pip \
  python3-venv \
  screen \
  > $LOGFILES/apt-get.log 2>&1

echo "Creating fresh $PIO_VENV"
rm -fr $PIO_VENV
python3 -m venv --upgrade-deps $PIO_VENV

echo "Installing PlatformIO in $PIO_VENV"
source $PIO_VENV/bin/activate
pip3 install --upgrade platformio \
  > $LOGFILES/platformio.log 2>&1
deactivate

echo "Finished"
