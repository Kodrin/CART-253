class Particlenorm {
  
  int x = floor(random(0,width));
  int y = floor(random(0,height));
  int size = floor(random(5,32));
  color fill = color(255);
  
  float vy = 0;
  float gravity = 0.98;
  float bounce = -1;


  void update(){
    vy += gravity;
    y += vy;
  
    if(y > height - size/2){
      vy*= bounce;
    }  
  }
  
  void display(){
    fill(fill);
    noStroke();
    ellipse(x,y,size,size);
  }
}