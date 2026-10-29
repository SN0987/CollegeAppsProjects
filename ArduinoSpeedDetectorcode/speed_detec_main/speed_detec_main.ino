#include <LiquidCrystal.h>
#include <SR04.h>

const int leftButton=2;
const int rightButton=6;

const int sensorTrigger=3;

const int sensorEcho=5;



LiquidCrystal lcd(7, 8, 9, 10, 11, 12);


SR04 sensor = SR04(sensorEcho,sensorTrigger);

long distance;


int page = 1;

float amountOfDistance=0;


int readAddButton;

float second=0;

int time;


float speed = 0;




void reset() {
  time = 0;
  second = 0;
  page = 1;
  amountOfDistance = 0;
  distance = 0;
  speed = 0;
}



float calculateSpeed(float second,float amountOfDistance) {
  return (float)amountOfDistance/second;
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  lcd.begin(16,2);


  pinMode(leftButton,INPUT_PULLUP);
  pinMode(rightButton,INPUT_PULLUP);
}

void loop() {
  // put your main code here, to run repeatedly:


  if(page == 1) {
    lcd.clear();
    lcd.setCursor(4,0);
    lcd.print("Welcome:");
    lcd.setCursor(6,1);
    lcd.print("user");

    if(digitalRead(rightButton) == LOW) {
      page++;
  

    }
  }
 
  

  if(page == 2) {
    lcd.clear();
    lcd.setCursor(0,0);
    lcd.print("Select Distance:");
    lcd.setCursor(6,1);
    lcd.print(amountOfDistance);
    lcd.setCursor(8,1);
    lcd.print("FT");


    delay(60);
    readAddButton = digitalRead(rightButton);

    if(readAddButton == 0) {

      if(amountOfDistance < 9) {
        amountOfDistance++;
      } else {
        amountOfDistance = 9;
      }
      
    }

    if(digitalRead(leftButton) == LOW) {
      page++;
    }
  
  }

  if(page == 3) {
    lcd.clear();

    lcd.setCursor(5,0);
    lcd.print("Time:");
    
    lcd.setCursor(5,1);
    lcd.print("seconds");

    lcd.setCursor(1,1);

    time++;
    if(time >= 8) {
      second++;
      time = 0;
    }
  
    lcd.print((int)second);
    

    if(second >= 120) {
      page = 1;
      reset();
    }

    distance = sensor.Distance();
    if(distance <= 10) { 
      page++;
      speed = calculateSpeed(second,amountOfDistance);
    }



    
  }

  if(page == 4) { 
    lcd.clear();
    lcd.setCursor(5,0);
    lcd.print("Speed:");
    lcd.setCursor(4,1);
    lcd.print(speed);
    lcd.setCursor(9,1);
    lcd.print("fpm");

    delay(8000);
    reset();
  }

  lcd.setCursor(15,1);
  lcd.print(page);

  delay(1000/17);

}
