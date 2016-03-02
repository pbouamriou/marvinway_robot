#if ARDUINO >= 100
    #include "Arduino.h"
#else
    #include "WProgram.h"
#endif

#include <Servo.h> 

Servo myservo;  // create servo object to control a servo 
 
int pos = 0;
 
void setup() 
{ 
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
} 
 
void loop() 
{ 
  pos++;
  if(pos > 179) pos = 0;
  myservo.write(pos);                  
  delay(15);
} 
