int[] size = {100, 100}, probeSite = {int(random(size[0])), int(random(size[1]))}, fissureSite = {int(random(size[0])), int(random(size[1]))};
Cell[][] Map = new Cell[size[0]][size[1]];

int xw = 500/size[0], yw = 500/size[1];
// state: 0 no value, 1 water, 2 lava, 3 rock

class Cell {
  int futureState = 0, currentState = 0;
  Cell() {
    
  }
}

void setup() {
  for (int x = 0; x<size[0]; x++) {
    for (int y=0; y< size[1]; y++) {
      Map[x][y] = new Cell();
      if (random(100) < 5) {
        Map[x][y].currentState = 1;
      } else if (random(100) < 5) {
        Map[x][y].currentState = 2;
      } else {
        Map[x][y].currentState = 0;
      }
    }
  }
  
  size(500, 500);
  frameRate(40);
}

void draw() {
  for (int x = 0; x<size[0]; x++) {
    for (int y=0; y< size[1]; y++) {
      
      Map[x][y].futureState = 0;
      if (Map[x][y].currentState == 3) {
        fill(255);
      } else {
        fill(Map[x][y].currentState*100);
      }
      rect(x*xw, y*yw, xw, yw);
    }
  }
  
}

void iterate() {
  for (int x = 1; x<size[0]-1; x++) {
    for (int y=1; y< size[1]-1; y++) {
      boolean water = false;
      boolean lava = false;
      
      if (Map[x][y].currentState != 3) {
      
      if ((Map[x+1][y].currentState == 1) || (Map[x+1][y+1].currentState == 1) || (Map[x+1][y-1].currentState == 1) || (Map[x-1][y+1].currentState == 1) || (Map[x-1][y-1].currentState == 1) || (Map[x-1][y].currentState == 1) || (Map[x][y+1].currentState == 1) || (Map[x][y-1].currentState == 1)) {
        water = true;
      } if ((Map[x+1][y].currentState == 2) || (Map[x+1][y+1].currentState == 2) || (Map[x+1][y-1].currentState == 2) || (Map[x-1][y+1].currentState == 2) || (Map[x-1][y-1].currentState == 2) || (Map[x-1][y].currentState == 2) || (Map[x][y+1].currentState == 2) || (Map[x][y-1].currentState == 2)) {
        lava = true;
      }
      
      if (water && lava) {
        Map[x][y].futureState = 3; 
      } else if (water) {
        Map[x][y].futureState = 1;
      } else if (lava) {
        Map[x][y].futureState = 2;
      } 
      }
    }
  }
}

void update() {
  iterate();
  
  for (int x = 0; x<size[0]; x++) {
    for (int y=0; y< size[1]; y++) {
      if (Map[x][y].futureState != 0) {
        Map[x][y].currentState = Map[x][y].futureState;
      }
    }
  }
}

void keyPressed() {
  update();
}