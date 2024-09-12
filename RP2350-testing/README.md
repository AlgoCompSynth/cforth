# Raspberry Pi Microcontroller Platform / Board Test Suite

## 1. Setup

### Development environment

My main development enviornment is [Universal Blue Bluefin
DX](https://projectbluefin.io/ "Bluefin Home Page"). Bluefin DX is a
"batteries-included" container-based platform based on [Fedora
Silverblue](https://fedoraproject.org/atomic-desktops/silverblue/
"Fedora Silverblue Home Page").

The scripts in this test suite are designed to work

-   On any [Fedora Atomic Desktop](https://fedoraproject.org/atomic-desktops/
    "Fedora Atomic Desktops Home Page") or
    [Univeral Blue](https://universal-blue.org/ "Universal Blue Home Page")
    host system,

-   On a Fedora 40, Debian 12 "Bookworm" or Ubuntu 22.04 LTS "Jammy Jellyfish"
    system. A desktop is not required; everything can be done from a `bash`
    or `zsh` command line, or

-   In a Fedora 40, Debian 12 or Ubuntu 22.04 LTS
    [Distrobox](https://distrobox.it/ "Distrobox Home Page") container.

Note that currently only `x86_64` / `amd64` systems will work.

A note about Windows Subsystem for Linux (WSL): these scripts can be
made to work in Ubuntu 22.04 LTS running in WSL. However, it requires a
somewhat awkward mechanism for making Windows host USB devices available
to the WSL Linux container. You are probably better off installing
Visual Studio Code and using the PlatformIO extension, once those catch
up fully with the RP2350 boards. If you want to experiment with it,
here's the official Microsoft documentation on using host USB devices in
WSL:
[Connect USB Devices](https://learn.microsoft.com/en-us/windows/wsl/connect-usb
"Microsoft Documentation for USBIPD").

### Setting `udev` rules

The setup scripts are in directory `cforth/RP2350-testing/setup`. The
first step is to set the `udev` rules for RP2040 / RP2350 devices. ***If
you are running in a container, you will need to set them on the host,
not in the container.***

```
./1_host_set_udev_rules.sh
```

This script requires elevated privilege via `sudo` and will ask for your
password.

### Installing Linux dependencies

Next, install the appropriate Linux dependencies.

-   Fedora Atomic Desktop or Universal Blue host:
    `./2_fedora_atomic_desktop_install.sh`. You will need to reboot
    after running this.

-   Fedora 40 system or container: `./2_fedora_40_install.sh`. This
    script requires elevated privilege but does not require a reboot.

-   Debian 12 "Bookworm" system or container:
    `./2_debian_bookworm_install.sh`. This script requires elevated
    privilege but does not require a reboot.

-   Ubuntu 22.04 LTS "Jammy Jellyfish" system or container:
    `./2_ubuntu_jammy_install.sh`. This script requires elevated
    privilege but does not require a reboot.

### Installing the PlatformIO Command Line Interface (CLI)

The final setup step is installing the PlatformIO CLI:

```
./3_platformio_cli.sh
```

The script installs the PlatformIO CLI in a [Python 3 `venv` virtual
environment](https://docs.python.org/3/library/venv.html
"venv — Creation of virtual environments") named `$HOME/pio_venv`.
The scripts all know where this is, but if you want to run `pio`
commands yourself, you will need to type

```
source $HOME/pio_venv/bin/activate
```

first.

## 2. Running tests

1.  Run `./1_host.sh`. This will remove all the cached files from
    `$HOME/.platformio` and `../pio`, then build the required host Forth
    components. You only need to run this once unless you want to clear
    the caches again and start over.

2.  Connect your board and put it in `BOOTSEL` mode. You should only
    have one board connected at a time.

    I have had intermittent issues with boards when connected by a USB
    hub or one of those USB-A to micro or USB-C adapters. If you have
    problems, connect with a known good USB cable directly to the host
    computer.

3.  Look up your board in

    [`raspberrypi-platform-boards.txt`](https://github.com/AlgoCompSynth/cforth/blob/master/RP2350-testing/raspberrypi-platform-boards.txt).

    I have only included boards I have actually tested in
    `../platformio.ini`, but if you have RP2040 / RP2350 boards that I
    don't have and want to test them, feel free to add an environment.

4.  Run the test with the script `./test_board.sh`. The parameters are

    a.  `PIO_ENVIRONMENT`: The environment from `../platformio.ini` to
        use. The default is a Raspberry Pi Pico, `rpipico`.

    b.  `BOARD_TAG`: An optional board tag. The default is the empty
        string. The test script uses the name
        `${PIO_ENVIRONMENT}${BOARD_TAG}` for the `.log`, `.elf`, `.uf2`
        and `.dis` files.

    For example, when I test the [Pimoroni Pico Plus
    2](https://shop.pimoroni.com/products/pimoroni-pico-plus-2?variant=42092668289107),
    which isn't in the current Arduino framework board list, I use the
    command:

    ```
    ./test_board.sh generic_rp2350 pimoroni_pico_plus_2
    ```

## What the script does

Aside from logging information possibly useful in troubleshooting, the
script does a `pio run` with the specified environment to build and
upload the `cforth` firmware to the board. It then fetches the firmware
files from the build environment and creates a disassembly listing.

Finally, it lists the active `/dev/ttyACM*` TTYs. This is almost always
just `/dev/ttyACM0`, unless you have more than one board connected. If
all went well you can do `screen /dev/ttyACM0 115200`, do an `Enter`,
and receive the `cforth` `ok` prompt. I have not tested `cforth` itself
extensively yet, but `2 3 + . Enter` behaves as expected.

## Status / next steps

The current tests are using a pre-release platform,
<https://github.com/maxgerhardt/platform-raspberrypi.git>. This in turn
uses the ***released*** Arduino Pico framework,
<https://github.com/earlephilhower/arduino-pico/releases/tag/4.0.1>.
Before I submit a pull request, I am waiting for the platform to be
released and the next release of the framework.

The `master` branch of the framework has a definition for one of the
boards I have, the Pimoroni Pico Plus 2. The board does work in the
***Ardunio CLI*** using that branch, but I have no way to build and test
`cforth` on that board with PlatformIO until the released version
includes that board. That board ***does*** work with "Generic RP2350"
currently.
