import ddf.minim.*;
Minim minim;
AudioInput mic; // The class that lets us get at the microphone

SketchLoops[] sketchloops = new SketchLoops[10];

float amount = 20;

float level;
float val;

void setup() {
  size(800,800);
  minim = new Minim(this);
  // We use minim.getLineIn() to get access to the microphone data
  mic = minim.getLineIn();
  
  for (int i = 0; i < sketchloops.length; i++){
    sketchloops[i] = new SketchLoops();
  }
}

void draw() {
  background(0);
  rectMode(CENTER);
  // Get the current level (volume) going into the microphone
  level = mic.mix.level();
  // Draw a rectangle with dimensions defined by microphone level
  rect(width/2, height/2, width * level, height * level);
  noFill();
  stroke(255);
  
  val = level * 1000;
  println(val);
  
  for (int i = 0; i < sketchloops.length; i++){
    sketchloops[i].update();
  }
  
}