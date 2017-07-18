pixelMap display;
int[] zoomVertexPoint = new int[2];

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

class pixelMap {
  int wp, hp, pxinc, pyinc;
  float cmin, cmax, imin, imax, cinc, iinc;
  int[][] pArray;
  
  pixelMap(int w, int h) {
    wp = w;
    hp = h;
    pxinc = width/wp;
    pyinc = height/hp;
    
    cmin = -3;
    cmax = 1.5;
    imin = -2;
    imax = 2;
    
    cinc = (cmax-cmin)/wp;
    iinc = (imax-imin)/hp;
    
    pArray = new int[wp][hp];
    process();
  }
  
  void process() {
    for (int x=0;x<wp;x++) {
      for (int y=0;y<hp;y++) {
        complexNum temp = new complexNum(cmin+x*cinc, imin+y*iinc);
        if (convergenceTest(temp, 20)) {
          pArray[x][y] = 0; 
        } else {
          pArray[x][y] = 255; 
        }  
      }
    }
  }
  
  void render() {
    for (int x=0;x<wp;x++) {
      for (int y=0;y<hp;y++) {
        stroke(pArray[x][y]);
        fill(pArray[x][y]);
        rect(x*pxinc, y*pyinc, pxinc, pyinc);    
      }
    }
  }
  
  void getPixel() {
    int x = mouseX/pxinc;
    int y = mouseY/pyinc;
    pArray[x][y] = 255;
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
  size(800, 600);
  display = new pixelMap(width, height);
}

void draw() {
  display.render();
  if (mousePressed == true) {
    fill(0, 0);
    stroke(0);
    rect(zoomVertexPoint[0], zoomVertexPoint[1], mouseX-zoomVertexPoint[0], mouseY-zoomVertexPoint[1]);
  }
}

void mousePressed() {
  zoomVertexPoint[0] = mouseX;
  zoomVertexPoint[1] = mouseY;
}

void keyPressed() {
  if (key == ' ') {
  }
  if (key == 's') {
  }
}