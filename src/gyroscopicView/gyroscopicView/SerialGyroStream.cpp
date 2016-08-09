//
// SerialGyroStreaam.cpp
//
#include "SerialGyroStream.h"

float SerialGyroStream::mYaw = .0;
float SerialGyroStream::mRoll = .0;
float SerialGyroStream::mPitch = .0;

void SerialGyroStream::timer(int value) {
    const int desiredFPS=60;
    glutTimerFunc(1000/desiredFPS, timer, ++value);

	glutPostRedisplay(); // initiate display() call at desiredFPS rate
}

void SerialGyroStream::read_port(void) {
    serial::Serial serial("/dev/ttyACM0",38400,serial::Timeout::simpleTimeout(1000));

    cout << "Is the serial port open?";
    if(serial.isOpen()) {
        cout << " Yes." << endl;
        while(true) {
            string data=serial.readline();
            cout << data;
            //send a char
            if(data.find("Send any character")!=string::npos) {
                cout << "send c";
                serial.write("c");
            }
            if(data.find("euler")!=string::npos) {
                // delimiter
                string delimiter= "\t";
                string tokens[4] = {};
                int i=0;
                size_t pos=0;
                while((pos = data.find(delimiter))!=string::npos && i<4) {
                    tokens[i] = data.substr(0,pos);
                    data.erase(0, pos + delimiter.length());
                    i++;
                }
                tokens[3] = data.substr(0,data.length()-1);
                mYaw=stof(tokens[3]);
                mPitch=stof(tokens[1]);
                mRoll=stof(tokens[2]);
            }
        }
    } else
        cout << " No." << endl;
    if(serial.isOpen()) {
        serial.close();
    }
}


void SerialGyroStream::init() {
    pReadThread = new thread(read_port);
    glutTimerFunc(0,this->timer,0);
}

void SerialGyroStream::stop() {
    pReadThread->join();
    delete[] pReadThread;
}

SerialGyroStream::SerialGyroStream() {
    mYaw=0;
    mPitch=0;
    mRoll=0;
}

float SerialGyroStream::yaw() {
    return mYaw;
}

float SerialGyroStream::pitch() {
    return mPitch;
}

float SerialGyroStream::roll() {
    return mRoll;
}
