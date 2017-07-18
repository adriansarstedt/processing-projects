VeroniSet test;
Point center;

class Point {
  int x, y, r=10;
  
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
  
  double distance(int xe, int ye) {
    float dSquared = (x-xe)*(x-xe)+(y-ye)*(y-ye);
    return sqrt(dSquared);
  }
}

class VeroniSet {
  
  int n;
  Point[] points;
  
  VeroniSet(int in) {
    points = new Point[in];
    n = in;
    
    for (int x=0; x<n; x++) {
      points[x] = new Point(int(random(width)), int(random(height)));
    }
    
  }
  
  void renderPoints() {
    for (int p=0; p<n; p++) {
      points[p].draw();
    }
  }
}

void setup() {
  size(600, 500);
  
  test = new VeroniSet(20);
  test.renderPoints();
  
  center = new Point(width/2, height/2);
  
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      
    }
  }
}

void draw() {
  
}

void mousePressed() {
  println(center.distance(mouseX, mouseY));
}