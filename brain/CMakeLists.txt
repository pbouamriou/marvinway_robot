cmake_minimum_required(VERSION 2.8)

set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/scripts/cmake/teensy-arm.toolchain.cmake")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/scripts/cmake)
set(BOARD_NAME "teensy32" CACHE STRING "Model of the Teensy Board")

include(UseCxx11)

project(Brain C CXX)

use_cxx11()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/bin")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/lib")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/lib")
set(TEENSY_USB_MODE SERIAL)

add_teensy_executable(Brain 
	src/main.cpp)

configure_teensy_upload(Brain ${BOARD_NAME}) 

