#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_envars

echo "Installing PlatformIO rules as 'root'!!"
curl -fsSL $PLATFORMIO_UDEV_RULES_URL | sudo tee $PLATFORMIO_UDEV_RULES_PATH

echo "Installing Arduino MBED RP2040 'udev' rules as 'root'!!"
sudo cp 60-arduino-mbed.rules $SYSTEM_UDEV_PATH/

echo "Reloading"
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Finished"
