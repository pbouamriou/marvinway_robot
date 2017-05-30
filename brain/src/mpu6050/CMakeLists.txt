# CMakeLists files for brain-mpu6050

file(
   GLOB_RECURSE
   SRC_FILES
   *.cpp
)

file(
   GLOB_RECURSE
   HEADER_FILES
   include/*.h
   include/*.hpp
   private_include/*.h
   private_include/*.hpp
)

add_library(
brain-mpu6050
${SRC_FILES}
${HEADER_FILES}
)

import_arduino_library(Wire)

include_directories(
)
