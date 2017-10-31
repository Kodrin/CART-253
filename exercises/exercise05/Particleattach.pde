//created a class for the attach particles
class Particleattach {
  
  //set the x,y and size properties to random values
  float x = (random(0,width));
  float y = (random(0,height));
  int size = floor(random(5,16));
  color fill = color(255,255,0);
  float range = 200;
  
  //created velocity, gravity and bounce variables
  float vx = 0;
  float vy = 0;
  float xoff = 0.0;

  void update(){
    //if the particle hits the bottom of the screen, it bounces back off
    if(x > width - size/2 || x < 0 - size/2){
      //vx*= bounce;
      //vx*= time;
      //vx = -vx;
    }  
    
    if(y > height - size/2 || y < 0 - size/2){
      //vy*= bounce;
      //vy*= time;
      //vy = -vy;
    }  
  }
  
  void display(){
    // these functions draw the ellipse according to previous properties 
    fill(fill);
    //noStroke();
    
    xoff = xoff + .01;
    float n = noise(xoff) * width;
    ellipse(x = n, y,size,size);
  }
  
    void nextToNormal ( Particlenorm other) {
      if(dist(x,y, other.x, other.y) < range) {
        line(x,y, other.x, other.y);
      }
    }
}