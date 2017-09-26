/*This section declares the FINAL (cant be changed) integer values for the circle speed and the circle size
This section also declares the RGB color values for the noclick, click, background, and 
stroke variables
*/
final int CIRCLE_SPEED = 7;
final color NO_CLICK_FILL_COLOR = color(250, 100, 100);
final color CLICK_FILL_COLOR = color(100, 100, 250);
final color BACKGROUND_COLOR = color(250, 150, 150);
final color STROKE_COLOR = color(250, 150, 150);
final int CIRCLE_SIZE = 50;
final color MARGIN_COLORX = color(100,200,100); // CHANGED I added two new variables called MARGIN_COLOR X & Y in order for the circle to change color at the margin of the window
final color MARGIN_COLORY = color(100,100,200); // CHANGED

/*The section below declare integer variables with no value stored in them yet  
*/
int circleX;
int circleY;
int circleVX;
int circleVY;

/*the void setup function sets up and starts the program   */
void setup() {
  size(640, 480); //this specifies the sizes of the window in pixels
  circleX = width/2;
  circleY = height/2; // this statement stores the values of circleXY which are the XY value of the canvas divided by 2
  circleVX = CIRCLE_SPEED;//these 2 statements specify the circle XY velocity by referencing the circle speed
  circleVY = CIRCLE_SPEED;
  stroke(STROKE_COLOR); //this statement calls the function STROKE which specifies the stroke color by referencing the RGB color values from Stroke_color
  fill(NO_CLICK_FILL_COLOR);//this statement calls the function fill which fills the the inside of our shapes with the RGB values from the NO_CLICK_FILL_COLOR
  background(BACKGROUND_COLOR);//this statement calls the function background which change the background color to the RGB values specified in BACKGROUND_COLOR
}
/* the draw function will update every frame while the program is running
*/
void draw() {
    if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) {    //this if statement will change the color of the circle to blue if it the distance between the mouseXY and CircleXY is smaller than the circle Size/2
    fill(CLICK_FILL_COLOR);                                           
  }
  else {
   // fill(NO_CLICK_FILL_COLOR);                 //in any other circumstance where the mouse does not get close to the circle, the circle stays purple
  }
  ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE);//this function draw a circle based on the circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE values
  circleX += circleVX; //the circleX coordinate will increment by the value of the circleVX variable every frame, making it move
  circleY += circleVY; //same as the last comment except for the circle Y coordinate
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) { //if the circle x coordinates exceeds the canvas width size positively or negatively, then the circle will reverse its velocity to go in the opposite direction
    circleVX = -circleVX;
    fill(MARGIN_COLORX); // CHANGED Once the ball reaches the X margin , I added the fill function so it will change color to GREEN
  }
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) {//same as the previous comment. This time for the height and Y coordinates
    circleVY = -circleVY;
    fill(MARGIN_COLORY); // CHANGED Once the ball reaches the Y margin , I added the fill function so it will change color to BLUE 
  }
  
// CHNAGED CONDITION STATEMENT  
   if (keyPressed) {    // if the 'x' key is pressed, the circle will have a jitter effect on the x axis. IMPORTANT! MAKE SURE THAT CAPSLOCK IS OFF
    if (key == 'x') {           
      circleVX = -circleVX;
      }
    }
   if (keyPressed) {   // if the 'y' key is pressed, the circle will have a jitter effect on the y axis. IMPORTANT! MAKE SURE THAT CAPSLOCK IS OFF
    if (key == 'y') {
      circleVY = -circleVY;
      }
    } 
}

void mousePressed() {
  background(BACKGROUND_COLOR); //each time the mouse is pressed, the background will change to the RGB values of the BACKGROUND_COLOR variable which clears the background
}