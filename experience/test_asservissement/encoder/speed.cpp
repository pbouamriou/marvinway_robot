/*
   Blink
   Turns on an LED on for one second, then off for one second, repeatedly.
   Example uses a static library to show off generate_arduino_library().

   This example code is in the public domain.
 */
#if ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif

const int _PHASE_A = 15;
const int _PHASE_B = 14;
unsigned int last_value = 0;     // Compteur de tick de la codeuse
unsigned long last_tick=0,tick=0;
unsigned long last_time=0,time=0;
int turn,last_turn=0;
void measurePosition();
void risingB();
int print=0;

/* Routine d'initialisation */
void setup() {
  Serial.begin(9600);
  pinMode(_PHASE_A, INPUT); 
  Serial.println("Setup Position reading");
  pinMode(LED_BUILTIN,OUTPUT);
  digitalWrite(LED_BUILTIN,HIGH);
  attachInterrupt(_PHASE_B, risingB, RISING);    // Interruption sur tick de la codeuse
}

/* Fonction principale */
void loop(){
  if(Serial.available() > 0) {
    print=Serial.read();
    Serial.print("Received input:");
    Serial.println(print);
    tick=0;
    turn=0;
    last_turn=0;

  }
  turn=tick/371;
  time=millis();
  if(print==97 && time-last_time>1000) {   
    Serial.print("turns: ");
    Serial.println(turn);
    Serial.print("time: ");
    Serial.println(millis()/60000.0);
    Serial.print("mean rpm: ");
    Serial.print(tick*161.725/millis());
    Serial.println("rpm");
    Serial.print("instant rpm: ");
    time=millis();
    Serial.print((tick-last_tick)*161.725/(time-last_time));
    Serial.println("rpm");
    last_tick=tick;
    last_time=time;
    last_turn=turn;
  }
  
}

void risingB() {
  unsigned int value = digitalRead(_PHASE_A);
  if(value == 0) { 
    tick++;
  } else {
    tick--;
  }
  //tick%=341;
}
