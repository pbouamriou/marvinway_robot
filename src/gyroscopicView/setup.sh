#sudo apt-get install python-pip
#sudo pip install -U catkin_tools
bash
git clone https://github.com/wjwwood/serial.git
cd serial
#if you want to install it in /usr/local you have to comment makefile CMAKE_INSTALL_PREFIX
make install_deps
make
sudo make install
