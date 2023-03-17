# Raspberry Pi Pico

Scripts for Raspberry Pi Pico development on Mac/Linux desktops. These
produce:
- Raspberry Pi Pico C/C++ SDK
- Raspberry Pi Pico Python SDK (MicroPython RP2 port)
- OpenOCD
- Picoprobe
- Picotool

Fedora is not supported since is doesn't provide libraries needed for
32-bit ARM development. In particular, Fedora only provides
a cross-compilation toolchain for 32-bit ARM kernels.

In following figure, the Raspberry Pi Pico on the left acts as a debug
probe/serial console for the Pico under development on the right. The
Pico debug probe/serial console is connected via USB to a desktop
system from which these scripts are run.


For further information, please refer to:
- [Getting started with Raspberry Pi Pico](https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf)
- [Raspberry Pi Pico C/C++ SDK](https://datasheets.raspberrypi.com/pico/raspberry-pi-pico-c-sdk.pdf)
- [Raspberry Pi Pico Python SDK](https://datasheets.raspberrypi.com/pico/raspberry-pi-pico-python-sdk.pdf)

## Ubuntu/Debian Prerequisites

The scripts attempt to install prerequisites, but to manually install
them, open a terminal and run:

```shell
sudo apt install autoconf automake binutils-arm-none-eabi          \
     build-essential cmake g++ gcc gcc-arm-none-eabi gdb-multiarch \
     git git-lfs libftdi1 libnewlib-arm-none-eabi libnewlib-dev    \
     libstdc++-arm-none-eabi-dev libstdc++-arm-none-eabi-newlib    \
     libtool libusb-1.0-0-dev libusb-dev texinfo

```

## macOS Prerequisites

Prior to running the scripts on macOS, please first install
[MacPorts](https://www.macports.org/install.php) and then bash shell:

```shell
sudo port install bash bash-completion
```
