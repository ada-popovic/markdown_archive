
#define LED2 PA0
#define LED1 PA1

// the setup function runs once when you press reset or power the board
void setup() {
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);

  Serial.begin(115200);   // monitor
  Serial2.begin(9600);    // input from mac
}

int oldb = 0;
int oo = 0;
int b = 0;

void loop() {
    if (Serial2.available()) {
      b = Serial2.read();
      Serial.println(b);
      if (b < 0) b = 0;
      if (b > 255) b = 255;
      
      if (b != oldb) {
        oldb = b;

        // 0-125 warm dimming up, cold off
        // 126-230 warm 100, cold off
        // 230-end warm off, cold strobo
        if (b < 125) {
          int bb = 7 + b*2; // 5..255
          analogWrite(LED2, bb);      // warm
          analogWrite(LED1, 0);       // cold
        } else if (b < 230) {
          analogWrite(LED2, 255);     // warm
          analogWrite(LED1, 0);       // cold
        }
      }
    } else {
      delay(1);                       
    }
    
    if (oldb >= 230) {              // stobo effect
      delay(random(50, 300));       // dark
      analogWrite(LED2, 0);     
      analogWrite(LED1, 0);   
      
      delay(random(20, 100));       // flash
      analogWrite(LED2, 0);   
      analogWrite(LED1, 255);
    }
    
} // loop()


