#=============================================================================#
# Author: QueezyTheGreat                                                      #
# Date:   26.04.2011                                                          #
#                                                                             #
# Description: Arduino CMake example                                          #
#                                                                             #
#=============================================================================#
#set(CMAKE_TOOLCHAIN_FILE ../cmake/ArduinoToolchain.cmake) # Arduino Toolchain
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pedantic -Wextra")

cmake_minimum_required(VERSION 2.8) 
#====================================================================#
#  Setup Project                                                     #
#====================================================================#
project(gyroscopicView C CXX)

#print_board_list()
#print_programmer_list()
#set(HEADER_FILES 
#add_subdirectory(pwm)   #add the example directory into build
add_executable(gyroscopicView gyroscopicView/main.cpp gyroscopicView/KeyboardGyroStream.cpp gyroscopicView/SerialGyroStream.cpp)
add_definitions(-std=c++11)
find_package(OpenGL REQUIRED)
find_package(GLUT REQUIRED)
find_package(Threads REQUIRED)
if(THREADS_HAVE_PTHREAD_ARG)
    target_compile_options(PUBLIC gyroscopicView "-pthread")
endif()
include_directories( ${OPENGL_INCLUDE_DIRS}  ${GLUT_INCLUDE_DIRS} ${GLU_INCLUDE_DIRS})
#pthread is a bad solution it will work only on linux
#see http://stackoverflow.com/questions/1620918/cmake-and-libpthread
FIND_LIBRARY(SERIAL_LIBRARY serial /usr/local/lib/libserial.so)

if(CMAKE_THREAD_LIBS_INIT)
    target_link_libraries(gyroscopicView ${CMAKE_THREAD_LIBS_INIT} ${SERIAL_LIBRARY} ${OPENGL_LIBRARIES} ${GLUT_LIBRARY}
    ${GLU_LIBRARY})
else() 
  target_link_libraries(gyroscopicView ${SERIAL_LIBRARY} ${OPENGL_LIBRARIES} ${GLUT_LIBRARY}
  ${GLU_LIBRARY})
endif()
