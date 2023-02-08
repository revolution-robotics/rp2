# Makefile.am: Automake template for bash-dot-files.
#
# Process this file with automake to create Makefile.in

DESTDIR ?= $(HOME)/pico
BOARD   ?= pico

bin_SCRIPTS = build-sdk-and-upy ttypico ttyusb

AM_DEFAULT_SOURCE_EXT = .in

all: ttyusb
	@./build-sdk-and-upy $(DESTDIR) $(BOARD)

clean-local:
	rm -f $(bin_SCRIPTS)
