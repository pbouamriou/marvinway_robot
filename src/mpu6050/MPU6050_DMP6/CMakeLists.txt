import_arduino_library(Wire)
add_teensy_executable(DMP6 main.cpp MPU6050.cpp MPU6050.h I2Cdev.cpp I2Cdev.h)
configure_teensy_upload(DMP6 mk20dx256)

