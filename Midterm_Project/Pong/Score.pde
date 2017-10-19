// This class will track the score by representing an increasing ellipse in the center each time the ball resets
// It also sets the winning and losing conditions
class Score {
  // width and height variables for the ellipse score tracker
  int WIDTH = 1;
  int HEIGHT = 1;
  color fillScoreColor = color(200);
  
  //count keeps count of how many times the ball reset
  int count;
  //increment increases the ellipse width and height by a number each time the ball resets
  int increment = 50;
  
void update (){
  pushStyle();
  ellipse(width/2,height/2, WIDTH, HEIGHT);
  //fill(fillScoreColor);
  popStyle();
  //increases the size of the center ellipse and decreases the count each time the ball resets
  if (ball.isOffScreen()) {
    // If it has, reset the ball
    ball.reset();
    count = count - 1;
    if (count <= 0){
    WIDTH = WIDTH + increment;
    HEIGHT = HEIGHT + increment;
    }
    print(count);
  }
  // WINNING CONDITION pauses the game when the winning count of >= 5 is reached
  if (count >=5) {
    textSize(64);
    textAlign(CENTER, CENTER);
    text("YOU WIN", width/2, height/2); 
    frameRate(0);
  }
  
  //LOSING CONDITION pauses the game when the center ellipse reaches the countour ellipse
  if(orbit.EWIDTH == WIDTH){
    textSize(64);
    textAlign(CENTER, CENTER);
    text("YOU LOSE", width/2, height/2);
    frameRate(0);
  }
  //When the count is positive, it displays on the screen
  if (count > 0) {
    textSize(64);
    textAlign(CENTER, CENTER);
    text(count, width/2, height/2);
  }
}

}