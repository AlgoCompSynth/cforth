#! /usr/bin/env bash

set -e

source ../set_envars

echo "Installing Linux dependencies as 'root'!!"
sudo apt-get install -y \
  build-essential \
  gcc-multilib \
  python3-pip \
  python3-venv \
  screen \
  usbutils \
  > $LOGFILES/apt-get.log 2>&1

echo "Finished"
