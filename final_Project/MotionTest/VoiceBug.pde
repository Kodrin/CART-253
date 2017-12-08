class VoiceBug {
  //variables for movement without AA
  
  // Default values for speed and size
  int SPEED = 5;
  int SIZE = 16;
  // The velocity of the voicebugs
  int vx = 4;
  int vy;
  //creating an Y offset for the noise function
  float yoff = random(0,100);
  
  //variables for the AA
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  int rectWidth = 10;
  int rectHeight = 10;
  
  //voice variables
  float voiceThreshold = 5;
  
  
  VoiceBug(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    r = 3.0;
    maxspeed = 4;
    maxforce = 0.1;
  }
  
  boolean voiceIsPresent(){
    if(val > voiceThreshold){
      return true;
    } else{
      return false;
    }
  }
 
  void update() {
    val = level * 255;
    //println(val);
    //if statement here
    if(voiceIsPresent() == true){
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
    seek(new PVector(lerpX, lerpY));
    } else{
    location.x += vx;
    location.y += vy;

    if (location.x < 0 || location.x > width) {
      // If it is, then make it "bounce" by reversing its velocity
      vx = -vx;
    }
    if (location.y < 0 || location.y > height) {
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
    }
    
    }
  }
 
  void applyForce(PVector force) {
    acceleration.add(force);
  }
 
  void seek(PVector target) {
    PVector desired = PVector.sub(target,location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
 
  void display() {
    float theta = velocity.heading() + PI/2;
    fill(255,0,0);
    stroke(0);
    //calling the noise function
    yoff = yoff +.01; 
    float n = noise(yoff)*height;
    
    //if the the voice is detected apply the noise to the rectangles
    if(voiceIsPresent() == true){
      rect(location.x,location.y, rectWidth, rectHeight);
    } else{
      rect(location.x,location.y = n, rectWidth, rectHeight);
    }
    
    //translation and roation
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    popMatrix();
  }
}