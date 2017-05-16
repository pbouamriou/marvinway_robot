//
// KeyboardGyroStream.h
//
#ifndef DEF_KEYBOARD_GYRO_STREAM
#define DEF_KEYBOARD_GYRO_STREAM

#include "IGyroStream.h"
#include <GL/gl.h>
#include <GL/glut.h>

class KeyboardGyroStream : public IGyroStream {
    public : 
        KeyboardGyroStream();
        float yaw();
        float roll();
        float pitch();
        void init();
        void stop();

        static void timer(int value);
        static void keyPressed (unsigned char key, int x, int y);
        static void keyUp (unsigned char key, int x, int y); 

        static bool mIsYaw;
        static bool mIsPitch;
        static bool mIsRoll;
        static float mYaw;
        static float mRoll;
        static float mPitch;


    };


#endif
