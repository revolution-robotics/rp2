# Makefile.am: Automake template for bash-dot-files.
#
# Process this file with automake to create Makefile.in

PICO_BASEDIR ?= $(PWD)/build
PICO_BOARD   ?= pico
PICO_IMAGE   ?= $(PICO_BASEDIR)/pico-examples/build/blink/blink.elf

bin_SCRIPTS = build-sdk-and-upy openocd-picoprobe ttypico ttyusb

AM_DEFAULT_SOURCE_EXT = .in

all: build-sdk-and-upy
	@./build-sdk-and-upy $(PICO_BASEDIR) $(PICO_BOARD)

build-sdk-and-upy: build-sdk-and-upy.in
	./configure

debug: openocd-picoprobe
	openocd-picoprobe

openocd-picoprobe: openocd-picoprobe.in
	./configure

flash: openocd-picoprobe
	openocd-picoprobe -c "program $(PICO_IMAGE) verify reset exit"

clean-local:
	rm -rf $(bin_SCRIPTS) $(PICO_BASEDIR)
