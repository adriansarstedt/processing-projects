int[] zoomVertex = new int[2];
pixelComplexPlain screen;
int maxIteration = 20;
complexNum c = new complexNum(0, -1);

class complexNum {
  float r, i;
  
  complexNum(float tr, float ti) {
    r = tr;
    i = ti;
  }
  
  float mag() {
    return sqrt(r*r+i*i);
  }
  
  complexNum squared() {
    float tr = r*r-i*i;
    float ti = 2*r*i;
    return new complexNum(tr, ti); 
  }
  
  complexNum plus(complexNum b) {
    return new complexNum(r+b.r, i+b.i);
  }
  
  void print() {
    println(str(r)+"+"+str(i)+"i");
  } 
}

class pixelComplexPlain {
  float rmin, rmax, imin, imax, cinc, iinc;
  int[][] pArray;
  
  pixelComplexPlain() {
    
    pArray = new int[width][height];
    defaultWindowSettings();
    
  }
  
  void defaultWindowSettings() {
    rmin = -2;
    rmax = 4;
    imin = -2;
    imax = 2;
    
    cinc = (rmax-rmin)/width;
    iinc = (imax-imin)/height;
    
    process();
    render();
  }
  
  void changeViewWindow(float x1, float y1, float x2, float y2) {
    rmax = rmin+x2*cinc;
    rmin = rmin+x1*cinc;
    imax = imin+y2*iinc;
    imin = imin+y1*iinc;
    
    cinc = (rmax-rmin)/width;
    iinc = (imax-imin)/height;
    println(cinc, iinc);
    
    process();
    render();
  }
  
  void process() {
    for (int x=0;x<width;x++) {
      for (int y=0;y<height;y++) {
        complexNum temp = new complexNum(rmin+x*cinc, imin+y*iinc);
        pArray[x][y] = (280/maxIteration)*convergenceTest(temp);
      }
    }
  }
  
  void render() {
    loadPixels();
    for (int x=0;x<width;x++) {
      for (int y=0;y<height;y++) {
        pixels[x + y * width] = color(pArray[x][y], 97, 100); 
      }
    }
    updatePixels();
  }
}

int convergenceTest(complexNum e) {
  complexNum z = e;
  boolean run = true;
  int speed = maxIteration;
  
  for (int i=0; i<maxIteration; i++) {
    if (run) {
      z = z.plus(c).squared();
      if (z.mag()>100) {
        run = false;
      } if (z.mag()<0.2) {
        run = false;
        speed=i;        
      }
    }    
  } 
  
  return speed;
}

void setup() {
  size(1280, 800);
  colorMode(HSB, 360, 100, 100);
  screen = new pixelComplexPlain();
}

void draw() {
  if (mousePressed) {
    screen.render();
    fill(0, 0);
    rect(zoomVertex[0], zoomVertex[1], mouseX-zoomVertex[0], mouseY-zoomVertex[1]);
  }
}

void mousePressed() {
  zoomVertex[0] = mouseX;
  zoomVertex[1] = mouseY;
}

void mouseReleased() {
  screen.changeViewWindow(zoomVertex[0], zoomVertex[1], mouseX, mouseY);
}

void keyPressed() {
  if (key == ' ') {
    screen.defaultWindowSettings();
  } if (key == 's') {
    c = c.plus(new complexNum(0.01, 0.01));
    screen.process();
    screen.render();
  }
}