/*the class Bouncer is created */
class Bouncer {
/* here, we create variables for the XY coordinates of the bouncer and the XY velocity.
Variables are also created for the size, and colors of the object
*/  
 int x;
 int y;
 int vx;
 int vy;
 int size;
 color fillColor;
 color defaultColor;
 color hoverColor;
 
 /*the function Bouncer is created with the initial variables assigned to the parameters
 This allows us to draw the bouncer by simply inputing the wanted values in the parameters
 */
 Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor) {
   x = tempX;
   y = tempY;
   vx = tempVX;
   vy = tempVY;
   size = tempSize;
   defaultColor = tempDefaultColor;
   hoverColor = tempHoverColor;
   fillColor = defaultColor;
 }
 
 /* In the update function, the XY velocity is added to the XY coordinates of the bouncer.
 The function then calls the handleBounce() and handleMouse() functions
 */
 void update() {
   x += vx;
   y += vy;
   handleBounce();
   handleMouse();
 }
 /* The handleBounce function check for the border of the screen through if statements 
 and reverse the direction of the velocity. It also constrains the XY values to min and max values
 */
 
 //CHANGED added random teleportation of object by randomizing the XY axis of the bouncer through random functions
 void handleBounce() {
   if (x - size/2 < 0 || x + size/2 > width) {
    vx = -vx; 
    //x = int(random(0,width));
   }
   
   if (y - size/2 < 0 || y + size/2 > height) {
     vy = -vy;
    //y = int(random(0,height));
   }
   
   x = constrain(x,size/2,width-size/2);
   y = constrain(y,size/2,height-size/2);
 }
 /* The handleMouse function checks for the distance between the mouse coordinates and the size of the bouncer
 through an if statement. Consequently, the bouncer will change color when you mouse over it. Otherwise, it remains
 with the default color as mentioned in the else statement
 */
 void handleMouse() {
   if (dist(mouseX,mouseY,x,y) < size/2) {
    fillColor = hoverColor; 
   }
   else {
     fillColor = defaultColor;
   }
 }
 /* CHANGED added mouse clicked
 */
 void mouseClicked() {
   if (mousePressed == true && mouseInTheBouncer()== true ) {
    fill(0);
    size++;
   }
 }
 
  /* CHANGED added boolean operation to check if the mouse is in the bouncer
  if it is, it returns true. Otherwise, it returns false.
 */
 boolean mouseInTheBouncer() {
   if (dist(mouseX,mouseY,x,y) < size/2) {
    return true; 
   }
   else {
     return false;
   }
 }
 
 /*the draw function specifies calls the no stroke function to remove strokes
 , the fill color function to fill the bouncer with a specific color, and the ellipse
 function to draw a circle at every frame
 */
 void draw() {
   noStroke();
   fill(fillColor);
   ellipse(x,y,size,size);
   mouseClicked();
   }
 }