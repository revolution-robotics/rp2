# Makefile.am: Automake template for bash-dot-files.
#
# Process this file with automake to create Makefile.in

PICO_BASEDIR ?= $(PWD)/build
PICO_BOARD   ?= pico
PICO_IMAGE   ?= $(PICO_BASEDIR)/pico-examples/build/blink/blink.elf

bin_SCRIPTS = build-sdk-and-upy ttypico ttyusb

AM_DEFAULT_SOURCE_EXT = .in

all: ttyusb
	@./build-sdk-and-upy $(PICO_BASEDIR) $(PICO_BOARD)

debug:
	@cd $(PICO_BASEDIR)/openocd; \
	openocd -f tcl/interface/cmsis-dap.cfg -c 'adapter speed 5000' -f tcl/target/rp2040.cfg -s tcl

flash:
	@cd $(PICO_BASEDIR)/openocd; \
	openocd -f tcl/interface/cmsis-dap.cfg -c 'adapter speed 5000' -f tcl/target/rp2040.cfg -s tcl \
	    -c "program $(PICO_IMAGE) verify reset exit"

clean-local:
	rm -rf $(bin_SCRIPTS) $(PICO_BASEDIR)
