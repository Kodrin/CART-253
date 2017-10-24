class Munchers {
  // Limits for energy level and gains/losses
  int maxEnergy = 255;
  int moveEnergy = -1;
  int collideEnergy = 10;
  
  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int energy;
  color fill = color(255,255,0);

  Munchers(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  void update() {
    
    if (energy == 0) {
      return;
    }
    
    int xMoveType = floor(random(-1,2));
    int yMoveType = floor(random(-1,2));
    x += size * xMoveType;
    y += size * yMoveType;
    
    if (x < 0) {
      x += width;
    }
    else if (x >= width) {
      x -= width;
    }
    if (y < 0) {
      y += height;
    }
    else if (y >= height) {
      y -= height;
    }

  }

  
  void collide(Griddie other) {
    if (x == other.x && y == other.y) {
      // Increase this Griddie's energy
      other.energy = 0;
      // Constrain the energy level to be within bounds
      //energy = constrain(energy,0,maxEnergy);
    }
  }


  void display() {
    fill(fill, energy); 
    noStroke();
    rect(x, y, size, size);
  }
}