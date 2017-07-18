Veroni testsForDays;
int n = 200;

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

class Veroni {
  
  int n, colourShift;
  Point[] points;
  
  Veroni(int in) {
    points = new Point[in];
    n = in; colourShift = int(360/in);
    
    for (int x=0; x<n; x++) {
      points[x] = new Point(int(random(width)), int(random(height)));
    }
    
  }
  
  int closest(int px, int py) {
    float[] minDistance = {0, 100000000, 0};
    for (int x=0; x<n; x++) {
      if (distance(px, py, points[x].x, points[x].y) < minDistance[1]) {
        minDistance[0] = x;
        minDistance[1] = distance(px, py, points[x].x, points[x].y);
      }
    }
    
    minDistance[2] = 0;
    for (int x=0; x<n; x++) {
      if (range(distance(px, py, points[x].x, points[x].y), minDistance[1]) < 1) {
        minDistance[2] += 1;
      }
    }
    
    if (minDistance[2] > 1) {
      return -1;
    } else {
      return int(minDistance[0]*colourShift);
    }
    //reurns colour respective to closest point  
  }
  
  void renderPoints() {
    for (int x=0; x<n; x++) {
      fill(x*colourShift, 97, 100);
      points[x].draw();
    }
  }
}

float distance(int x1, int y1, int x2, int y2) {
  float a = x1-x2, b = y1-y2;
  return sqrt(a*a+b*b);
}

float range(float a, float b) {
  float output1 = b-a, output2 = a-b;
  
  if (output1 < 0) {
    output1 = output1*-1;
  } if (output2 < 0) {
    output2 = output2*-1;
  } 
  
  if (output1 < output2) {
    return output1;
  } else {
    return output2;
  }
}

void render(Veroni set) {
  loadPixels();
    for (int x=0;x<width;x++) {
      for (int y=0;y<height;y++) {
        if (set.closest(x, y) == -1) {
          pixels[x + y * width] = color(0);
          pixels[x-1 + y * width] = color(0);
          pixels[x-2 + y * width] = color(0);
          pixels[x-3 + y * width] = color(0);
        } else {
          pixels[x + y * width] = color(set.closest(x, y), 97, 100); 
        }
      }
    }
  updatePixels();
}

void setup() {
  
  colorMode(HSB, 360, 100, 100);
  
  size(800, 600);
  testsForDays = new Veroni(n);
  
  render(testsForDays);
  testsForDays.renderPoints();
}

void draw() {
}

void mousePressed() {
  
  fill(testsForDays.closestMod(mouseX, mouseY), 97, 100);
  ellipse(mouseX, mouseY, 10, 10);
}

void keyPressed() {
  testsForDays = new Veroni(n);
  render(testsForDays);
  
}