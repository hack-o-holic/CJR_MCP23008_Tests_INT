#include <Wire.h>
#include "Adafruit_MCP23008.h"

#define BUTTON_UP 0x01
#define BUTTON_DOWN 0x02
#define BUTTON_LEFT 0x04
#define BUTTON_RIGHT 0x08
#define BUTTON_SELECT 0x10
uint8_t button_pins[5];
bool BUTTONPRESSED = false;
//uint8_t readButtons();

// Basic pin reading and pullup test for the MCP23008 I/O expander
// public domain!

// Connect pin #1 of the expander to Analog 5 (i2c clock)
// Connect pin #2 of the expander to Analog 4 (i2c data)
// Connect pins #3, 4 and 5 of the expander to ground (address selection)
// Connect pin #6 and 18 of the expander to 5V (power and reset disable)
// Connect pin #9 of the expander to ground (common ground)

// Connect pin #10 to UP button
// Connect pin #11 to DOWN button
// Connect pin #12 to LEFT button
// Connect pin #13 to RIGHT button
// Connect pin #14 to SELECT button

// Input #0 is on pin 10 so connect a button or switch from there to ground

Adafruit_MCP23008 mcp;


void buttonPress()
{
	//check the buttons and clear the INT
	digitalWrite(13,HIGH);
	BUTTONPRESSED = true; // set flag so main loop knows
	//delay(70);
	//Serial.println("INTERRUPT!!!"); //for debugging
	
	
}

uint8_t readButtons(void) {
  uint8_t reply = 0x1F;

  for (uint8_t i=0; i<5; i++) {
    reply &= ~((mcp.digitalRead(button_pins[i])) << i);
  }
  return reply;
}

void handlebuttonPress (){
	delay(50);
	  BUTTONPRESSED = false;
	  digitalWrite(13, LOW);
uint8_t buttons = readButtons();
  if (buttons) {
    if (buttons & BUTTON_UP) {
      Serial.print("UP ");
    }
    if (buttons & BUTTON_DOWN) {
      Serial.print("DOWN ");
    }
    if (buttons & BUTTON_LEFT) {
      Serial.print("LEFT ");
    }
    if (buttons & BUTTON_RIGHT) {
      Serial.print("RIGHT ");
    }
    if (buttons & BUTTON_SELECT) {
      Serial.print("SELECT ");
    }
  }

}



void setup()
{
	button_pins[0] = 0;
	button_pins[1] = 1;
	button_pins[2] = 2;
	button_pins[3] = 3;
	button_pins[4] = 4;

  mcp.begin();      // use default address 0
      for (uint8_t i=0; i<5; i++) {
      mcp.pinMode(button_pins[i], INPUT);
      mcp.pullUp(button_pins[i], HIGH);  // turn on a 100K pullup internally
	  mcp.intOnPinChg(button_pins[i], HIGH);
    }

  //mcp.intOnPinChg(0,LOW);
  pinMode(12, INPUT);
  pinMode(13, OUTPUT);  // use the p13 LED as debugging
  Serial.begin(9600);
  attachInterrupt(0, buttonPress, FALLING);

}

void loop()
{
if (BUTTONPRESSED)
	handlebuttonPress();
	


  //for (uint8_t i=0; i<4; i++) {
	 // uint8_t state = mcp.digitalRead(i);
  //    digitalWrite(13, state);
	 // switch (state){
	 // case 0:
		//  	  Serial.print("Pin ");
	 // Serial.print(i);
		//  Serial.println(" is OFF");
		//  break;
		//  	  case 1:
		//	//	  	  Serial.print("Pin ");
	 // //Serial.print(i);
		// // Serial.println(" is ON");
		//  break;
	 // }
  //}


}
