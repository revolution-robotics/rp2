# Raspberry Pi Pico (RP2) Development

These scripts configure a macOS or Debian/Ubuntu system
for Raspberry Pi Pico development, producing:

- Raspberry Pi Pico C/C++ SDK
- Raspberry Pi Pico Python SDK (MicroPython RP2 port)
- OpenOCD
- Picoprobe
- Picotool

Caveats:

- On Apple silicon, to install the GNU debugger requires Rosetta 2.
- On Fedora, a multi-architecture gdb is not available.

In following figure, the Raspberry Pi Pico on the left acts as a debug
probe/serial console for the Pico under development on the right. The
Pico debug probe/serial console is connected via USB to a desktop
system from which these scripts are run.

| ![Raspberry Pi Pico Debug
Probe](https://user-images.githubusercontent.com/418762/226142162-044a902f-0603-4857-870c-1cb7ce6d5d52.png) |
|:--:|
|** Image credit: Raspberry Pi **|

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

## macOS Prerequisites

In addition to Xcode, to be able to install the requisite software,
including GNU autotools, GNU bash, libusb, etc., the build script
assumes that [MacPorts](https://www.macports.org/install.php) is
already installed. It is possible to use [Homebrew](https://brew.sh)
instead, but the build script would need to be updated accordingly.

```shell
sudo port install  bash bash-completion autoconf automake libtool gmake
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
sudo make install
```



To build for Pico W, replace `PICO_BOARD=pico` above with
`PICO_BOARD=pico_w`.

## Install Picoprobe

To install Picoprobe, the debug probe Pico (i.e., in the diagram
above, the left Pico) first needs to be mounted on the build system as a
USB Mass Storage device as follows:

With the Pico connected via USB cable to the build system, press and
hold the Pico **BOOTSEL** button on the debug probe, then momentarily
short the debug probe pins 30 (RUN) and 28 (GND). A moment later,
release **BOOTSEL**. Shorting the RUN pin to ground causes the Pico to
reset and, with **BOOTSEL** pressed, boot into USB Mass Storage mode.

If all went well, the Pico should be mounted on build system as a new
folder, i.e., on

- Ubuntu as _/media/${USER}/RPI-RP2_,
- Fedora as _/run/media/${USER}/RPI-RP2_,
- macOS as _/Volumes/RPI-RP2_.

Now Picoprobe can be installed to the Pico by copying the file _picoprobe.uf2_ to
Pico's mount point. So, on

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
make flash \
    PICO_IMAGE=${PICO_BASEDIR}/micropython/ports/rp2/build-PICO/firmware.elf
```

Then open the REPL with:

```shell
ttypico
```
