Snow[] flakes = new Snow[300];
Building b;

void setup() {
  size (500, 900);
  for (int i = 0; i<flakes.length; i++) { 
    flakes[i] = new Snow(random(2, 6));
    flakes[i].spreadY(i);
  }
}
void draw() {
  background(0); 
  for (int i = 0; i < flakes.length; i++) {
    flakes[i] .display();
  if (flakes[i].x > 500 && flakes[i].y >5 && flakes[i].x<400){
    flakes[i].bounce();  
  }
  }
  }




class Snow {
  float x; 
  float y;
  float alpha;
  float diameter;
  float speed = random(.7, 2);


  Snow (float tempD) {
    x = random(0, width);
    y = random(0,40);
    diameter = tempD;
  }
  
  void spreadY(int i) {
    y = y - i*3;
  }
  
  void display() {
    alpha = map(y, 0, height, 255, 0);
    noStroke();
    fill(255, alpha);
    ellipse(x, y, diameter, diameter);
    y = y + speed;
    
    //checking the boundary
    if (y > height) {
      y = -diameter;
    }
    if (x < 0) {
      x = width+diameter;} 
      else if (x > width+50){
      x = 0-diameter;
    }
    
    }
  void bounce(){
    y = y - speed; 
}
}
  


class Building {
  float x = 0;
  float y = 0;
  int width = 0;
  int height = 0;
  void display() {
    stroke(255);
    strokeWeight(2);
    noFill();
    rectMode(RADIUS);
  }
}