# Raspberry Pi microcontroller platform / board test suite

## Running

1. Run `./1_host.sh`. This will remove all the cached files
from `$HOME/.platformio` and `../pio`, then build the required
host Forth components. You only need to run this once unless
you want to clear the caches again and start over.

2. Connect your board and put it in `BOOTSEL` mode. You should
only have one board connected at a time.

    I have had intermittent issues with boards connected with a
USB hub or one of those USB-A to micro or USB C adapters. If you
have problems, connect with a known good USB cable directly to
the host computer.

3. Look up your board in `raspberrypi-platform-boards.txt`. I
have only included boards I have actually tested in
`../platformio.ini`, but if you have boards I don't have and
want to test them, feel free to add an environment.

4. Run the test with the script `./test_board.sh`. The parameters
are:

    - $1=PIO_ENVIRONMENT: The envionment from `../platformio.ini`.
The default is a Raspberry Pi Pico, `rpipico`.
    - $2=LOGFILE_TAG: An optional logfile tag. The default is the empty string.
The test script logs to the file `Logfiles/${PIO_ENVIRONMENT}${LOGFILE_TAG}.log`

Aside from logging information possibly useful in troubleshooting, the
script does a `pio run` with the specified environment to build and upload
the `cforth` firmware to the board. It then fetches the firmware files out
from the build environment and creates a disassembly listing.

Finally, it lists the active `/dev/ttyACM*` TTYs. This is almost always just
`/dev/ttyACM0`, unless you have more than one board connected. If all went
well you can do `screen /dev/ttyACM0 115200`, do an `Enter`, and receive
the `cforth` `ok` prompt. I have not tested `cforth` itself extensively
yet, but `2 3 + . Enter` behaves as expected.
