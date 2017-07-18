branch test;
int maxIterations;
ArrayList b
branch[][] branchList = new ArrayList(2);

class branch {
  float l, a;
  float[] sP;
  
  branch(float length, float angle, float[] startPoint) {
    l = length;
    a = angle;
    sP = startPoint;
  }
  
  void draw() {
    line(sP[0], sP[1], sP[0]+l*sin(a*2*PI/360), sP[1]-l*cos(a*2*PI/360));
  }
  
  void changeAngle(float nAngle) {
    a = a+nAngle;
  }
  
  float[] endPoint() {
    float[] eP = {width/2+l*sin(a*2*PI/360), height/2-l*cos(a*2*PI/360)};
    return eP;
  }
}

void setup() {
  size(800, 600);
  float[] startPoint = {width/2, height};
  test = new branch(100, 0, startPoint);
  test.draw();
  branchList = append();
  
  for (int z=0;z<maxIterations;z++) {
    
  }
}

void draw() {
  
}