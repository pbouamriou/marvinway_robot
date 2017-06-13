add_teensy_executable(risingEdge risingEdge.cpp)
configure_teensy_upload(risingEdge mk20dx256) #Teensy 3.1
add_teensy_executable(speed speed.cpp)
configure_teensy_upload(speed mk20dx256) #Teensy 3.1
add_teensy_executable(position position.cpp)
configure_teensy_upload(position mk20dx256) #Teensy 3.1
add_teensy_executable(positionSens positionSens.cpp)
configure_teensy_upload(positionSens mk20dx256) #Teensy 3.1
add_teensy_executable(speed_control speed_control.cpp)
configure_teensy_upload(speed_control mk20dx256) #Teensy 3.1
