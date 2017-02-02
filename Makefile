program_name=unicornleap
troll_name=trollleap
image_folder=$(HOME)/.$(program_name)
build_folder=build
PREFIX ?= /usr/local

.PHONY: all clean images troll unicorn

all: unicorn troll

unicorn:
	xcodebuild -target UnicornLeap CONFIGURATION_BUILD_DIR=$(build_folder) PRODUCT_NAME=$(program_name)

troll:
	xcodebuild -target TrollLeap CONFIGURATION_BUILD_DIR=$(build_folder) PRODUCT_NAME=$(troll_name)

images:
	mkdir -p $(image_folder)
	cp images/*.png $(image_folder)

install: images
	cp $(build_folder)/$(program_name) $(PREFIX)/bin/$(program_name)
	cp $(build_folder)/$(troll_name) $(PREFIX)/bin/$(troll_name)
	cp $(program_name).1 $(PREFIX)/share/man/man1/
	cp trollleap.1 $(PREFIX)/share/man/man1/

clean:
	rm -rf $(build_folder)
