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
    
    float[] min1 = {0, 10000}, min2 = {0, 10000}, min3 = {0, 10000}, min4 = {0, 10000};
    
    float[][] sortedDistances = new float[n-1][2];
    IntList taken = new IntList();
    
    for (int c=0; c<n-1; c++) {
      sortedDistances[c][1] = 10000;
      for (int x=0; x<n; x++) {
        if (x != p && !taken.hasValue(x)) {
          if (distances[x] < sortedDistances[c][1]) {
            sortedDistances[c][0] = x;
            sortedDistances[c][1] = distances[x];
          }
        }
      }
      taken.append(int(sortedDistances[c][0]));
    }
    
    fill(200, 97, 100, 100);
    
    PShape test = createShape();
    test.beginShape();
    test.vertex(points[p].x, points[p].y);
    
    for (int x=0; x<4; x++) {
      test.vertex(points[int(sortedDistances[x][0])].x, points[int(sortedDistances[x][0])].y);
    }
    
    test.endShape(CLOSE);
    shape(test);
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
  
  test = new PointSet(10);
  
}

void draw() {
  count++;
  if (count%5==0) {
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