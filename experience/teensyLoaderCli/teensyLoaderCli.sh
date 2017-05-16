git clone https://github.com/PaulStoffregen/teensy_loader_cli.git
cd teensy_loader_cli
sudo apt-get install libusb-dev
make
sudo cp teensy_loader_cli /opt/arduino-1.6.7/hardware/tools/
