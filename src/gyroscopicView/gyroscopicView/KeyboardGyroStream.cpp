//
// KeyboardGyroStreaam.cpp
//
#include "KeyboardGyroStream.h"
#include <iostream>

bool KeyboardGyroStream::mIsYaw = false;
bool KeyboardGyroStream::mIsPitch = false;
bool KeyboardGyroStream::mIsRoll = false;
float KeyboardGyroStream::mYaw = .0;
float KeyboardGyroStream::mRoll = .0;
float KeyboardGyroStream::mPitch = .0;



void KeyboardGyroStream::timer(int value) {
    const int desiredFPS=60;
    glutTimerFunc(1000/desiredFPS, timer, ++value);

    if(mIsYaw) {
        mYaw+=1; // rotate by 1 degree every second
    }
    if(mIsPitch) {
        mPitch+=1;
    }
    if(mIsRoll) {
        mRoll+=1;
    }

	glutPostRedisplay(); // initiate display() call at desiredFPS rate
}

void KeyboardGyroStream::keyPressed(unsigned char key, int x, int y) {  
    //Activate Yaw Rotation
    if(key == 'y') {
        mIsYaw=true;
    }
    //Activate Pitch rotation
    if(key == 'p') {
        mIsPitch=true;
    }
    //Activate Roll rotation
    if(key == 'r') {
        mIsRoll=true;
    }
}

void KeyboardGyroStream::keyUp(unsigned char key, int x, int y) {  
    //Deactivate Yaw Rotation
    if(key == 'y') {
        mIsYaw=false;   
    }
    //Deactivate Pitch rotation
    if(key == 'p') {
        mIsPitch=false;
    }
    //Deactivate Roll rotation
    if(key == 'r') {
        mIsRoll=false;
    }
}

void KeyboardGyroStream::init() {
  glutTimerFunc(0,this->timer,0);
  glutKeyboardFunc(this->keyPressed);
  glutKeyboardUpFunc(this->keyUp);
}

void KeyboardGyroStream::stop() {
    //Do Nothing
}

KeyboardGyroStream::KeyboardGyroStream() {
    mYaw=0;
    mPitch=0;
    mRoll=0;
    mIsYaw=false;
    mIsPitch=false;
    mIsRoll=false;
}
float KeyboardGyroStream::yaw() {
    return mYaw;
}

float KeyboardGyroStream::pitch() {
    return mPitch;
}

float KeyboardGyroStream::roll() {
    return mRoll;
}

 


