import controlP5.*;
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player;
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


void setup() {
  
  size(800, 550);
  frameRate(speed);
  noStroke();
  smooth();
  

  minim = new Minim(this);
  player = minim.loadFile("track1.mp3");
  input = minim.getLineIn();
  player.play();

  
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
  minim = new Minim(this); 
  player = minim.loadFile("track2.mp3"); 
  player.play(); }
  
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