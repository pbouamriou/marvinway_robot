//
// SerialGyroStream.h
//
#ifndef DEF_SERIAL_GYRO_STREAM
#define DEF_SERIAL_GYRO_STREAM

#include "IGyroStream.h"
#include <GL/gl.h>
#include <GL/glut.h>
#include <iostream>
#include <thread>
//http://wjwwood.io/serial/doc/1.1.0/index.html
#include <serial/serial.h>
#include <string>

using namespace std;

class SerialGyroStream : public IGyroStream {
    public : 
        SerialGyroStream();
        float yaw();
        float roll();
        float pitch();
        void init();
        void stop();
        static void read_port();
        static void timer(int value);
    private :
        static float mYaw;
        static float mPitch;
        static float mRoll;
        thread* pReadThread;
};

#endif
