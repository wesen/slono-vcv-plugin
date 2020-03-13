SLONO_BUILD_DIRNAME = .build

SLONO_CMAKE_OPTIONS +=
SLONO_CMAKE_BUILD_OPTIONS +=
SLONO_CTEST_OPTIONS +=

$(SLONO_BUILD_DIRNAME):
	mkdir $@

config: $(SLONO_BUILD_DIRNAME)
	cd $(SLONO_BUILD_DIRNAME) && cmake $(SLONO_CMAKE_OPTIONS) ..

build: config
	cmake --build $(SLONO_BUILD_DIRNAME) $(SLONO_CMAKE_BUILD_OPTIONS)

clean-build:
	rm -rf $(SLONO_BUILD_DIRNAME)

test: build
	cd $(SLONO_BUILD_DIRNAME) && ctest $(SLONO_CTEST_OPTIONS)

clean: clean-build

.PHONY: build clean-build config test
