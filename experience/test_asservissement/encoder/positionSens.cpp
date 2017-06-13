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
unsigned int last_value = 0,last_value_a=0,last_value_b=0;     // Compteur de tick de la codeuse
unsigned int a_rising_time=0,b_rising_time=0;
int tick=0;
int last_tick=0;
void measurePosition();
void risingA();
int print=0;

/* Routine d'initialisation */
void setup() {
  Serial.begin(9600);
  pinMode(_PHASE_A, INPUT); 
  Serial.println("Setup Position reading");
  attachInterrupt(_PHASE_B, risingA, RISING);    // Interruption sur tick de la codeuse
}

/* Fonction principale */
void loop(){
  if(Serial.available() > 0) {
    print=Serial.read();
    Serial.print("Received input:");
    Serial.println(print);
    if(print!=97) {
      Serial.print("Estimated ppr:");
      Serial.println(tick/10);
    }
    tick=0;
    last_tick=0;

  }
  if(print==97 && last_tick!=tick) {   
    Serial.println(tick);
    last_tick=tick;
  }

}

void risingA() {
  unsigned int value = digitalRead(_PHASE_A);
  if(value == 0) { 
    tick++;
  } else {
    tick--;
  }
  tick%=341;
}
