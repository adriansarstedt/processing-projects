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
    fill(255); noStroke();
    ellipse(position.x, position.y, 10, 10);
  }
  
  void update() {
    
    
    fx = 0; fy = 0;
    
    for (int x=0; x<Commets.size(); x++) {
      Commet currentCommet = (Commet) Commets.get(x);
      if (distance(currentCommet.position, position.x, position.y) != 0) {
        //float d = distance(currentCommet.position, position.x, position.y);
        fx += currentCommet.position.x-position.x;
        fy += currentCommet.position.y-position.y;
      }
    }
    
    if (sqrt(vx*vx+vy*vy)>0) {
      vx += fx/100;
      vy += fy/100;
    }
    
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
  size(600, 400);
  background(0);
}

void draw() {
  background(0);
  
  for (int x=0; x<Commets.size(); x++) {
    Commet currentCommet = (Commet) Commets.get(x);
    currentCommet.update();
    currentCommet.draw();
  }
  
  if (mousePressed && mode == 0) {
    Commet currentCommet = (Commet) Commets.get(Commets.size()-1);
    currentCommet.setup(mouseX, mouseY);
  }
}

void mousePressed() {
  if (mode == 0) {
    Commets.add(new Commet(mouseX, mouseY));
  }
}

void mouseReleased() {
  if (mode == 0) {
    Commet currentCommet = (Commet) Commets.get(Commets.size()-1);
    currentCommet.vx = (currentCommet.position.x - mouseX)/20;
    currentCommet.vy = (currentCommet.position.y - mouseY)/20; 
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