import processing.video.*;
import processing.sound.*;
import ddf.minim.*;
Minim minim;
AudioInput mic; 

//MOTION CAP VARIABLE
Capture video;
//Goal object
Goal goal1;

PImage prev;

float threshold = 25;

float motionX = 0;
float motionY = 0;

float lerpX = 0;
float lerpY = 0;
//AUDIO VAR
float level;
float val;

// A list of vehicles and voicebugs
ArrayList<Vehicle> vehicles;
ArrayList<VoiceBug> voicebugs;
ArrayList<TactileBug> tactilebugs;

void setup() {
  //initiate video
  size(1280, 720);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, 1280, 720);
  video.start();
  prev = createImage(video.width, video.height, RGB);
  
  //initiate audio
  minim = new Minim(this);
  // We use minim.getLineIn() to get access to the microphone data
  mic = minim.getLineIn();
  
  // initiates the vehicles through a loop
  vehicles = new ArrayList<Vehicle>();
  for (int i = 0; i < 100; i++) {
    vehicles.add(new Vehicle(random(width),random(height)));
  }
  voicebugs = new ArrayList<VoiceBug>();
  for (int i = 0; i < 100; i++) {
    voicebugs.add(new VoiceBug(random(width),random(height)));
  }
  tactilebugs = new ArrayList<TactileBug>();
  for (int i = 0; i < 100; i++) {
    tactilebugs.add(new TactileBug(random(width),random(height)));
  }
  
  //initiate the goal
  goal1 = new Goal(width/2,height/2,1,1,10);
}

void captureEvent(Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void draw() {
  video.loadPixels();
  prev.loadPixels();
  image(video, 0, 0);

  //threshold = map(mouseX, 0, width, 0, 100);
  threshold = 50;


  int count = 0;
  
  float avgX = 0;
  float avgY = 0;

  loadPixels();
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      color prevColor = prev.pixels[loc];
      float r2 = red(prevColor);
      float g2 = green(prevColor);
      float b2 = blue(prevColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d > threshold*threshold) {
        //stroke(255);
        //strokeWeight(1);
        //point(x, y);
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
    // Draw a circle at the tracked pixel
  }
  
  lerpX = lerp(lerpX, motionX, 0.1); 
  lerpY = lerp(lerpY, motionY, 0.1); 
  
  pushStyle();
  fill(255, 0, 255);
  strokeWeight(2.0);
  stroke(0);
  ellipse(lerpX, lerpY, 36, 36);
  popStyle();
  //image(video, 0, 0, 100, 100);
  //image(prev, 100, 0, 100, 100);

  //println(mouseX, threshold);
  
    for (Vehicle v : vehicles) {
      // Path following and separation are worked on in this function
      v.applyBehaviors(vehicles);
      // Call the generic run method (update, borders, display, etc.)
      v.update();
      v.display();
    }
    for (int i = 0; i < vehicles.size(); i++){
    Vehicle b = vehicles.get(i);
        if(dist(goal1.x,goal1.y,b.position.x,b.position.y) < goal1.size/2){
        vehicles.remove(i);
        goal1.scoreCount ++;
        goal1.size ++;
        }
     }
  
  //AUDIO bugs UPDATE
  // Gets the current level (volume) going into the microphone
  level = mic.mix.level();
  
  for (VoiceBug b : voicebugs) 
  {
      b.update();
      b.display();
  }
  for (int i = 0; i < voicebugs.size(); i++){
    VoiceBug b = voicebugs.get(i);
        if(dist(goal1.x,goal1.y,b.location.x,b.location.y) < goal1.size/2){
        voicebugs.remove(i);
        goal1.scoreCount ++;
        goal1.size ++;
        }
  }
    //Goal update
  goal1.update();
  goal1.display();
  
  //Tactile Bugs update
  for (TactileBug b : tactilebugs) 
  {
      b.update();
      b.seek(new PVector(mouseX,mouseY));
      b.display();
      //if(tactilebugs.size() <= 100){
      //  if(dist(goal1.x,goal1.y,b.location.x,b.location.y) < 10){
      //  tactilebugs.remove(b);
      //  }
      //}
      //goal1.collideWithTactile(b);
  }
  for (int i = 0; i < tactilebugs.size(); i++){
    TactileBug b = tactilebugs.get(i);
        if(dist(goal1.x,goal1.y,b.location.x,b.location.y) < goal1.size/2){
        tactilebugs.remove(i);
        goal1.scoreCount ++;
        goal1.size ++;
        }
  }
 
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}