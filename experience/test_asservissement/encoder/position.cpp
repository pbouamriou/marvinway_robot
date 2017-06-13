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
const unsigned int REF_SIG=200;
unsigned int last_value = 0;     // Compteur de tick de la codeuse
int time,current_time;
int tick=0;
void measurePosition();

/* Routine d'initialisation */
void setup() {
  Serial.begin(9600);
  pinMode(_PHASE_A, INPUT); 
  Serial.println("Setup Position reading");
}

/* Fonction principale */
void loop(){
  measurePosition();
}

/* Interruption sur tick de la codeuse */
void measurePosition(){
  unsigned int value = analogRead(_PHASE_A);
  if(value > REF_SIG) {
    value=1;
  } else {
    value = 0;
  }
  if(last_value == 0 && value == 1) {
    if(tick<342) {
      tick++;
    }else {
      tick=0;
    }
    Serial.println(tick);
  }
  last_value=value;
}
