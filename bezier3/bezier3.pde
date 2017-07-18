float t = 0;
int r = 5;
ArrayList points = new ArrayList();
float ratio1 = 0, ratio2 = 1;

class Point {
  float x, y;
  
  Point(float tx, float ty) {
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

Point ratioDivider(Point p1, Point p2) {
  float x = (ratio1*p1.x+ratio2*p2.x)/(ratio1+ratio2);
  float y = (ratio1*p1.y+ratio2*p2.y)/(ratio1+ratio2);
  return new Point(x, y);
}

ArrayList generateMidpoints(ArrayList set) {
  ArrayList nList = new ArrayList();
  for (int x=0;x<set.size()-1;x++) {
    nList.add(ratioDivider((Point) set.get(x), (Point) set.get(x+1)));
  }
  return nList;
}

void connectPoints(ArrayList set) {
  if (set.size()==1) {
    Point p = (Point) set.get(0);
    p.draw();
  } 
    for (int p=0; p<set.size()-1; p++) {
      Point t1 = (Point) set.get(p);
      Point t2 = (Point) set.get(p+1);
      t1.draw();
      line(t1.x, t1.y, t2.x, t2.y);
      if (p==set.size()-2) {
        t2.draw();
      }
    }
  
}

void makeBezierCurve(ArrayList set) {
  ArrayList newPoints = new ArrayList();
  newPoints.add(set);
  for (int i=0;i<set.size();i++) {
    newPoints.add(generateMidpoints((ArrayList) newPoints.get(i)));
  }
  connectPoints((ArrayList) newPoints.get(set.size()-1));
}

void setup() {
  size(800, 600);
  strokeWeight(1);
  points.add(new Point(random(width), random(height)));
  points.add(new Point(random(width), random(height)));
  points.add(new Point(random(width), random(height)));
}

void draw() {
  
  t = t+0.01;
  if (t>1) {
    t = t%1;
  }
  
  ratio1=t;
  ratio2=1-t;
  
  connectPoints(points);
  makeBezierCurve(points);
}

void mousePressed() {
  background(255);
  points.add(new Point(mouseX, mouseY));
}

void keyPressed() {
  
  if (key == 'p') {
    println(points.size());
  }
}