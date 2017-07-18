ArrayList initialPoints, iterationSet;
int selected = -1;
boolean renderPoints = true;

int n=20;
int r=10;
int iterations = 40;
int ratio1 = 1, ratio2 = 1;

// -1 represents no selected point

class Point {
  int x, y;
  float c;
  
  Point(int xPos, int yPos, float colour) {
    x = xPos;
    y = yPos;
    c = colour;
  }
  
  void draw() {
    stroke(c%360, 97, 100);
    fill(c%360, 97, 100);
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

void connectPoints(ArrayList set) {
  for (int x=0;x<n-1;x++) {
    stroke((x*360/n)%360, 97, 100);
    Point p1 = (Point) set.get(x);
    Point p2 = (Point) set.get(x+1);
    line(p1.x, p1.y, p2.x, p2.y);
  }
  
  stroke(((n-1)*360/n)%360, 97, 100);
  Point p1 = (Point) set.get(n-1);
  Point p2 = (Point) set.get(0);
  line(p1.x, p1.y, p2.x, p2.y);
}

Point ratioDivider(Point p1, Point p2) {
  int x = (ratio1*p1.x+ratio2*p2.x)/(ratio1+ratio2);
  int y = (ratio1*p1.y+ratio2*p2.y)/(ratio1+ratio2);
  return new Point(x, y, 0);
}

ArrayList generateMidpointSet(ArrayList set) {
  ArrayList nList = new ArrayList();
  for (int x=0;x<n-1;x++) {
    nList.add(ratioDivider((Point) set.get(x), (Point) set.get(x+1)));
  }
  nList.add(ratioDivider((Point) set.get(n-1), (Point) set.get(0)));
  return nList; 
}

void setup() {
  ellipseMode(CENTER);
  size(1000, 700);
  colorMode(HSB, 360, 100, 100);
  initialPoints = new ArrayList();
  
  for (int x=0;x<n;x++) {
    initialPoints.add(new Point(int(random(width)), int(random(height)), x*360/n));
  }
  
}

void draw() {
  background(55);
  
  iterationSet = new ArrayList();
  iterationSet.add(initialPoints);
  connectPoints((ArrayList) iterationSet.get(0));
  
  if (renderPoints == true) {
    for (int x=0;x<n;x++) {
      Point temp = (Point) initialPoints.get(x);  
      temp.draw();    
    }
  }
  
  for (int z=0;z<iterations;z++) {
    iterationSet.add(generateMidpointSet((ArrayList) iterationSet.get(z)));
    connectPoints((ArrayList) iterationSet.get(z+1));
  }
  
  if ((mousePressed == true) && (selected != -1)) {
    Point movingPoint = (Point) initialPoints.get(selected);
    movingPoint.x = mouseX;
    movingPoint.y = mouseY;
  }
}

void mousePressed() {
  
  selected = -1;
  
  for (int x=0;x<n;x++) {
    Point temp = (Point) initialPoints.get(x);
     
    if (temp.selected() == true) {
      selected = x;
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    initialPoints = new ArrayList();
  
    for (int x=0;x<n;x++) {
      initialPoints.add(new Point(int(random(width)), int(random(height)), x*360/n));
    }
  }
  
  if (key == 'r') {
    if (renderPoints == true) {
      renderPoints = false;
    } else {
      renderPoints = true;
    }  
  }
}