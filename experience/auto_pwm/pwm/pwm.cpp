#if ARDUINO >= 100
    #include "Arduino.h"
#else
    #include "WProgram.h"
#endif
const int ledPin=13;
const int pwmPin = 3;
const int startPwm=127;
const int maxPwm=255;
const int minPwm=66;
const int pwmIt=5;
const int tickToKeepPwm=100;
int currentTick=0;
int direction=1;
bool keepPwm=false;
int pwmValue=startPwm;
 
void updatePwm() {
   if(pwmValue!=startPwm) {
   	analogWrite(pwmPin, pwmValue);
   }
}

/*
 * decrement pwmValue if pwmValue is greater than minPwm otherwise we put +1 to the direction
 */
void decrementPwm() {
   if(pwmValue>minPwm) {
   	pwmValue--;
   } else {
   	direction=1;
	keepPwm=true;
   }
}

/**
 * increment pwmValue if pwmValue is lesser than maxPwm otherwise we put -1 to the direction
 */
void incrementPwm() {
   if(pwmValue<maxPwm) {
   	pwmValue++;
   } else {
   	direction=-1;
	keepPwm=true;
   }
}

/**
 * put keepPwm to false when currentTick is greater than tickToKeepPwm 
 */
void waitPwm() {
  if(currentTick<tickToKeepPwm) {
	currentTick++;
  } else {
  	currentTick=0;
	keepPwm=false;
  }

}

/**
 * call depending of the direction either incrementPwm() if 1 or decrementPwm() if -1
 */
void varyPwm() {
   if(!keepPwm) {
	   switch(direction) {
		case 1:
			incrementPwm();
			break;
		case -1:
			decrementPwm();
			break;
		default:
			break;		
	   } 
   } else {
	waitPwm();	
   }
   updatePwm();
}

/**
 * Call varyPwm() and wait 10 milliseconds
 */
void delayPwm() { 
   int i=0;
   while(i<pwmIt) {
   	i++;
	varyPwm();
	delay(10);
   }
}

void setup() { 
   pinMode(pwmPin, OUTPUT);
   pinMode(ledPin, OUTPUT);
   //analogWriteFrequency(pwmPin, 187500);
   //analogWriteFrequency(pwm, 46875);
   Serial.begin(9600);
} 
 
void loop() { 
   digitalWrite(ledPin, HIGH);
   delayPwm();
   digitalWrite(ledPin, LOW);
   delayPwm();
} 

