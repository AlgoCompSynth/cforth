#! /usr/bin/env bash

set -e

source ../set_envars

echo "Installing Linux dependencies as 'root'!!"
sudo dnf install -y \
  gcc \
  glibc-devel.i686 \
  screen \
  usbutils \
  > $LOGFILES/dnf.log 2>&1

echo "Finished"
