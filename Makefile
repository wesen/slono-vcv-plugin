# Makefile templates from Dale Emery's [SLONO Modules](https://dhemery.github.io/SLONO-Modules/)

RACK_DIR ?= ../..
include $(RACK_DIR)/plugin.mk

########################################################################
#
# Build and test the plugin via CMake and CTest
#
########################################################################

SLONO_STAGING_DIRNAME = .stage
SLONO_STAGING_DIRPATH = $(realpath .)/$(SLONO_STAGING_DIRNAME)

SLONO_RACK_USER_DIRNAME = rack-user-dir

SLONO_CMAKE_OPTIONS += -DCMAKE_INSTALL_PREFIX=$(SLONO_STAGING_DIRPATH)
SLONO_CMAKE_OPTIONS += -DRACK_STAGING_DIR=$(SLONO_RACK_USER_DIRNAME)
SLONO_CMAKE_OPTIONS += -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

SLONO_CMAKE_BUILD_OPTIONS +=

SLONO_CTEST_OPTIONS += --progress
SLONO_CTEST_OPTIONS += --output-on-failure

include makefiles/cmake-targets.mk

########################################################################
#
# Stage the plugin and run Rack
#
########################################################################

SLONO_APP_DIRPATH ?= /Applications
SLONO_RACK_APP_DIRPATH = $(SLONO_APP_DIRPATH)/Rack.app
SLONO_RACK_EXECUTABLE_PATH = $(SLONO_RACK_APP_DIRPATH)/Contents/MacOS/Rack
SLONO_RACK_SYSTEM_DIRPATH = $(SLONO_RACK_APP_DIRPATH)/Contents/Resources
SLONO_RACK_USER_DIRPATH = $(SLONO_STAGING_DIRPATH)/$(SLONO_RACK_USER_DIRNAME)

stage: build
	cmake --build $(SLONO_BUILD_DIRNAME) --target install  $(SLONO_CMAKE_BUILD_OPTIONS)

clean-stage:
	rm -rf $(SLONO_STAGING_DIRNAME)

run: stage
	$(SLONO_RACK_EXECUTABLE_PATH) -u $(SLONO_RACK_USER_DIRPATH)

debug: stage
	$(SLONO_RACK_EXECUTABLE_PATH) -d -u $(SLONO_RACK_USER_DIRPATH) -s $(SLONO_RACK_SYSTEM_DIRPATH)

clean: clean-stage

.PHONY: debug run clean-stage