class VoiceBug {
  float x;
  float y;
VoiceBug() {
    x= width/2;
}
void update (){
   val = level * 100;
   pushStyle();
   rect(x,height - val,10,10);
   fill(255,20,20);
   rectMode(CENTER);
   popStyle();
}
}