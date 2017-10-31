// Particle system with an array

//calls the  particlenorm class to index particles into an array
Particlenorm[] particlenorm = new Particlenorm[20];

void setup() {
  size(640,480);
  
  //loops through the array in order to instantiate the particles
  for (int i = 0; i < particlenorm.length; i++){
    particlenorm[i] = new Particlenorm();
  }
}


void draw() {
  background(50);
  
  //loops through the array again to call the update and display function of the particles
  for (int i = 0; i < particlenorm.length; i++){
    particlenorm[i].update();
    particlenorm[i].display();
  }
}