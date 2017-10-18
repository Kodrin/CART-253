class Score {
  // width and height variables for the ellipse score tracker
  int WIDTH;
  int HEIGHT;
  color fillScoreColor = color(100);
  
  //count keeps count of how many times the ball reset
  int count;
  //increment increases the ellipse width and height by a number each time the ball resets
  int increment = 50;
  
void update (){
  pushStyle();
  ellipse(width/2,height/2, WIDTH, HEIGHT);
  fill(fillScoreColor);
  popStyle();
  
  if (ball.isOffScreen()) {
    // If it has, reset the ball
    ball.reset();
    count = count + 1;
    WIDTH = WIDTH + increment;
    HEIGHT = HEIGHT + increment;
    print(count);
  }
}



}