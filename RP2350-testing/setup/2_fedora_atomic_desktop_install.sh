#! /usr/bin/env bash

set -e

source ../set_envars

echo "Installing Linux dependencies"
rpm-ostree install --idempotent --allow-inactive \
  gcc \
  glibc-devel.i686 \
  screen

echo "Finished"
