class SketchLoops{

float a = random(0,width);
float b = height/2;  

float x1 = random(0,width);
float y1 = random(0,height);
float x2 = random(0,width);
float y2 = random(0,height);

float xv = 1;
float yv = 1;



// draws the bezier with all the values and updates the color value based on the audio input level
  
void update() {
    bezier(a, b, x1* level* amount, y1 , x2, y2 * level* amount, a, b);
    val = level * 255;
    color fillColor = (1);
    fillColor *= val;
    fill(fillColor);
    //a += xv;
    //b += yv;
    //x1 += xv;
    //y1 += yv;
    //x2 += xv;
    //y2 += yv;
}

}