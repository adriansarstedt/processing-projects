ArrayList Commets = new ArrayList();
int mode = 0;

class Point {
  int x, y, r=10;
  
  Point(int tx, int ty) {
    x = tx;
    y = ty;
  }
}

class Commet {
  float vx = 0, vy = 0, fx = 0, fy = 0;
  Point position;
  
  Commet(int tx, int ty) {
    position = new Point(tx, ty);
  }
  
  void setup(int tx, int ty) {
    float d = distance(position, tx, ty);
    fill(255, 100); noStroke();
    int[] pv = {mouseY-position.y, -mouseX+position.x};
    triangle(position.x, position.y, mouseX+0.1*pv[0], mouseY+0.1*pv[1], mouseX-0.1*pv[0], mouseY-0.1*pv[1]);
  }
  
  void draw() {
    stroke(255);
    line(position.x, position.y, position.x+vx, position.y+vy);
  }
  
  void update() {

    fx = mouseX-position.x;
    fy = mouseY-position.y;
  
    vx += fx/100;
    vy += fy/100;
    
    println(fx);
    println(fy);
    
    position.x += vx;
    position.y += vy;
  }
}

float distance(Point a, int bx, int by) {
  float e1 = a.x - bx; float e2 = a.y - by;
  return sqrt(e1*e1+e2*e2);
}

void setup() {
  fullScreen(P2D);
  background(0);
  
  for (int x=0; x<100; x++) {
    Commets.add(new Commet(int(random(width)), int(random(height))));
  }
}

void draw() {
  background(0);
  
  for (int x=0; x<Commets.size(); x++) {
    Commet currentCommet = (Commet) Commets.get(x);
    currentCommet.draw();
    if (mousePressed) {
      currentCommet.update();
    }
  }
}

void mousePressed() {  
  for (int x=0; x<Commets.size(); x++) {
    Commet currentCommet = (Commet) Commets.get(x);
    currentCommet.vx = 0; currentCommet.vy = 0;
  }
}

void keyPressed() {
  if (key == 'c') {
    mode = 0;
  }
  
  if (key == 'm') {
    mode = 1;
  }
  
  if (key == ' ') {
    Commets = new ArrayList();
  }
}