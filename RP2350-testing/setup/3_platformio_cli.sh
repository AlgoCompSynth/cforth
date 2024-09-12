#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
source ../set_envars

echo "Creating fresh virtual environment $PIO_VENV"
rm -fr $PIO_VENV
python3 -m venv $PIO_VENV --upgrade-deps
echo "Activating virtual environment $PIO_VENV"
source $PIO_VENV/bin/activate

echo "Installing PlatformIO CLI with pip"
# https://docs.platformio.org/en/latest/core/installation/methods/pypi.html#installation-pypi
python3 -m pip install --upgrade platformio

echo ""
echo ""
echo "Deactivating virtual environment $PLATFORMIO_VENV"
deactivate

echo "Finished"
