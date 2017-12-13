//////////////////////////////////////////////////////////////////////////////////////////////
/* ARTIST STATEMENT
name of the game : GEOPOINT 
GEOPOINT is an interactive game where the player controls various autonomous agents through 3 inputs; motion, voice, and mouse.
Each of the 3 autonomous agents is reacting to one of these inputs. The vehicle bug will follow the magenta circle which is controlled through
video motion tracking. The tactile bug will follow the user's mouse on screen. And, the voice bug will follow the magenta circle when it detects 
the user's voice. The goal of this game is to get all of your autonomous agent in the yellow goal. You win the game by doing so. 
The game itself is intended to be a soothing experience where the player just has fun interacting with the agents and herding them into the yellow goal.

IMPORTANT!!
-You need to microphone and webcam to play this game
-You should play this game in a silent room in order to minimize interference
-The webcam should be on a stable surface so has to minimize residual motion.
-If the voice detection is too sensitive for you. Change the voiceThreshold variable in the VoiceBug class from 5 to 10/15/20
*/
//////////////////////////////////////////////////////////////////////////////////////////////
//we import the video, sound and minim library 
import processing.video.*;
import processing.sound.*;
import ddf.minim.*;

//we create our library objects
Minim minim;
AudioInput mic; 

//VIDEO object
Capture video;

//Goal object
Goal goal1;

//SOUND
SoundFile bell;
SoundFile soundTrack;

//VARIABLES for the motion detector
PImage prev;

float threshold = 25;

float motionX = 0;
float motionY = 0;

float lerpX = 0;
float lerpY = 0;

//AUDIO VARIABLES to increase the normalized value of the mic input
float level;
float val;

// An array list of vehicles and voicebugs
ArrayList<Vehicle> vehicles;
ArrayList<VoiceBug> voicebugs;
ArrayList<TactileBug> tactilebugs;

//Number of particles for each of the autonomous agents
int totalVehicles = 100;
int totalVoiceBugs = 100;
int totalTactileBugs = 100;

//////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  
  //initiating the soundfile
  bell = new SoundFile(this, "sounds/ting.mp3");
  soundTrack = new SoundFile(this, "sounds/soothingSoundtrack.mp3");
  soundTrack.loop();
  
  //initiate video feed from the camera
  //IMPORTANT! use dimensions indicated in the console log
  size(1280, 720);
  String[] cameras = Capture.list(); //prints the possible camera dimension of your camera
  printArray(cameras);
  video = new Capture(this, 1280, 720);
  video.start();
  prev = createImage(video.width, video.height, RGB);
  
  //initiate minim
  minim = new Minim(this);
  
  // We use minim.getLineIn() to get access to the microphone data
  mic = minim.getLineIn();
  
  // initiates the vehicles on the screen through a loop
  vehicles = new ArrayList<Vehicle>();
  for (int i = 0; i < totalVehicles; i++) {
    vehicles.add(new Vehicle(random(width),random(height)));
  }
  voicebugs = new ArrayList<VoiceBug>();
  for (int i = 0; i < totalVoiceBugs; i++) {
    voicebugs.add(new VoiceBug(random(width),random(height)));
  }
  tactilebugs = new ArrayList<TactileBug>();
  for (int i = 0; i < totalTactileBugs; i++) {
    tactilebugs.add(new TactileBug(random(width),random(height)));
  }
  
  //initiate the goal, so that it appears on screen
  goal1 = new Goal(width/2,height/2,1,1,10);
}

  //function that copies the previous frame of the camera for the motion capture
void captureEvent(Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

//////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
  //load the pixels of the video and the prev frame
  video.loadPixels();
  prev.loadPixels();
  image(video, 0, 0);

  //threshold for the motion detection
  threshold = 50;
  
  int count = 0;
  
  float avgX = 0;
  float avgY = 0;

  loadPixels();
  // Begin loop to walk through every pixel to get current and previous pixel data
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // gets the color of current frame and previous frame
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      color prevColor = prev.pixels[loc];
      float r2 = red(prevColor);
      float g2 = green(prevColor);
      float b2 = blue(prevColor);
      
      //calculate the distance square between the rgb pixels from current and previous frame
      float d = distSq(r1, g1, b1, r2, g2, b2); 
      
      //if d is greater than the threshold sqr'ed add X and Y to avgX&Y and increase the count.
      //also whitens the difference between the current pixels and previous pixels, otherwise, leave them black.
      if (d > threshold*threshold) {
        avgX += x;
        avgY += y;
        count++;
        pixels[loc] = color(255);
      } else {
        pixels[loc] = color(0);
      }
    }
  }
  updatePixels();

  // We only consider the color found if its color distance is less than 10. 
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (count > 200) { 
    motionX = avgX / count;
    motionY = avgY / count;
  }
  
  //Use the built-in linear interpolation function to smoothen out the tracked motion do the ellipse does not teleport
  lerpX = lerp(lerpX, motionX, 0.1); 
  lerpY = lerp(lerpY, motionY, 0.1); 
  
  //THE MAGENTA ELLIPSE
  // Draw a circle at the tracked pixel
  pushStyle();
  noFill();
  strokeWeight(2.0);
  stroke(255, 0, 255);
  ellipse(lerpX, lerpY, 36, 36); //we use the lerp variables to represent the motion tracking of the ellipse
  popStyle();
  
  //VEHICLE updates
    //in order to update the behaviour and siaply of the autonomous agents, we use the enhanced for loops as they require less syntax.
    for (Vehicle v : vehicles) {
      // Path following and separation are worked on in this function
      v.applyBehaviors(vehicles);
      // Call the generic run method (update, borders, display, etc.)
      v.update();
      v.display();
    }
    //this for loop is used to remove autonomous agents from the array list when they collide with the goal
    for (int i = 0; i < vehicles.size(); i++){
    Vehicle b = vehicles.get(i);
        if(dist(goal1.x,goal1.y,b.position.x,b.position.y) < goal1.size/2){
        vehicles.remove(i);
        bell.play(); //we also play the bell sound when they collide
        goal1.scoreCount ++; //the score count also gets increased
        goal1.size ++; // and the size of the goal gets increased
        }
     }
  
  //AUDIO bugs UPDATE
  // Gets the current level (volume) going into the microphone
  level = mic.mix.level();
  
  //we use the enhanced for loop the same way for the voicebugs
  for (VoiceBug b : voicebugs) 
  {
      b.update();
      b.display();
  }
  
  //we remove them from the array like we did previously
  for (int i = 0; i < voicebugs.size(); i++){
    VoiceBug b = voicebugs.get(i);
        if(dist(goal1.x,goal1.y,b.location.x,b.location.y) < goal1.size/2){
        voicebugs.remove(i);
        bell.play();
        goal1.scoreCount ++;
        goal1.size ++;
        }
  }
  
  //Tactile Bugs update
  //we use the enhanced for loop the same way for the tactilebugs
  for (TactileBug b : tactilebugs) 
  {
      b.update();
      b.seek(new PVector(mouseX,mouseY));
      b.display();
  }
    
  //we remove them from the array like we did previously
  for (int i = 0; i < tactilebugs.size(); i++){
    TactileBug b = tactilebugs.get(i);
        if(dist(goal1.x,goal1.y,b.location.x,b.location.y) < goal1.size/2){
        tactilebugs.remove(i);
        bell.play();
        goal1.scoreCount ++;
        goal1.size ++;
        }
  }
  
  //GOAL UPDATE
  //we update the functions of the goal class
  goal1.update();
  goal1.display();
  goal1.gameOver();
 
}

//function that returns the distsqr'ed between 3 points and 3 other points, we use it for the motion detection
float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}