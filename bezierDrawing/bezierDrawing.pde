ArrayList bezierCurves = new ArrayList();
int r = 10;
int[] selected = {-1, -1};

class Point {
  int x, y;
  
  Point(int tx, int ty) {
    x = tx;
    y = ty;
  }
  
  void draw() {
    stroke(255, 97, 100);
    fill(255, 97, 100);
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

class bezierCurve {
  
  Point[] points = new Point[4];
  
  bezierCurve() {
    for (int x=0;x<4;x++) {
      points[x] =new Point(int(random(width)), int(random(height)));
    }
  }
  
  void drawCurve() {
    noFill();
    bezier(points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y, points[3].x, points[3].y);
  }
  
  void drawPoints() {
    for (int x=0;x<4;x++) {
      ellipse(points[x].x, points[x].y, r, r);
    }
  }
  
  void draw() {
    stroke(255);
    line(points[0].x, points[0].y, points[1].x, points[1].y);
    line(points[2].x, points[2].y, points[3].x, points[3].y);
    bezier(points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y, points[3].x, points[3].y);
  }
  
  boolean update() {
    boolean found = false;
    for (int x=0;x<4;x++) {
      if (points[x].selected() == true) {
        selected[1] = x;
        found = true;
      }
    }
    return found;
  }
}

void addBezierCurve() {
  ArrayList test = new ArrayList();
  for (int z=0;z<4; z++) {
    test.add(new Point(int(random(width)), int(random(height))));
  }
  bezierCurves.add(test);
}

void setup() {
  size(800, 600);
  
  ArrayList test = new ArrayList();
  for (int z=0;z<4; z++) {
    test.add(new Point(int(random(width)), int(random(height))));
  }
  bezierCurves.add(test);
}

void draw() {
  
  background(0);
  
  for (int b=0; b<bezierCurves.size(); b++) {
    ArrayList tempL = (ArrayList) bezierCurves.get(b);
    for (int z=0;z<4; z++) {
      Point tempP = (Point) tempL.get(z);
      if (mousePressed == true && selected[0] == b && selected[1] == z) {
        tempP.x = mouseX;
        tempP.y = mouseY;
      }
      tempP.draw();
    }
  }
}

void mousePressed() {
  selected[0] = -1;
  
  for (int b=0; b<bezierCurves.size(); b++) {
    ArrayList tempL = (ArrayList) bezierCurves.get(b);
    for (int z=0;z<4; z++) {
      Point tempP = (Point) tempL.get(z);
      if (tempP.selected() == true) {
        selected[0] = b;
        selected[1] = z;
      }
    }  
  }
}

void keyPressed() {
  if (key == ' ') {
    addBezierCurve();
  }
}