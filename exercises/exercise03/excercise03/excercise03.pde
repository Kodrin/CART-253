//started

/*defines the background color and the varibale Bouncer*/
color backgroundColor = color(58, 58, 58);
Bouncer bouncer;
Bouncer bouncer2;

/*sets up the size of the canvas and the background color
In the setup, the object bouncer is created through the use of constructors with parameters
regarding its position, size, colors
*/
void setup() {
  size(640,480);
  background(backgroundColor);
  bouncer = new Bouncer(width/2,height/2,2,2,50,color(252, 252, 244,50),color(255,0,0,50));
  bouncer2 = new Bouncer(width/2,height/2,-2,2,50,color(244, 244, 66, 50),color(0,0,255,50));
}

/* the program call the update and draw function of the bouncer objects

*/
void draw() {
  bouncer.update();
  bouncer2.update();
  bouncer.draw();
  bouncer2.draw();
}