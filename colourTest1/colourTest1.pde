int colourAngle;

void setup() {
  fill(0, 0);
  size(640, 360);
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  rect(-1, -1, width+1, height+1);
  stroke( (colourAngle)%360, 97, 100);
  line(0, 0, mouseX, mouseY);
  colourAngle += 1;
}