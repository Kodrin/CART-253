class VoiceBug {
  float x;
  float y;
  float vx;
  float vy;
  float size = 10;
  float gravity = 0.98;
  float bounce = -1;
  
VoiceBug() {
    x= width/2;
    y= 100;
}
void update (){
   val = level * 1.5;
   pushStyle();
   rect(x, y,size,size);
   fill(255,20,20);
   rectMode(CENTER);
   popStyle();
   
  vy += gravity;
  y += vy * val;
    if(y > height - 5)
  {
    vy *= bounce;
  }
}
}