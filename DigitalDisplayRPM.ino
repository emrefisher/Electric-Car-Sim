#include "SevSeg.h"

SevSeg sevseg; //Initiate a seven segment controller object

void setup() {

byte numDigits = 4;

byte digitPins[] = {2, 3, 4, 5};

byte segmentPins[] = {6, 7, 8, 9, 10, 12, 11, 13};
sevseg.begin(COMMON_CATHODE, numDigits, digitPins, segmentPins);

sevseg.setBrightness(90);


}

void loop() {
int RPM = 1234;

//where the RPM Value is set
sevseg.setNumber(RPM, 0);

sevseg.refreshDisplay(); // Must run repeatedly

}
