#! /usr/bin/env bash

set -e

source ./set_envars

echo "Installing Linux dependencies"
rpm-ostree install --idempotent --allow-inactive \
  gcc \
  glibc-devel.i686 \
  screen

echo "Creating fresh $PIO_VENV"
rm -fr $PIO_VENV
python3 -m venv --upgrade-deps $PIO_VENV

echo "Installing PlatformIO in $PIO_VENV"
source $PIO_VENV/bin/activate
pip3 install --upgrade platformio \
  > $LOGFILES/platformio_install.log 2>&1
deactivate

echo "Installing PlatformIO rules"
curl -fsSL $PLATFORMIO_UDEV_RULES_URL | sudo tee $PLATFORMIO_UDEV_RULES_PATH

echo "Reloading"
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Finished"
