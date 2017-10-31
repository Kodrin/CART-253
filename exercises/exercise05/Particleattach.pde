//created a class for the attach particles
class Particleattach {
  
  //set the x,y and size properties to random values
  float x = (random(0,width));
  float y = (random(0,height));
  int size = floor(random(5,26));
  color fill = color(255,255,0);
  float range = 200;
  
  //created velocity, gravity and noise offset variables
  float vx = 0;
  float vy = random(-1,1);
  float xoff = random(0,100);

  void update(){
    
    y += vy;
    //if the particle hits the bottom of the screen, it bounces back off
    if(x > width - size/2 || x < 0 - size/2){
      vx = -vx;
    }  
    
    if(y > height - size/2 || y < 0 - size/2){
      vy = -vy;
    }  
  }
  
  void display(){
    // these functions draw the ellipse according to previous properties 
    fill(fill);
    xoff = xoff + .01;
    float n = noise(xoff) * width;
    ellipse(x = n, y,size,size);
  }
    // function that draws line between attach particles and normal particles
    void nextToNormal ( Particlenorm other) {
      if(dist(x,y, other.x, other.y) < range) {
        line(x,y, other.x, other.y);
      }
    }
}