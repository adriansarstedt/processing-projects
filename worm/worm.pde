float t = 0;
int l = 50;
int n = 20;
float r = 40;
float seperation = 0.005;
float seperationAngle = 2*PI/n;

void setup() {
  fullScreen(P2D);
  //strokeWeight(5);
  blendMode(ADD);
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  background(0);
  
  fill(255, 100);
  translate(width/2, height/2);
  
  for (int x=0; x<l; x++) {
    stroke(360*t%360, 97, 100, 100);
    for (int y=0; y<n; y++) {
      
      ellipse(x(t+x*seperation)+r*cos(t*seperationAngle*y), y(t+x*seperation)+r*sin(t*seperationAngle*y), 10, 10);
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