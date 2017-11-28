class Fractal{

//This prototype will draw a tree fractal with a random rotation on the branches
//for each iteration of the fractal. I will attach this to the main part of my project
//In particular, i will attach it to each white pixels in the frame

//this code was built upon the base tree fractal template from processing


//the theta assign a random rotation to each branch 
float theta = random(0,PI/3);

void update() {
  stroke(255);
  // Draw a line 120 pixels
  line(0,0,0,-120);
  // Move to the end of that line
  translate(0,-12);
  // Start the recursive branching!
  branch(10);

}

void branch(float h) {
  // Each branch will be 2/3rds the size of the previous one
  h *= 0.66;
  
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 2) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    line(0, 0, 0, -h);// Draw the branch
    ellipse(0, 0, -h, -h);
    fill(floor(random(0,255)),floor(random(0,255)),floor(random(0,255)));
    translate(0, -h); // Move to the end of the branch
    branch(h);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
    
    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    ellipse(0, 0, -h, -h);
    fill(floor(random(0,255)),floor(random(0,255)),floor(random(0,255)));
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}
}