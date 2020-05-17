import controlP5.*;
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import processing.serial.*;
Serial myPort;  

Minim minim;
AudioPlayer track[] = new AudioPlayer[4];
AudioInput input;
  
import processing.sound.*;
SoundFile file;
import controlP5.*;

ControlP5 cp5;
int quantity = 1000;
int speed = 30;
float [] xPosition = new float[quantity];
float [] yPosition = new float[quantity];
int [] flakeSize = new int[quantity];
int [] direction = new int[quantity];
int minFlakeSize = 1;
int maxFlakeSize = 5;

int playing = -1;
int b;

void setup() {
  
  printArray(Serial.list());

  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[5], 9600);
  
  size(800, 550);
  //fullScreen();
  frameRate(speed);
  noStroke();
  smooth();
  

  minim = new Minim(this);
  track[0] = minim.loadFile("nanny.mp3");
  track[1] = minim.loadFile("harry.mp3");
  track[2] = minim.loadFile("cola.mp3");
  track[3] = minim.loadFile("blizzard.mp3");
  input = minim.getLineIn();
  
  cp5 = new ControlP5(this);
  
 PFont p = createFont("Sprat",20); 
 ControlFont font = new ControlFont(p);
   
  cp5.addSlider("speed")
     .setPosition(50,50)
     .setRange(25,280)
     .setSize(200,30)
     .setCaptionLabel("SCHNEE")
     .setFont(font)
     .setColorValue(color(255))
     .setColorActive(color(255,0,0))
     .setColorForeground(color(255,0,0))
     .setColorBackground(color(110, 40, 165))
     ;
  //cp5.addSlider("quantity")
  //   .setPosition(50,80)
  //   .setRange(50,800)
  //   .setColorValue(color(255))
  //   .setColorActive(color(255,0,0))
  //   .setColorForeground(color(255,0,0))
  //   .setColorBackground(color(110, 40, 165))
  //   ;
     
  //float value = cp5.getController("quantity").getValue();;
  //cp5.getController("quantity").setValue(value);
  
  for(int i = 0; i < quantity; i++) {
    flakeSize[i] = round(random(minFlakeSize, maxFlakeSize));
    xPosition[i] = random(0, width);
    yPosition[i] = random(0, height);
    direction[i] = round(random(0, 1));
  }
}

void draw() {  
  background(0);

  b = speed - 25;
  if (b<0) b=0;
  if (b>255) b=255;
  myPort.write((byte)b);
  
  int newplaying = -1;  
  if(speed < 75) 
    newplaying = 0;
  else if (speed < 150)
    newplaying = 1;
  else if (speed < 255)
    newplaying = 2;
  else 
    newplaying = 3;
    
  if (newplaying != playing) {
    if (playing != -1) 
        track[playing].pause();
    playing = newplaying;
    if (playing != -1) 
        track[playing].play();
    }
  
  
  for(int i = 0; i < speed*2; i++) {
    
    ellipse(xPosition[i], yPosition[i], flakeSize[i], flakeSize[i]);
    
    if(direction[i] == 0) {
      xPosition[i] += map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
    } else {
      xPosition[i] -= map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
    }
    
    yPosition[i] += flakeSize[i] + direction[i]; 
    
    if(xPosition[i] > width + flakeSize[i] || xPosition[i] < -flakeSize[i] || yPosition[i] > height + flakeSize[i]) {
      xPosition[i] = random(0, width);
      yPosition[i] = -flakeSize[i];
    }
    
  }
  
  frameRate(speed);
  
}