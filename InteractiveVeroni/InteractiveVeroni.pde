PointSet test2;
int count2 = 0, vmax2 = 7;
boolean renderPoints = false, renderConnections = false, applyVelocity = false;

class Point {
  int x, y, r=5;
  
  Point(int tx, int ty) {
    x = tx;
    y = ty;
  }
  
  void draw() {
    fill(0);
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

class PointSet {
  Point[] points;
  int n;
  float[][] vectors;
  
  PointSet(int tn) {
    n = tn;
    points = new Point[n];
    vectors = new float[n][2];
    
    for (int x=0; x<n; x++) {
      points[x] = new Point(int(random(width)), int(random(height)));
      vectors[x][0] = vmax2-random(2*vmax2); vectors[x][1] = vmax2-random(2*vmax2);
    }
  }
  
  void draw() {
    for (int x=0; x<n; x++) {
      points[x].draw();
    }
  }
  
  void renderConnections(int p) {
    float[] distances = new float[n];
    
    for (int x=0; x<n; x++) {
      if (x != p) {
        distances[x] = distance(points[p], points[x]);
      }
    }
    
    float[] min1 = {0, 10000}, min2 = {0, 10000}, min3 = {0, 10000};
    
    for (int x=0; x<n; x++) {
      if (x != p) {
        if (distances[x] < min1[1]) {
          min3[0] = min2[0]; min3[1] = min2[1];
          min2[0] = min1[0]; min2[1] = min1[1];
          min1[0] = x; min1[1] = distances[x];
        } else if (distances[x] < min2[1]) {
          min3[0] = min2[0]; min3[1] = min2[1];
          min2[0] = x; min2[1] = distances[x];
        } else if (distances[x] < min3[1]) {
          min3[0] = x; min3[1] = distances[x];
        }
      }
    }
    
    line(points[p].x, points[p].y, points[int(min1[0])].x, points[int(min1[0])].y);
    
    
    line(points[p].x, points[p].y, points[int(min2[0])].x, points[int(min2[0])].y);
    
    
    line(points[p].x, points[p].y, points[int(min3[0])].x, points[int(min3[0])].y);
  }
  
  void Reload() {
    for (int x=0; x<n; x++) {
      renderConnections(x);
    }
  }
  
  void addVectors() {
    for (int x=0; x<n; x++) {
      if (points[x].x + int(vectors[x][0]) < 0 || points[x].x + int(vectors[x][0]) > width) {
        vectors[x][0] = -1*vectors[x][0];
      } else {
        points[x].x = points[x].x + int(vectors[x][0]);
      } if (points[x].y + int(vectors[x][1]) < 0 || points[x].y + int(vectors[x][1]) > height) {
        vectors[x][1] = -1*vectors[x][1];
      } else {
        points[x].y = points[x].y + int(vectors[x][1]);
      }
    }
    
    background(255);
    reload();
  }
}

float distance(Point a, Point b) {
  float e1 = a.x - b.x; float e2 = a.y - b.y;
  return sqrt(e1*e1+e2*e2);
}

void setup() {
  
  size(700, 700);
  background(255);
  
  test2 = new PointSet(100);
  
}

void draw() {
  count2++;
  if (count2%3==0 && applyVelocity) {
    test2.addVectors();
  }
}

void reload() {
  background(255);
  if (renderPoints) {
    test2.draw();
  } if (renderConnections) {
    test2.Reload();
  }
}

void Points() {
  if (renderPoints) {
    renderPoints = false;
  } else {
    renderPoints = true;
  }
  
  reload();
}

void Connections() {
  if (renderConnections) {
    renderConnections = false;
  } else {
    renderConnections = true;
  }
  
  reload();
}

void Velocity() {
  if (applyVelocity) {
    applyVelocity = false;
  } else {
    applyVelocity = true;
  }
}

void keyPressed() {
  if (key == '1') {
    Points();
  } if (key == '2') {
    Connections();
  } if (key == '3') {
    Velocity();
  } else {
    Velocity();
  }
}