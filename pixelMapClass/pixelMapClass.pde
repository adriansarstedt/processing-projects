pixelMap test;

class pixelMap {
  int wp, hp, xinc, yinc;
  int[][] pArray;
  
  pixelMap(int w, int h) {
    wp = w;
    hp = h;
    xinc = width/wp;
    yinc = height/hp;
    
    pArray = new int[wp][hp];
    randomise();
  }
  
  void randomise() {
    for (int x=0;x<wp;x++) {
      for (int y=0;y<hp;y++) {
        pArray[x][y] = int(random(255));    
      }
    }
  }
  
  void render() {
    for (int x=0;x<wp;x++) {
      for (int y=0;y<hp;y++) {
        stroke(pArray[x][y]);
        fill(pArray[x][y]);
        rect(x*xinc, y*yinc, xinc, yinc);    
      }
    }
  }
  
  void setPixel(int x, int y) {
    pArray[x][y] = 255;
  }
  
  void getPixel() {
    int x = mouseX/xinc;
    int y = mouseY/yinc;
    pArray[x][y] = 255;
  }
}  

void setup() {
  size(800, 600);
  test = new pixelMap(width/2, height/2);
}

void draw() {
  test.render();
  if (mousePressed == true) {
    test.getPixel();
  }
}

void keyPressed() {
  if (key == ' ') {
    test.randomise();
  }
  if (key == 's') {
    test.setPixel(0,0);
    println(int(2.9));
  }
}