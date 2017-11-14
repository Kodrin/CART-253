import ddf.minim.*;
Minim minim;
AudioInput mic; // The class that lets us get at the microphone
//creates an array of sketch loops
SketchLoops[] sketchloops = new SketchLoops[10];

float amount = 10;

float level;
float val;

void setup() {
  size(800,800);
  minim = new Minim(this);
  // We use minim.getLineIn() to get access to the microphone data
  mic = minim.getLineIn();
  //loops to create more sketch loops
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
  line(0, height/2, width, height/2);
  stroke(255);
  
  //val = level * 255;
  println(val);
  
  //calls the update function for each sketchloop in the array
  for (int i = 0; i < sketchloops.length; i++){
    //sketchloops[i].fillColor *= val;
    sketchloops[i].update();
  }
  
  
}