#=============================================================================#
# Author: QueezyTheGreat                                                      #
# Date:   26.04.2011                                                          #
#                                                                             #
# Description: Arduino CMake example                                          #
#                                                                             #
#=============================================================================#
set(CMAKE_TOOLCHAIN_FILE ../cmake/ArduinoToolchain.cmake) # Arduino Toolchain


cmake_minimum_required(VERSION 2.8)
#====================================================================#
#  Setup Project                                                     #
#====================================================================#
project(mpu6050 C CXX)

print_board_list()
print_programmer_list()

add_subdirectory(MPU6050_calibration)   #add the calibration into build
add_subdirectory(MPU6050_DMP6)   #add the dmp6 into build
