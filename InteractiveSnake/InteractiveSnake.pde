float t = 0;
int l = 40;
int n = 20;
float r = 40;
float seperation = 0.005;
float seperationAngle = 2*PI/n;
boolean renderColor = false;

void setup() {
  size(400, 400);
}

void draw() {
  color(RGB);
  background(238);
  
  translate(width/2, height/2);
  
  for (int x=0; x<l; x++) {
    if (renderColor) {
      colorMode(HSB, 360, 100, 100);
      stroke(360*t%360, 97, 100, 100);
      fill(360*t%360, 97, 100, 50);
      colorMode(RGB);
    } else {
      fill(255, 100);
      stroke(0, 100);
    }
    for (int y=0; y<n; y++) {
      ellipse(x(t+x*seperation)+r*cos(seperationAngle*y), y(t+x*seperation)+r*sin(seperationAngle*y), 10, 10);
    }
  }
  
  t += 0.001;
}

float x(float t) {
  return 150*sin(7*PI*t);
}

float y(float t) {
  return 150*cos(5*PI*t);
}