//This value specifies where in the ellipse orbit
//your object is, from 0 to 2*PI
float val;

//The speed your object moves at along the orbit
float speed = 0.05;
int rotationSpeed = 0;

void setup(){
  size(500, 500);
}

void draw(){
  background(100);
  
  //Calculate x and y as values between -1 and 1
  //Search wikipedia for sinus and cosinus if this is unclear :)
  float x = sin(val);
  float y = cos(val);
  
  //Multiply x and y by the ellipses width (100) and height (500)
  x *= 100;
  y *= 100;
  
  //Move the centrepoint of the ellipse orbit where you want it
  x+= width/2;
  y+= height/2;
  
  //Draw your object!
  pushStyle();
  fill(255);
  rectMode(CENTER);
  rect(x, y, 20, 20);
  popStyle();
  
  //Update the value
  if (keyPressed == true) {
    val += speed;
  } else {
    val -= speed;
  }


  
  contourEllipse();
}

void contourEllipse() {
  ellipse(width/2, height/2, 200, 200);
  noFill();

  strokeWeight(1);
}