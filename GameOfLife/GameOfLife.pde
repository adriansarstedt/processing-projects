pixelMap test;
int count = 0;
boolean life = false;
int fps = 40;

class Cell {
  int currentState, futureState;
  
  Cell() {
    currentState = 0;
    futureState = 0;
  }
  
  void display(int x, int y, int w, int h) {    
    if (currentState == 1) {
      fill(0);
    } else {
      fill(255);
    }
    rect(x, y, w, h);  
  }
}

class pixelMap {
  int wp, hp, xinc, yinc;
  Cell[][] pArray;
  
  pixelMap(int w, int h) {
    wp = w;
    hp = h;
    xinc = width/wp;
    yinc = height/hp;   
    reset();
  }
  
  void reset() {
    pArray = new Cell[wp][hp];
    for (int x=0;x<wp;x++) {
      for (int y=0;y<hp;y++) {
        pArray[x][y] = new Cell();    
      }
    }
  }
  
  void render() {
    for (int x=0;x<wp;x++) {
      for (int y=0;y<hp;y++) {
        pArray[x][y].display(x*xinc, y*yinc, xinc, yinc);    
      }
    }
  }
  
  void setPixel() {
    int x = mouseX/xinc;
    int y = mouseY/yinc;
    pArray[x][y].currentState = 1;
  }
  
  void update() {
    for (int x=0;x<wp;x++) {
      for (int y=0;y<hp;y++) {
        int neighbours = 0;
        if (x != wp-1) {
          neighbours += pArray[x+1][y].currentState;
        } if (x != 0) {
          neighbours += pArray[x-1][y].currentState;
        } if (y != hp-1) {
          neighbours += pArray[x][y+1].currentState;
        } if (y != 0) {
          neighbours += pArray[x][y-1].currentState;
        } 
        
        
        if ((x != wp-1) && (y != hp-1)) {
          neighbours += pArray[x+1][y+1].currentState;
        } if ((x != 0) && (y != 0)) {
          neighbours += pArray[x-1][y-1].currentState;
        } if ((x != 0) && (y != hp-1)) {
          neighbours += pArray[x-1][y+1].currentState;
        } if ((x != wp-1) && (y != 0)) {
          neighbours += pArray[x+1][y-1].currentState;
        }        
        
        if (neighbours < 2) {
          pArray[x][y].futureState = 0;
        } if (neighbours > 3) {
          pArray[x][y].futureState = 0;
        } if (neighbours == 3) {
          pArray[x][y].futureState = 1;
        } if (neighbours == 2) {
          pArray[x][y].futureState = pArray[x][y].currentState;
        }
        
        /*
        if ((neighbours == 3) || (neighbours == 2)) {
          pArray[x][y].futureState = 1;
        }
        */
      }
    }  
  for (int x=0;x<wp;x++) {
    for (int y=0;y<hp;y++) {
      pArray[x][y].currentState =  pArray[x][y].futureState;
    }
  }  
  }
}  

void setup() {
  size(800, 600);
  frameRate(200);
  test = new pixelMap(width/10, height/10);
}

void draw() {
  count++;
  test.render();
  if (mousePressed == true) {
    test.setPixel();
  } 
  if ((count%(200/fps) == 0) && (life)) {
    test.update();
  }
}

void keyPressed() {
  if (key == ' ') {
    test.reset();
  }
  if (key == 's') {
    if (life) {
      life = false;
    } else {
      life = true;
    }
  }
}