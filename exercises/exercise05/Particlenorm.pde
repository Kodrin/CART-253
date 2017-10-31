
//created a class for the main particles
class Particlenorm {
  
  //set the x,y and size properties to random values
  int x = floor(random(0,width));
  int y = floor(random(0,height));
  int size = floor(random(5,32));
  color fill = color(255);
  
  //created velocity, gravity and bounce variables
  float vy = 0;
  float gravity = 0.98;
  float bounce = -1;


  void update(){
    
    // the velocity of the particle is affecte by the gravity
    vy += gravity;
    y += vy;
  
    //if the particle hits the bottom of the screen, it bounces back off
    if(y > height - size/2){
      vy*= bounce;
    }  
  }
  
  void display(){
    // these functions draw the ellipse according to previous properties 
    fill(fill);
    noStroke();
    ellipse(x,y,size,size);
  }
}