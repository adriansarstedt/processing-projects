PointSet test;
int count = 0, vmax = 7;

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
      vectors[x][0] = vmax-random(2*vmax); vectors[x][1] = vmax-random(2*vmax);
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
    
    stroke((p*360/n+count)%360, 97, 100);
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
    
    colorMode(RGB); background(0);
    colorMode(HSB, 360, 100, 100);
    
    for (int x=0; x<n; x++) {
      //points[x].draw();
      renderConnections(x);
    }
  }
}

float distance(Point a, Point b) {
  float e1 = a.x - b.x; float e2 = a.y - b.y;
  return sqrt(e1*e1+e2*e2);
}

void setup() {
  
  size(1000, 400);
  //fullScreen(P2D);
  colorMode(HSB, 360, 100, 100);
  
  test = new PointSet(100);
  
}

void draw() {
  count++;
  if (count%3==0) {
    test.addVectors();
  }
}

void mousePressed() {
}

void keyPressed() {
  colorMode(RGB); background(0);
  colorMode(HSB, 360, 100, 100);
  test = new PointSet(500);
  test.Reload();
}