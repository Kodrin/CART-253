
Particlenorm[] particlenorm = new Particlenorm[20];

void setup() {
  size(640,480);
  
  for (int i = 0; i < particlenorm.length; i++){
    particlenorm[i] = new Particlenorm();
  }
}


void draw() {
  background(50);
  
  for (int i = 0; i < particlenorm.length; i++){
    particlenorm[i].update();
    particlenorm[i].display();
  }
}