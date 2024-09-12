#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_pico_envars

echo "Installing Arduino MBED RP2040 'udev' rules as 'root'!!"
sudo cp 60-arduino-mbed.rules $SYSTEM_UDEV_PATH/

echo "Reloading"
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Finished"
