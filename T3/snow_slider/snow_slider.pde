import controlP5.*;
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import processing.serial.*;
Serial myPort;  

Minim minim;
AudioPlayer track1;
AudioPlayer track2;
AudioInput input;
  
import processing.sound.*;
SoundFile file;

ControlP5 cp5;
int quantity = 300;
int speed = 100;
float [] xPosition = new float[quantity];
float [] yPosition = new float[quantity];
int [] flakeSize = new int[quantity];
int [] direction = new int[quantity];
int minFlakeSize = 1;
int maxFlakeSize = 5;

int playing = 0;


void setup() {
  
  printArray(Serial.list());

// Open the port you are using at the rate you want:
myPort = new Serial(this, Serial.list()[5], 9600);
  
  size(800, 550);
  frameRate(speed);
  noStroke();
  smooth();
  

  minim = new Minim(this);
  track1 = minim.loadFile("track1.mp3");
  track2 = minim.loadFile("track2.mp3");
  input = minim.getLineIn();
  track1.play();
  playing = 1;

  
  cp5 = new ControlP5(this);
  
  cp5.addSlider("speed")
     .setPosition(50,50)
     .setRange(30,500)
     ;
  
  for(int i = 0; i < quantity; i++) {
    flakeSize[i] = round(random(minFlakeSize, maxFlakeSize));
    xPosition[i] = random(0, width);
    yPosition[i] = random(0, height);
    direction[i] = round(random(0, 1));
  }
  
}

void draw() {
  
  background(0);
  println(quantity);
  
  //HERE IS WHERE THE PROBLEM STARTS
  
  if(speed> 150) { 
    if (playing != 2) {
      track1.pause();
      track2.play();
      playing = 2;
      myPort.write(10);
      
    }
  } else {
     if (playing != 1) {
      track2.pause();
      track1.play();
      playing = 1;
      myPort.write(200);
    }
  }  
  
  for(int i = 0; i < xPosition.length; i++) {
    
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