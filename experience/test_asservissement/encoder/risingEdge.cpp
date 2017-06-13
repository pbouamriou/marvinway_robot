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

const int _PHASE_B = 14;
const int _PHASE_A = 15;
const unsigned int REF_SIG=200;
unsigned int codeuseA = 0;     // Compteur de tick de la codeuse
unsigned int codeuseB = 0;     // Compteur de tick de la codeuse

void compteurA();
void compteurB();

/* Routine d'initialisation */
void setup() {
  Serial.begin(9600);
  pinMode(_PHASE_A, INPUT); 
  pinMode(_PHASE_B, INPUT);
  Serial.println("init interupt A");

  attachInterrupt(_PHASE_A, compteurA, CHANGE);    // Interruption sur tick de la codeuse
  attachInterrupt(_PHASE_B, compteurB, CHANGE);    // Interruption sur tick de la codeuse

}

/* Fonction principale */
void loop(){
  delay(10);
  //Serial.println("Yo");
}

/* Interruption sur tick de la codeuse */
void compteurA(){
  unsigned int value = analogRead(_PHASE_A);  // On incrémente le nombre de tick de la codeuse
  if(value > REF_SIG) {
    value=1;
  } else {
    value = 0;
  }
  if(codeuseA == 0 && value == 1) {
    Serial.println("A");
  }
  codeuseA=value;
}

void compteurB(){
  unsigned int value = analogRead(_PHASE_B);  // On incrémente le nombre de tick de la codeuse
  if(value > REF_SIG) {
    value=1;
  } else {
    value = 0;
  }
  if(codeuseB == 0 && value == 1) {
    Serial.println("B");
  }
  codeuseB=value;
}

