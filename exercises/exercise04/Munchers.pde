class Munchers {
  // Limits for energy level and gains/losses
  int maxEnergy = 255;
  int moveEnergy = -1;
  
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

  //CHANGED if the munchers overlap with the griddies, they will 'eat' them by reducing their energy to 0
  void eat(Griddie other) {
    if (x == other.x && y == other.y) {
      other.energy = 0;
    }
  }


  void display() {
    fill(fill, energy); 
    noStroke();
    rect(x, y, size, size);
  }
}