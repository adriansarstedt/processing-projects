
ArrayList Masses = new ArrayList(), Commets = new ArrayList();
int selected = -1; int mode = 0;
// 0 = mass move; 1 = mass scale; 2 = set commet;
int[] centreShift = {0, 0}; int radiusShift = 0; int selectedCommet = -1;

class Point {
  int x, y, r=10;
  
  Point(int tx, int ty) {
    x = tx;
    y = ty;
  }
}

class Mass {
  int m, r;
  Point position;
  
  Mass(int tm, int tx, int ty) {
    m = tm;
    position = new Point(tx, ty);
    r = m;
  }
  
  void draw() {
    fill(150);
    ellipse(position.x, position.y, 2*r, 2*r);
    fill(150, 100);
    ellipse(position.x, position.y, 4*r, 4*r);
  }
  
  int selected() {
    float d = sqrt((position.x-mouseX)*(position.x-mouseX) + (position.y-mouseY)*(position.y-mouseY));
    if (d<r) {
      return 0;
    } else if (d<2*r) {
      return 1;
    } else {
      return 2;
    }
  }
}

class Commet {
  float vx, vy, fx, fy;
  Point position;
  
  Commet(int tx, int ty) {
    position = new Point(tx, ty);
  }
  
  void setup(int tx, int ty) {
    float d = distance(position, tx, ty);
    fill(255, 100); noStroke();
    int[] pv = {tx-position.x, ty-position.y};
    triangle(position.x, position.y, tx+ty-position.y, ty+tx-position.x, tx-ty-position.y, ty-tx-position.x);
  }
  
  void draw() {
    fill(255);
    ellipse(position.x, position.y, 10, 10);
  } 
}

float distance(Point a, int bx, int by) {
  float e1 = a.x - bx; float e2 = a.y - by;
  return sqrt(e1*e1+e2*e2);
}

void setup() {
  background(0);
  size(800, 400);
  noStroke();
}

void draw() {
  background(0);
  
  if (mousePressed && selected != -1) {
    Mass currentObject = (Mass) Masses.get(selected);
    if (mode == 0) {
      currentObject.position.x = mouseX + centreShift[0];
      currentObject.position.y = mouseY + centreShift[1];
    } else if (mode == 1) {
      currentObject.r = int(distance(currentObject.position, mouseX, mouseY))-radiusShift;
      currentObject.m = int(distance(currentObject.position, mouseX, mouseY))-radiusShift;
    }
  } 
  
  if (mousePressed && selectedCommet != -1) {
    Commet currentCommet = (Commet) Commets.get(selectedCommet);
    currentCommet.setup(mouseX, mouseY);
  }
  
  for (int x=0; x<Commets.size(); x++) {
    Commet currentCommet = (Commet) Commets.get(x);
    currentCommet.draw();
  }
  
  for (int x=0; x<Masses.size(); x++) {
    Mass currentObject = (Mass) Masses.get(x);
    currentObject.draw();
  }
}

void mousePressed() {
  selected = -1;
  
  if (mode != 2) {
    for (int x=0; x<Masses.size(); x++) {
      Mass currentObject = (Mass) Masses.get(x);
      if (currentObject.selected() == 0) {
        selected = x; mode = 0;
        centreShift[0] = currentObject.position.x - mouseX; 
        centreShift[1] = currentObject.position.y - mouseY;
      } else if (currentObject.selected() == 1) {
        radiusShift = int(distance(currentObject.position, mouseX, mouseY) - currentObject.r);
        selected = x; mode = 1;
      }
    }
  
    if (selected == -1) {
      Masses.add(new Mass(20, mouseX, mouseY));
    }
  } else {
    selectedCommet = Commets.size()-1;
    Commets.add(new Commet(mouseX, mouseY));
  }
}

void keyPressed() {
  if (key == ' ') {
    Masses = new ArrayList();
  } if (key == 'm') {
    mode = 0;
  } if (key == 'c') {
    mode = 2;
  }
}