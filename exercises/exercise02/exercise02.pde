//sets the color background to black
color backgroundColor = color(0);
//sets the number of static dots, their min & max size and their color (which is set to white)
int numStatic = 1000;
int staticSizeMin = 1;
int staticSizeMax = 3;
color staticColor = color(200);
// these integers set the coordinates, velocity, speed, dimensions and the color of the Paddle 
int paddleX;
int paddleY;
int paddleVX;
int paddleSpeed = 10;
int paddleWidth = 128;
int paddleHeight = 16;
color paddleColor = color(random(255),random(255),random(255));
// these integers set the coordinates, velocity, speed, size and the color of the ball 
int ballX;
int ballY;
int ballVX;
int ballVY;
int ballSpeed = 5;
int ballSize = 16;
color ballColor = color(255);


void setup() { //setup initilizes the program
  size(640, 480); // sets the canvas width to 640px and height to 480px
  
  setupPaddle(); //calls the function setupPaddle()
  setupBall();  //calls the function setupBall()
}
// the setupPaddle function sets up the position of the paddle to be at the bottom center of the window when the program starts running
void setupPaddle() { 
  paddleX = width/2;
  paddleY = height - paddleHeight;
  paddleVX = 0;
}
//the setupBall function sets up the position of the ball to be at the center of the canvas when the program starts running
void setupBall() {
  ballX = width/2;
  ballY = height/2;
  ballVX = ballSpeed;
  ballVY = ballSpeed;
}

//sets the background to black and calls the function drawStatic() updatePaddle() updateBall() drawPaddle() drawBall() respectively each frame
void draw() {
  //background(backgroundColor);

  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();


}
//this function use a for loop to draw static by generating random xy coordinates based on the height and width of canvas and by generating random sizes for the static dots
void drawStatic() {
  for (int i = 0; i < numStatic; i++) {
   float x = random(0,width);
   float y = random(0,height);
   float staticSize = random(staticSizeMin,staticSizeMax);
   fill(staticColor);
   rect(x,y,staticSize,staticSize);
  }
}
/*the updatePaddle function allows you to move the paddle on the x axis and constrain it within the size of the window  */
void updatePaddle() {
  paddleX += paddleVX;  
  paddleX = constrain(paddleX,0+paddleWidth/2,width-paddleWidth/2);
}
/*the updateBall function adds the velocity of the ball at the beginning and pushes it in a direction
the function also calls the other functions handleBallHitPaddle(),handleBallHitWall(),handleBallOffBottom()
*/
void updateBall() {
  ballX += ballVX;
  ballY += ballVY;
  
  handleBallHitPaddle();
  handleBallHitWall();
  handleBallOffBottom();
  handleBallOverMidSection();

}
/*the drawPaddle function draws the paddle with a center anchor point and fills it with white and no stroke */
void drawPaddle() {
  rectMode(CENTER);
  noStroke();
  fill(paddleColor);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}
/*the drawBall function draws the ball from a center anchor point and fills it with white and no stroke */
void drawBall() {
  rectMode(CENTER);
  noStroke();
  fill(ballColor);
  rect(ballX, ballY, ballSize, ballSize);
  
}
  //CHANGED this if statement checks whether or not the ball is above or below the height of the canvas/2 and changes the colors appropriately 
void handleBallOverMidSection(){
  if (ballOverMidSection()){
  ballColor = color(200,100,100);
  }
  else {
  ballColor = color(100,200,100);
  }
}

/*this is a condition statement that changes the direction of the ball as soon as the ball overlaps with the paddle */
void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {
    ballY = paddleY - paddleHeight/2 - ballSize/2;
    ballVY = -ballVY;
    /*CHANGED the ballSize and paddleWidth are changed everytime the ball hits the paddle. the random numbers are parsed from float to int*/
    ballSize = int(random(8,32));
    paddleWidth = int(random(80,332));

  }
}
/*this is a boolean operation that checks whether or not the ball hit the paddle and returns either true or false to the previous function */
boolean ballOverlapsPaddle() {
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX + ballSize/2 < paddleX + paddleWidth/2) {
    if (ballY > paddleY - paddleHeight/2) {
      return true;
    }
  }
  return false;
}
void midSection() {
  if (ballOverMidSection()){
  ballColor = color(random(255),random(255),random(255));;
  }
}

//CHANGED checks whether or not the ball is above or below the mid section of the screen
boolean ballOverMidSection() {
  if(ballY > height/2) {
  return true;
  }
  else{
  return false;
  }
  
}
/*the handleBallOffBotton function resets the balls in the center if it extends beyond the marginXY margins of the window */
void handleBallOffBottom() {
  if (ballOffBottom()) {
    ballX = width/2;
    ballY = height/2;
  }
} 
/*ballOffBotton is a boolean operations that returns true to the previous function when the ball goes past the bottom of the screen*/
boolean ballOffBottom() {
  return (ballY - ballSize/2 > height);
}
/*the handleBallHitWall function reverses the XY velocity when the ball passes the left top right margin of the window */
void handleBallHitWall() {
  if (ballX - ballSize/2 < 0) {
    ballX = 0 + ballSize/2;
    ballVX = -ballVX;
  } else if (ballX + ballSize/2 > width) {
    ballX = width - ballSize/2;
    ballVX = -ballVX;
  }
  
  if (ballY - ballSize/2 < 0) {
    ballY = 0 + ballSize/2;
    ballVY = -ballVY;
  }
}
/*this is if statement lets you move the paddle from left to right when you press the left or right arrow keys */
void keyPressed() {
  if (keyCode == LEFT) {
    paddleVX = -paddleSpeed;
  } else if (keyCode == RIGHT) {
    paddleVX = paddleSpeed;
  }
}
/*this if statement will nullify the velocity applied in the previous statement when you release the arrow keys, making the paddle stop */
void keyReleased() {
  if (keyCode == LEFT && paddleVX < 0) {
    paddleVX = 0;
  } else if (keyCode == RIGHT && paddleVX > 0) {
    paddleVX = 0;
  }
}

//CHANGED while the ball is over the mid section change color to background(100,200,100);
void loopDraw() {
while (ballOverMidSection()) {
  background(100,200,100);
}
}