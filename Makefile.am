# Makefile.am: Automake template for bash-dot-files.
#
# Process this file with automake to create Makefile.in
#
BUILD_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

PICO_BOARD   ?= pico
PICO_BASEDIR ?= $(BUILD_DIR)board/$(PICO_BOARD)
PICO_IMAGE   ?= $(PICO_BASEDIR)/pico-examples/build/blink/blink.elf
PICO_SDK_ENV ?= $(PICO_BASEDIR)/sdk-env.sh

bin_SCRIPTS = bootstrap build-sdk-and-upy openocd-picoprobe ttypico ttyusb

AM_DEFAULT_SOURCE_EXT = .in

.PHONY: all bootstrap build

all bootstrap: $(PICO_SDK_ENV)
	$(BUILD_DIR)config.status --recheck
	$(BUILD_DIR)config.status build-sdk-and-upy
	$(MAKE) build

build:
	$(BUILD_DIR)build-sdk-and-upy $(PICO_BOARD) $(PICO_BASEDIR) $(PICO_SDK_ENV)
	$(BUILD_DIR)config.status --recheck
	$(BUILD_DIR)config.status openocd-picoprobe
	$(CAT_CMD) $(PICO_SDK_ENV)

$(PICO_SDK_ENV):
	@echo "Pico board: $(PICO_BOARD)" >&2
	@echo "Pico SDK base directory: $(PICO_BASEDIR)" >&2
	@echo >&2
	@echo "To override default Pico board and/or SDK base directory, use:" >&2
	@echo >&2
	@echo "    make PICO_BOARD=pico-board PICO_BASEDIR=basedir" >&2
	@echo >&2
	@read -n 1 -p 'Press any key to continue...'
	@echo >&2
	$(BUILD_DIR)install-prerequisites $(PICO_BOARD) $(PICO_BASEDIR) $(PICO_SDK_ENV)

ttypico: ttyusb
	$(LN_CMD) -sf ttyusb $(BUILD_DIR)ttypico

debug: openocd-picoprobe
	openocd-picoprobe

flash: openocd-picoprobe
	openocd-picoprobe -c "program $(PICO_IMAGE) verify reset exit"

install-exec-local: $(bin_SCRIPTS)

clean-local:
	$(RM_CMD) -rf $(bin_SCRIPTS) $(PICO_BASEDIR)
