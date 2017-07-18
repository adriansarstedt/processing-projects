class Point {
  int x, y, r=10;
  
  Point(int tx, int ty) {
    x = tx;
    y = ty;
  }
  
  void draw() {
    ellipse(x, y, 2*r, 2*r);
  }
}

class PointSet {
  Point[] points;
  int size;
  
  PointSet(int n) {
    points = new Point[n];
    size = n;
    
    for (int x=0; x<n; x++) {
      points[x] = new Point(int(random(width)), int(random(height)));
    }
  }
  
  Point get(int p) {
    return points[p];
  }
  
  void draw() {
    for (int x=0; x<size; x++) {
      points[x].draw();
    }
  }
}

float distance(Point a, Point b) {
  float e1 = a.x - b.x; float e2 = a.y - b.y;
  return sqrt(e1*e1+e2*e2);
}

Point closestPoint(Point position, PointSet pointset) {
  
  float[] DistanceList = new float[pointset.size];
  float minimum = width + height;
  int minimumIndex = 0;
  
  for (int x=0; x<pointset.size; x++) {
    DistanceList[x] = distance(position, pointset.get(x));
  }
  
  for (int x=0; x<pointset.size; x++) {
    if ((DistanceList[x] < minimum) && (DistanceList[x] != 0)) {
      minimumIndex = x;
      minimum = DistanceList[x];
    }
  }
  
  return pointset.get(minimumIndex);
}

public void connectNClosestPoints(Point initialPosition, int N) {
  IntList 
  int colorShift = int(255/N-0.5), coloor = 0;
  Point currentPoint = initialPosition, nextClosestPoint;
  
  for (int x=0; x<N; x++) {
    nextClosestPoint = closestPoint(currentPoint, MainPointSet);
    
    fill(coloor);
    
    currentPoint.draw();
    nextClosestPoint.draw();
    line(currentPoint.x, currentPoint.y, nextClosestPoint.x, nextClosestPoint.y);
    
    coloor += colorShift;
    currentPoint = closestPoint(currentPoint, MainPointSet);
  }
}

PointSet MainPointSet;

public void setup() {
  size(500, 500);
  MainPointSet = new PointSet(100);
}

public void draw() {
  /*
  Point mousePosition = new Point(int(random(width)), int(random(height)));
  connectNClosestPoints(mousePosition, 5); 
  */
}

void mousePressed() {
  Point mousePosition = new Point(mouseX, mouseY);
  connectNClosestPoints(mousePosition, 10); 
}