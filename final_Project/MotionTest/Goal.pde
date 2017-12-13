//////////////////////////////////////////////////////////////////////////////////////////////
/*
the goal class is represented by the yellow ellipse that floats around.
it keeps track of the score everytime an autonomous agent particle collide with it
*/
//////////////////////////////////////////////////////////////////////////////////////////////
class Goal {
 
 //variables for x y position, size and velocity
 float x;
 float y;
 float vx;
 float vy;
 int size;
 color fillColor = color(255,255,0);
 
 //scorecount and maximum possible score
 int scoreCount = 0;
 int maxScore = totalVehicles + totalVoiceBugs + totalTactileBugs;

 //goal constructor with parameters
 Goal(int tempX, int tempY, int tempVX, int tempVY, int tempSize) {
   x = tempX;
   y = tempY;
   vx = tempVX;
   vy = tempVY;
   size = tempSize;
 }

void update(){
   //basic movement and collision similar to the bouncer exercises
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
   //display the ellipse along with the actual score count 
   noFill();
   stroke(fillColor);
   //fill(fillColor);
   ellipse(x,y,size,size);
   
   //score count
   pushStyle();
   fill(fillColor);
   textSize(32);
   text(scoreCount, x,y);
   popStyle();
}

void gameOver(){
   // WINNING CONDITION pauses the game when the player picks up the total amount of particles
   if (scoreCount >= maxScore) {
      textSize(64);
      textAlign(CENTER, CENTER);
      text("YOU WIN", width/2, height/2); 
      frameRate(0);
   }
}
}