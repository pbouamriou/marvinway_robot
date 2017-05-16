import_arduino_library(Wire)
add_teensy_executable(calibration main.cpp MPU6050.cpp MPU6050.h I2Cdev.h I2Cdev.cpp)
configure_teensy_upload(calibration mk20dx256)
