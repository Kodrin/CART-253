//////////////////////////////////////////////////////////////////////////////////////////////
/*
The tactile bug class is the autonomous agent that reacts to the mouse input of the user.
It follows the mouse.
*/
//////////////////////////////////////////////////////////////////////////////////////////////
class TactileBug {
  
  //variables for the AA
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  int rectWidth = 10;
  int rectHeight = 10;
  
  float x;
  float y;
  
  //Constructor for the bug
  TactileBug(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    r = 3.0;
    maxspeed = 4;
    maxforce = 0.1;
  }
 
  //adds accelerationa and velocity while limiting it to the maximum speed variable
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }
 
 //applies force to the object
  void applyForce(PVector force) {
    acceleration.add(force);
  }
 
 //we use reynold's equation of steering to get our desired vector/direction to push along, we also normalize everything to 1 so everything travels a the same speed
  void seek(PVector target) {
    PVector desired = PVector.sub(target,location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
 
 //specifies the display and rotation(theta) of the objects
  void display() {
    float theta = velocity.heading() + PI/2;
    noFill();
    stroke(0,255,0);
    rect(location.x,location.y, rectWidth, rectHeight);
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    popMatrix();
  }
}