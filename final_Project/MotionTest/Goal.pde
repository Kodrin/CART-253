class Goal {
  
 float x;
 float y;
 float vx;
 float vy;
 int size;
 color fillColor = color(255,255,0);
 int scoreCount = 0;

 Goal(int tempX, int tempY, int tempVX, int tempVY, int tempSize) {
   x = tempX;
   y = tempY;
   vx = tempVX;
   vy = tempVY;
   size = tempSize;
 }

void update(){
   x += vx;
   y += vy;
   
   if (x - size/2 < 0 || x + size/2 > width) {
    vx = -vx; 
   }
   
   if (y - size/2 < 0 || y + size/2 > height) {
    vy = -vy;
   }
   
   x = constrain(x,size/2,width-size/2);
   y = constrain(y,size/2,height-size/2);
}

void display(){
   fill(fillColor);
   ellipse(x,y,size,size);
   
   //score count
   pushStyle();
   fill(0);
   textSize(32);
   text(scoreCount, x,y);
   popStyle();
}

//void collideWithTactile (TactileBug other){
//   if(dist(x,y,other.location.x,other.location.y) < 10){
     
//   }
//}
}