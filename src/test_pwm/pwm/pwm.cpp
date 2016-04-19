#if ARDUINO >= 100
    #include "Arduino.h"
#else
    #include "WProgram.h"
#endif

#include <LiquidCrystal.h>
 
LiquidCrystal lcd(8, 9, 4, 5, 6, 7);

const int pwm = 3;
char strValue[10];

int pwmValue = 200;

enum LCD_KEY {
   LCD_KEY_RIGHT,
   LCD_KEY_LEFT,
   LCD_KEY_UP,
   LCD_KEY_DOWN,
   LCD_KEY_SELECT,
   LCD_KEY_NONE
};

LCD_KEY getKey() 
{
   int value = analogRead(0);
   Serial.print("Value = ");
   Serial.println(itoa(value, strValue, 10));
   if( value > 1000 ) return LCD_KEY_NONE;
   if( value > 900 ) return LCD_KEY_LEFT;
   if( value > 600 ) return LCD_KEY_DOWN;
   if( value > 300 ) return LCD_KEY_UP;
   if( value > 50 ) return LCD_KEY_SELECT;
   return LCD_KEY_RIGHT;
}

const char* getKeyString(LCD_KEY key)
{
   switch(key) {
   case LCD_KEY_UP:
      return "UP";
   case LCD_KEY_DOWN:
      return "DOWN";
   case LCD_KEY_RIGHT:
      return "RIGHT";
   case LCD_KEY_LEFT:
      return "LEFT";
   case LCD_KEY_SELECT:
      return "SEL";
   case LCD_KEY_NONE:
      return "";
   }

   return "";
}
 
void setup() 
{ 
   lcd.begin(16, 2);
   lcd.setCursor(0, 0);
   lcd.print("Duty cycle :");
   pinMode(LED_BUILTIN, OUTPUT);
   pinMode(pwm, OUTPUT);
   //analogWriteFrequency(pwm, 187500);
   analogWriteFrequency(pwm, 46875);
   digitalWrite(LED_BUILTIN, HIGH);
   Serial.begin(9600);
} 
 
void loop() 
{ 
   LCD_KEY key = getKey();
   switch( key ) {
   case LCD_KEY_UP :
      pwmValue++;
      if( pwmValue > 255 ) pwmValue = 255;
      break;
   case LCD_KEY_DOWN :
      pwmValue--;
      if( pwmValue < 0 ) pwmValue = 0;
      break;
   }
   analogWrite(pwm, pwmValue);
   lcd.setCursor(0,1);
   lcd.print("                ");
   lcd.setCursor(0,1);
   lcd.print(itoa(pwmValue, strValue, 10));
   lcd.setCursor(11,1);
   lcd.print(getKeyString(key));
   delay(100);
} 
