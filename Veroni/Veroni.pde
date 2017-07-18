int n = 200;
int r = 5;
VeroniC test;

class VeroniC {
  
  Point[] points = new Point[n];
  int[][] pArray;
  
  VeroniC() {
    for (int x=0;x<n;x++) {
      points[x] =new Point(int(random(width)), int(random(height)));
    }
    
    pArray = new int[width][height];
    
  }
  
  void drawPoints() {
    for (int x=0;x<n;x++) {
      points[x].draw();
    }
  }
  
  void connect() {
    for (int x=0; x<width; x++) {
      for (int y=0; y<height; y++) {
        ArrayList distances = new ArrayList(n);
        float[] minIndex = {0, 100000};
        for (int p=0;p<n;p++) {
          distances.add(distance(new Point(x, y), points[p]));
          if ((float) distances.get(p) < minIndex[1]) {
            minIndex[0] = p;
            minIndex[1] = (float) distances.get(p);
          }
        }
        for (int p=0;p<n;p++) {
          
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

class Point {
  int x, y;
  
  Point(int tx, int ty) {
    x = tx;
    y = ty;
  }
  
  void draw() {
    ellipse(x, y, 2*r, 2*r);
  }
  
  Boolean selected() {
    float d = sqrt((x-mouseX)*(x-mouseX) + (y-mouseY)*(y-mouseY));
    if (d<r) {
      return true;
    } else {
      return false;
    }
  }
}

float distance(Point p1, Point p2) {
  float a = p1.x-p2.x;
  float b = p1.y-p2.y;
  return sqrt(a*a+b*b);
}

void setup() {
  size(800, 600);
  
  test = new VeroniC();
  test.drawPoints();
  test.connect();
}

void draw() {
  
}

void keyPressed() {
  if (key == ' ') {
    background(255);
    test = new VeroniC();
    test.drawPoints();
    test.connect();
  }
}