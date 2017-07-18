PImage img;

ArrayList bezierCurves = new ArrayList();
int r = 10;
int[] selected = {-1, -1};
boolean renderPoints = true, renderImage = true;

class Button {
  int x, y, w;
  
  Button(int tx, int ty, int tw) {
    x = ty;
    y = tx;
    w = tw;
  }
  
  void render() {
    rect(x, y, w, w);
  }
}


class Point {
  int x, y;
  
  Point(int tx, int ty) {
    x = tx;
    y = ty;
  }
  
  void draw() {
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
  
  void drawPoints() {
    for (int x=0;x<4;x++) {
      ellipse(points[x].x, points[x].y, r, r);
    }
    line(points[0].x, points[0].y, points[1].x, points[1].y);
    line(points[2].x, points[2].y, points[3].x, points[3].y);
  }
  
  void draw() {
    noFill();
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
  
  void print() {
    int ax, bx, cx, dx, ay, by, cy, dy;
    ax = points[3].x-3*points[2].x+3*points[1].x-points[0].x;
    bx = 3*points[2].x-6*points[1].x+3*points[0].x;
    cx = 3*points[1].x-3*points[0].x;
    dx = points[0].x;
    
    ay = points[3].y-3*points[2].y+3*points[1].y-points[0].y;
    by = 3*points[2].y-6*points[1].y+3*points[0].y;
    cy = 3*points[1].y-3*points[0].y;
    dy = points[0].y;
    
    println("x(t)="+ax+"t^3+"+bx+"t^2+"+cx+"t+"+dx);
    println("y(t)="+ay+"t^3+"+by+"t^2+"+cy+"t+"+dy);
  }
}

void setup() {
  size(800, 600);
  stroke(0, 0, 255);
  
  bezierCurve initialCurve = new bezierCurve();
  bezierCurves.add(initialCurve);
  
  img = loadImage("rat.jpg");
}

void draw() {
  
  if (renderImage) {
    image(img, 0, 0, width, height);
  } else {
    background(255);
  }
  
  
  for (int b=0; b<bezierCurves.size(); b++) {
    bezierCurve t = (bezierCurve) bezierCurves.get(b);
    
    if (mousePressed == true && selected[0] == b) {
      t.points[selected[1]].x = mouseX;
      t.points[selected[1]].y = mouseY;
    }
    
    if (renderPoints) {
      t.drawPoints();
    }
    
    t.draw();
  }
}

void mousePressed() {
  selected[0] = -1;
  
  for (int b=0; b<bezierCurves.size(); b++) {
    bezierCurve t = (bezierCurve) bezierCurves.get(b);
    if (t.update() == true) {
      selected[0] = b;
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    bezierCurve newCurve = new bezierCurve();
    bezierCurves.add(newCurve);
  }
  
  if (key == 'r') {
    if (renderPoints) {
      renderPoints = false;
    } else {
      renderPoints = true;
    }
  }
  
  if (key == 'i') {
    if (renderImage) {
      renderImage = false;
    } else {
      renderImage = true;
    }
  }
  
  if (key == 'p') {
    for (int b=0; b<bezierCurves.size(); b++) {
      bezierCurve t = (bezierCurve) bezierCurves.get(b);
      println("\nBezier Curve "+(b+1)+":");
      t.print();
    }
  }
}