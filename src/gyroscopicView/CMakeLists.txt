#=============================================================================#
# Author: QueezyTheGreat                                                      #
# Date:   26.04.2011                                                          #
#                                                                             #
# Description: Arduino CMake example                                          #
#                                                                             #
#=============================================================================#
#set(CMAKE_TOOLCHAIN_FILE ../cmake/ArduinoToolchain.cmake) # Arduino Toolchain


cmake_minimum_required(VERSION 2.8)
#====================================================================#
#  Setup Project                                                     #
#====================================================================#
project(gyroscopicView C CXX)

#print_board_list()
#print_programmer_list()

#add_subdirectory(pwm)   #add the example directory into build
add_executable(gyroscopicView gyroscopicView/main.c)
find_package(OpenGL REQUIRED)
find_package(GLUT REQUIRED)
include_directories( ${OPENGL_INCLUDE_DIRS}  ${GLUT_INCLUDE_DIRS} ${GLU_INCLUDE_DIRS})

target_link_libraries(gyroscopicView ${OPENGL_LIBRARIES} ${GLUT_LIBRARY} ${GLU_LIBRARY})
