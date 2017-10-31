
//created a class for the main particles
class Particlenorm {
  
  //set the x,y and size properties to random values
  float x = (random(0,width));
  float y = (random(0,height));
  int size = floor(random(1,32));
  color fill = color(255);
  
  //created velocity, gravity and bounce variables
  float vx = 0;
  float vy = 0;
  float gravity = random(0,0.008);
  float bounce = -1;
  float time = 0.8;

  void update(){
    
    // the velocity of the particle is affecte by the gravity
    //vx += gravity;
    //x += vx;
    
    vy += gravity;
    y += vy;
  
    //if the particle hits the bottom of the screen, it bounces back off
    if(x > width - size/2 || x < 0 - size/2){
      //vx*= bounce;
      //vx*= time;
      //vx = -vx;
    }  
    
    if(y > height - size/2 || y < 0 - size/2){
      vy*= bounce;
      //vy*= time;
      //vy = -vy;
    }  
  }
  
  void display(){
    // these functions draw the ellipse according to previous properties 
    pushStyle();
    noFill();
    //noStroke();
    ellipse(x,y,size,size);
    popStyle();
  }
}