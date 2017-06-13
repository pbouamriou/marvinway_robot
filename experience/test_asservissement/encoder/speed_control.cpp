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
const int _PWM=23;
const int _FORWARD=22;
const int _BACKWARD=21;

unsigned int last_value = 0;     // Compteur de tick de la codeuse
unsigned long last_tick=0,tick=0;
unsigned long last_time=0,time=0;
int turn=0,last_turn=0;
unsigned int motor_pwm=80;
bool start=false,measure=false;
void control_pwm(int pwm);
void display_speed();
void risingB();

int input=0;

/* Routine d'initialisation */
void setup() {
  Serial.begin(9600);
  pinMode(_PWM, OUTPUT);
  pinMode(_FORWARD,OUTPUT);
  pinMode(_BACKWARD,OUTPUT);
  pinMode(_PHASE_A, INPUT); 
  
  control_pwm(motor_pwm);
  Serial.println("Setup Position reading");
  digitalWrite(LED_BUILTIN,HIGH);
  digitalWrite(_FORWARD,LOW);
  digitalWrite(_BACKWARD,LOW);
  attachInterrupt(_PHASE_B, risingB, RISING);    // Interruption sur tick de la codeuse
}

/* Fonction principale */
void loop() {
  display_speed();
}

void control_pwm(int pwm) {
  analogWrite(_PWM,pwm);
}

void display_speed() {
  if(Serial.available() > 0) {
    input=Serial.read();
    Serial.print("Received input:");
    Serial.println(input);
    if(input==114) { 
      //r pressed
      tick=0;
      last_tick=0;
      last_time=millis();
      last_turn=0;
      turn=0;
    }
    if(input==115) {
      //s pressed
      digitalWrite(_FORWARD,LOW);
      digitalWrite(_BACKWARD,LOW);
    }
    if(input==43 && motor_pwm<255) {
      //+ pressed
      motor_pwm+=5;
      control_pwm(motor_pwm);
    }
    if(input==45 && motor_pwm>0) {
      motor_pwm-=5;
      control_pwm(motor_pwm);
    }
    if(input==109) {
      //m pressed
      measure=!measure;
    }
    if(input==98) {
      //f pressed
      digitalWrite(_FORWARD,HIGH);
      digitalWrite(_BACKWARD,LOW);
    }
    if(input==102) {
      //b pressed
      digitalWrite(_FORWARD,LOW);
      digitalWrite(_BACKWARD,HIGH);
    }
  }
  turn=tick/371;
  time=millis();
  if(measure && time-last_time>1000) {
    Serial.println("################");
    Serial.print("turns: ");
    Serial.println(turn);
    Serial.print("ticks: ");
    Serial.println(tick);
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
  //tick%=371;
}
