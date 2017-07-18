Ball test;
int v = 50;
boolean recover = false;

class Ball {
  float vx, vy, a;
  int x, y, r;
  
  Ball() {
    vx = int(-v/2+random(v));
    vy = int(-v/2+random(v));
    r = int(random(10))+20;
    x = r+int(random(width-2*r));
    y = int(random(height));
    a = 0.09;
  }
  
  void draw() {
    x += vx;
    y += vy;
    vy += a;
    ellipse(x, y, 2*r, 2*r);
  }
  
  void collisionCheck() {
    if ((x-r < 0) || (x+r >= width)) {
      vx = -0.6*vx;
    } if (y+r >= height) {
      if ((recover == false) && (vy > 2)) {
        vy = -0.6*vy;
      }
      recover = true;
    } else {
      recover = false;
    }  
  }
}

void setup() {
  background(255);
  size(800, 600);
  test = new Ball();
}  

void draw() {
  background(255);
  test.collisionCheck();
  test.draw();
}  

void keyPressed() {
  if (key == ' ') {
    test = new Ball();
  }
}  