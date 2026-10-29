//using memory address itself
#define PIN13 *((volatile byte*)0x25)
#define PORTB_REGISTER *((volatile byte*)0x24)
//volatile byte* portBData = 0x24;

void setup() {
  // put your setup code here, to run once:
  
  Serial.begin(9600);
  PORTB_REGISTER = 32;
  //DDRD |= 1 << (DDD7);
  //DDRD = 0b11111111; '
//  *portBData = 32;
}

void loop() {
  // put your main code here, to run repeatedly:
  //PORTD |= (1 << PORTD7); // PORTD = PORTD | 128 
  //volatile byte* memoryVer = 0x25;

  //*memoryVer = 32;

  //another version 

  //*((volatile byte*) 0x25) = 32;
  //PORTD = 0b11111111; 
  PIN13 = 32;
  delay(1000);
  //PORTD = 0b00000000;
  //*memoryVer = 0;
  //*((volatile byte*) 0x25) = 0;
  PIN13 = 0;
  delay(1000);
  
}
