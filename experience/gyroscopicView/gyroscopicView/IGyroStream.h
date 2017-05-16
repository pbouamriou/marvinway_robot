//
// IGyroStream.h
//
#ifndef DEF_IGYRO_STREAM
#define DEF_IGYRO_STREAM
class IGyroStream {
    public: 
        // pure virtual function
        virtual float yaw() = 0;
        virtual float roll() = 0;
        virtual float pitch() = 0;
        virtual void init() = 0;
        virtual void stop() = 0;
};
#endif
