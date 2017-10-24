// Griddies STARTED
// by Pippin Barr
// MODIFIED BY: 
//
// A simple artificial life system on a grid. The "griddies" are squares that move
// around randomly, using energy to do so. They gain energy by overlapping with
// other griddies. If a griddie loses all its energy it dies.

// The size of a single grid element
int gridSize = 20;
// An array storing all the griddies and munchers
Griddie[] griddies = new Griddie[100];
Munchers[] munchers = new Munchers[20];

// setup()
//
// Set up the window and the griddies

void setup() {
  // Set up the window size and framerate (lower so we can watch easier)
  size(640, 480);
  frameRate(10);

  // QUESTION: What does this for loop do?
  //ANSWER; It creates new griddies with given parameters and random XY coordinates 
  // until the array of 100 griddies is filled. it loops the array to easily create a lot of griddies at once. 
  for (int i = 0; i < griddies.length; i++) {
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    griddies[i] = new Griddie(x * gridSize, y * gridSize, gridSize);
  }
  // CHANGED until the array of 20 munchers is filled. it loops the array to easily create a lot of munchers at once. 
  for (int i = 0; i < munchers.length; i++) {
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    munchers[i] = new Munchers(x * gridSize, y * gridSize, gridSize);
  }
}

// draw()
//
// Update all the griddies, check for collisions between them, display them.

void draw() {
  background(50);

  // We need to loop through all the griddies one by one
  for (int i = 0; i < griddies.length; i++) {

    // Update the griddies
    griddies[i].update();

    // Now go through all the griddies a second time...
    for (int j = 0; j < griddies.length; j++) {
      // QUESTION: What is this if-statement for?
      //ANSWER; This if statement will prevent the current griddie from detecting its own collision
      if (j != i) {
        // QUESTION: What does this line check?
        // ANSWER; This line checks to see if the current griddie is overlapping with the other griddie.
        // if yes, the griddies will collide with one another.
        griddies[i].collide(griddies[j]);
      }
    }
    
    // Display the griddies
    griddies[i].display();
  }
  
  //CHANGED we will loop through the munchers once to call their update and display functions
  for (int i = 0; i < munchers.length; i++) {

    // Update the griddies
    munchers[i].update();

    // CHANGED this will loop through the griddies to call the eat function which will 
    // check the collision between gridders and munchers every frame to see if munchers can eat griddies.
    for (int j = 0; j < griddies.length; j++) {
      munchers[i].eat(griddies[j]);
    }
    
    // CHANGED this will display the munchers
    munchers[i].display();
  }
}