#if ARDUINO >= 100
    #include "Arduino.h"
#else
    #include "WProgram.h"
#endif

#include <SPI.h> 

// AD7376 (Digital Potentiometre)
// PIN 10 ===> CS
// PIN 11 ===> DIN
// PIN 12 ===> DOUT
// PIN 13 ===> CLK

const int ad7376_cs = 10;

 
 
void setup() 
{ 
   pinMode( ad7376_cs, OUTPUT );
   pinMode( ad7376_cs, HIGH ); 

   SPI.begin();

   SPI.setBitOrder(MSBFIRST);
   SPI.setDataMode(SPI_MODE3);  //  Front montant
   SPI.setClockDivider(SPI_CLOCK_DIV64);

   Serial.begin(9600);
} 
 
void loop() 
{ 
   byte potValue = 32; // 5K
   for( potValue = 0; potValue < 128; ++potValue ) {
      digitalWrite( ad7376_cs, LOW ); // Enable CS
      SPI.transfer(potValue);
      digitalWrite( ad7376_cs, HIGH); // Disable CS
      Serial.print("Potentiometre positionne a ");
      Serial.println(potValue, DEC);
      delay(4000);
   }
}
