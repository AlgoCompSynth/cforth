#! /usr/bin/env bash

set -e

ls -l /dev/ttyACM*
sudo chmod a+rw /dev/ttyACM*
ls -l /dev/ttyACM*
