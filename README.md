# Raspberry Pi Pico (RP2) Development

These scripts configure a GNU/Linux or macOS system for Raspberry Pi
Pico development, producing:

- Raspberry Pi Pico C/C++ SDK
- Raspberry Pi Pico Python SDK (MicroPython RP2 port)
- OpenOCD
- Picoprobe
- Picotool

Caveats:

- On Fedora, a multi-architecture GNU debugger (gdb) is not available.
- On Apple silicon, gdb requires Rosetta 2.

In following figure, the Raspberry Pi Pico on the left acts as a debug
probe/serial console for the Pico under development on the right. The
Pico debug probe is connected via USB to a desktop/build system from
which these scripts are run.

| ![Raspberry Pi Pico Debug Probe](https://user-images.githubusercontent.com/418762/226142162-044a902f-0603-4857-870c-1cb7ce6d5d52.png) |
|:--:|
| **Pico configured as debug probe** (Image credit: Raspberry Pi)|

> NB: If the Pico under development is a USB host then, instead of
> wiring VSYS to VSYS (Pico pin 39), wire VBUS to VBUS (Pico pin 40)
> so that development USB can provide 5V.


For further information, please refer to:
- [Getting started with Raspberry Pi Pico](https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf)
- [Raspberry Pi Pico C/C++ SDK](https://datasheets.raspberrypi.com/pico/raspberry-pi-pico-c-sdk.pdf)
- [Raspberry Pi Pico Python SDK](https://datasheets.raspberrypi.com/pico/raspberry-pi-pico-python-sdk.pdf)

## Prerequisites

Until a release version of these scripts is distributed, the following
utilities are needed to generate the configure script:

- GNU autotools (i.e., autoconf, automake, libtool)
- GNU make
- GNU bash version 5+

On Debian/Ubuntu, run:

```shell
sudo apt install -y autoconf automake libtool make
```

on Fedora, run:

```shell
sudo dnf install -y autoconf automake libtool make
```

## macOS Prerequisites

In addition to Xcode, to be able to install the requisite software,
the build script assumes that
[MacPorts](https://www.macports.org/install.php) is already installed.
It's possible to use [Homebrew](https://brew.sh) instead, but the
build script would need to be updated accordingly.

```shell
sudo port install bash bash-completion autoconf automake libtool gmake
export PATH=/usr/local/bin:$PATH
```

## Installation from Source

In a terminal, run:

```shell
git clone https://github.com/revolution-robotics/rp2.git
cd rp2
./autogen.sh
./configure
make PICO_BOARD=pico PICO_BASEDIR=${PWD}/build
```

To build for Pico W, replace `PICO_BOARD=pico` above with
`PICO_BOARD=pico_w`.

Follow the instructions for updating the shell initialization scripts
printed at the end of `make` command.  Finally, run:

```shell
sudo make install
```

## Install Picoprobe

To install Picoprobe, the debug probe Pico (i.e., in the diagram
above, the left Pico) first needs to be mounted on the build system as a
USB Mass Storage device as follows:

With the Pico connected via USB cable to the build system, press and
hold the Pico **BOOTSEL** button on the debug probe, then momentarily
short the debug probe pins 30 (RUN) and 28 (GND). A moment later,
release **BOOTSEL**. Shorting the RUN pin to ground causes the Pico to
reset and, with **BOOTSEL** pressed, boot into USB Mass Storage mode.

If all went well, the Pico should be mounted on a
folder of the build system, i.e., on

- Ubuntu as: _/media/${USER}/RPI-RP2_
- Fedora as: _/run/media/${USER}/RPI-RP2_
- macOS as: _/Volumes/RPI-RP2_

Picoprobe can now be installed to the Pico by copying the file _picoprobe.uf2_ to
Pico's mount point, i.e., on

- Ubuntu, run:

```shell
cp ${PICO_BASEDIR}/picoprobe/build/picoprobe.uf2 \
    /run/media/${USER}/RPI-RP2
```

- Fedora, run:

```shell
cp ${PICO_BASEDIR}/picoprobe/build/picoprobe.uf2 \
    /run/media/${USER}/RPI-RP2
```

- macOS, run:

```shell
cp ${PICO_BASEDIR}/picoprobe/build/picoprobe.uf2 \
    /Volumes/RPI-RP2
```

That's it!

## Flash MicroPython

After installing Picoprobe, OpenOCD can be used for flashing
applications to the development system.  For instance, to flash
MicroPython, run:

```shell
make -C "$PICO_BUILD_PATH" flash \
    PICO_IMAGE="${PICO_BASEDIR}/micropython/ports/rp2/build-PICO/firmware.elf"
```

Then open the REPL with:

```shell
ttypico
```

## Debug Pico

To illustrate, debugging, start by flashing the blink application to
the Pico:

```shell
make -C "$PICO_BUILD_PATH" flash \
    PICO_IMAGE="${PICO_BASEDIR}/pico-examples/build/blink.elf"
```

Verify that the development Pico's LED is blinking, then start the
debug server:

```shell
make -C "$PICO_BUILD_PATH" debug
```

In another terminal, open the blink ELF image in GNU debugger:

```shell
gdb-multiarch "${PICO_BASEDIR}/pico-examples/build/blink/blink.elf"
```

At the GNU debugger prompt, **(gdb)**, connect to the OpenOCD debug server:


```gdb
target remote localhost:3333
```

Set a breakpoint, restart the blink application and list or step
through it:

```gdb
break main
monitor reset init
continue
list
step
```

After entering a command, hit the **Enter** key to repeat it. Use `quit`
to exit the GNU debugger and **CTRL+C** to terminate the debug server.
