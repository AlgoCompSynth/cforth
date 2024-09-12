# Raspberry Pi microcontroller platform / board test suite

## Running

1. Run `./1_host.sh`. This will remove all the cached files
from `$HOME/.platformio` and `../pio`, then build the required
host Forth components. You only need to run this once unless
you want to clear the caches again and start over.

2. Connect your board and put it in `BOOTSEL` mode. You should
only have one board connected at a time.

    I have had intermittent issues with boards when connected
by a USB hub or one of those USB-A to micro or USB-C adapters.
If you have problems, connect with a known good USB cable
directly to the host computer.

3. Look up your board in

    [`raspberrypi-platform-boards.txt`](https://github.com/AlgoCompSynth/cforth/blob/master/RP2350-testing/raspberrypi-platform-boards.txt).

   I have only included boards I have actually tested in
`../platformio.ini`, but if you have RP2040 / RP2350 boards
that I don't have and want to test them, feel free to add an
environment.

4. Run the test with the script `./test_board.sh`.
The parameters are

    a. `PIO_ENVIRONMENT`: The environment from `../platformio.ini`
    to use. The default is a Raspberry Pi Pico, `rpipico`.

    b. `BOARD_TAG`: An optional board tag. The default is the
    empty string. The test script uses the name
    `${PIO_ENVIRONMENT}${BOARD_TAG}` for the `.log`, `.elf`,
    `.uf2` and `.dis` files.

    For example, when I test the
    [Pimoroni Pico Plus 2](https://shop.pimoroni.com/products/pimoroni-pico-plus-2?variant=42092668289107),
    which isn't in the current Arduino framework board list, I use the command:

    ```
    ./test_board.sh generic_rp2350 pimoroni_pico_plus_2
    ```

## What the script does

Aside from logging information possibly useful in troubleshooting, the
script does a `pio run` with the specified environment to build and upload
the `cforth` firmware to the board. It then fetches the firmware files
from the build environment and creates a disassembly listing.

Finally, it lists the active `/dev/ttyACM*` TTYs. This is almost always just
`/dev/ttyACM0`, unless you have more than one board connected. If all went
well you can do `screen /dev/ttyACM0 115200`, do an `Enter`, and receive
the `cforth` `ok` prompt. I have not tested `cforth` itself extensively
yet, but `2 3 + . Enter` behaves as expected.

## Status / next steps
The current tests are using a pre-release platform,
<https://github.com/maxgerhardt/platform-raspberrypi.git>. This in turn uses the
***released*** Arduino Pico framework,
<https://github.com/earlephilhower/arduino-pico/releases/tag/4.0.1>. Before I
submit a pull request, I am waiting for the platform to be released and the
next release of the framework.

The `master` branch of the framework has a definition for one of the boards I
have, the Pimoroni Pico Plus 2. The board does work in the ***Ardunio CLI***
using that branch, but I have no way to build and test `cforth` on that board
with PlatformIO until the released version includes that board. The board
does work with "Generic RP2350" currently.
