# This configuration file outlines some of the ways Arduino CMake
# can be used. For a detailed explenation of all the options please
# reade README.rst.

set(ARDUINO_DEFAULT_BOARD teensy31) # Default Board ID, when not specified
set(ARDUINO_DEFAULT_PORT /dev/ttyUSB0) # Default Port, when not specified
set(TEENSY_SPEED_MODE 96opt)
set(TEENSY_KEYBOARD_MODE fr-fr)
set(TEENSY_USB_MODE serialhid)


#====================================================================#
# Advanced firwmare example
#====================================================================#
generate_arduino_firmware(strandtest
    SRCS strandtest.cpp
    BOARD teensy31)
