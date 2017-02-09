program_name=unicornleap
troll_name=trollleap
image_folder=$(HOME)/.$(program_name)
build_folder=build
PREFIX ?= /usr/local

.PHONY: all clean images troll unicorn

all: unicorn troll

unicorn:
	xcodebuild -target UnicornLeap CONFIGURATION_BUILD_DIR=$(build_folder) PRODUCT_NAME=$(program_name) > /dev/null 2>&1

troll:
	xcodebuild -target TrollLeap CONFIGURATION_BUILD_DIR=$(build_folder) PRODUCT_NAME=$(troll_name) > /dev/null 2>&1

images:
	mkdir -p $(image_folder) > /dev/null 2>&1
	cp images/*.png $(image_folder) > /dev/null 2>&1

install: images
	cp $(build_folder)/$(program_name) $(PREFIX)/bin/$(program_name) > /dev/null 2>&1
	cp $(build_folder)/$(troll_name) $(PREFIX)/bin/$(troll_name) > /dev/null 2>&1
	cp $(program_name).1 $(PREFIX)/share/man/man1/ > /dev/null 2>&1
	cp trollleap.1 $(PREFIX)/share/man/man1/ > /dev/null 2>&1

clean:
	rm -rf $(build_folder) > /dev/null 2>&1
