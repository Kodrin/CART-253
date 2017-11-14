import ddf.minim.*;
Minim minim;
AudioInput mic; // The class that lets us get at the microphone

float amount = 100;
void setup() {
  size(500,500);
  minim = new Minim(this);
  // We use minim.getLineIn() to get access to the microphone data
  mic = minim.getLineIn();
}
void draw() {
  background(0);
  rectMode(CENTER);
  // Get the current level (volume) going into the microphone
  float level = mic.mix.level();
  // Draw a rectangle with dimensions defined by microphone level
  rect(width/2, height/2, width * level, height * level);
  noFill();
  stroke(255);
  curve(0, height/2, 100, height/2 , 400, height/2 * level* amount, width, height/2);
}