all: cmake

cmake:
	@mkdir -p build                                                                                                                                                                                                                       
	cd build && cmake $(CMAKE_FLAGS) ..
ifneq ($(MAKE),)
	cd build && $(MAKE)
else
	cd build && make
endif

clean:
	rm -rf build
