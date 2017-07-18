int[] zoomVertex = new int[2];
pixelComplexPlain screen;

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
  
  complexNum times(complexNum b) {
    return new complexNum(r*b.r-i*b.i, r*b.i+i*b.r);
  }
  
  complexNum take(complexNum b) {
    return new complexNum(r-b.r, i-b.i);
  }
  
  complexNum dividedBy(complexNum b) {
    return new complexNum((r*b.r+i*b.i)/(b.r*b.r+b.i*b.i), (i*b.r-r*b.i)/(b.r*b.r+b.i*b.i));
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
    rmin = -3;
    rmax = 1.5;
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
    
    process();
    render();
    
    println(rmax-rmin);
  }
  
  void process() {
    for (int x=0;x<width;x++) {
      for (int y=0;y<height;y++) {
        complexNum temp = new complexNum(rmin+x*cinc, imin+y*iinc);
        if (convergenceTest(temp, 100)) {
          pArray[x][y] = 0; 
        } else {
          pArray[x][y] = 255; 
        }  
      }
    }
  }
  
  void render() {
    loadPixels();
    for (int x=0;x<width;x++) {
      for (int y=0;y<height;y++) {
        pixels[x + y * width] = color(pArray[x][y]); 
      }
    }
    updatePixels();
  }
}

boolean convergenceTest(complexNum c, int maxIterations) {
  complexNum z = new complexNum(0, 0);
  boolean run = true;
  
  for (int i=0; i<maxIterations; i++) {
    if (run) {
      z = z.squared().plus(c);
      if (z.mag()>100) {
        run = false;
      } if (z.mag()<0.01) {
        run = false;
      }
    }    
  }
  
  if (z.mag() < 2) {
    return true;   
  } else {
    return false;
  }
}

void setup() {
  size(500, 500);
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
  }
}