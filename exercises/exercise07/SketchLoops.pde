class SketchLoops{

float a = random(0,width);
float b = random(0,height);  
  
void update() {
    bezier(a, b, 100, height/2 , 400, height/2 * level* amount, a, b);
}

}