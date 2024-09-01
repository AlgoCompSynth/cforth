#! /usr/bin/env bash

set -e

echo "Installing Linux dependencies"
/usr/bin/time sudo dnf install -y \
  gcc \
  glibc-devel.i686 \
  platformio \
  usbutils
  > dnf.log 2>&1

echo "Finished"
