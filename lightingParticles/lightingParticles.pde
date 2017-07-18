class particle {
   
  float x;
  float y;
  float px;
  float py;
  float magnitude;
  float angle;
  float mass;
   
  particle( float dx, float dy, float V, float A, float M ) {
    x = dx;
    y = dy;
    px = dx;
    py = dy;
    magnitude = V;
    angle = A;
    mass = M;
  }
   
  void reset( float dx, float dy, float V, float A, float M ) {
    x = dx;
    y = dy;
    px = dx;
    py = dy;
    magnitude = V;
    angle = A;
    mass = M;
  }
   
  void gravitate( particle Z ) {
    float F, mX, mY, A;
    if( sq( x - Z.x ) + sq( y - Z.y ) != 0 ) {
      mX = (x + mouseX) / 2;
      mY = (y + mouseY) / 2;
      A = findAngle( mX - x, mY - y );
       
      mX = cos(A) + magnitude * cos(angle);
      mY = sin(A) + magnitude * sin(angle);
      
      magnitude = sqrt( sq(mX) + sq(mY) );
      angle = findAngle( mX, mY );
    }
  }
 
  void repel( particle Z ) {
    float mX, mY, A;
    if( x - Z.x + y - Z.y != 0 ) {
      
      magnitude = sqrt(mouseX+mouseY);
      A = findAngle(x - mouseX, y - mouseY );
      
      mX = magnitude*cos(A);
      mY = magnitude*sin(A);
      
    }
  }
   
  void deteriorate() {
    magnitude *= 0.925;
  }
   
  void update() {
     
    x += magnitude * cos(angle);
    y += magnitude * sin(angle);
     
  }
   
  void display() {
    line(px,py,x,y);
    px = x;
    py = y;
  }
   
   
}
 
float findAngle( float x, float y ) {
  float theta;
  if(x == 0) {
    if(y > 0) {
      theta = HALF_PI;
    } else if(y < 0) {
      theta = 3*HALF_PI;
    } else {
      theta = 0;
    }
  } else {
    theta = atan( y / x );
    if(( x < 0 ) && ( y >= 0 )) { theta += PI; }
    if(( x < 0 ) && ( y < 0 )) { theta -= PI; }
  }
  return theta;
}

particle[] Z = new particle[6000];
float colour = random(1);
 
void setup() {
  
  size(500,500,P2D); 
  background(255);
   
  for(int i = 0; i < Z.length; i++) {
    Z[i] = new particle( random(width), random(height), 0, 0, 1 );
  }
   
  frameRate(60);
  colorMode(RGB,255);
 
}
 
void draw() {
   
  filter(INVERT);
 
  float r;
 
  stroke(0);
  fill(255);
  rect(0,0,width,height);
   
  colorMode(HSB,1);
  for(int i = 0; i < Z.length; i++) {
    if( mousePressed && mouseButton == LEFT ) {
      Z[i].gravitate( new particle( mouseX, mouseY, 0, 0, 1 ) );
    }
    else if( mousePressed && mouseButton == RIGHT ) {
      Z[i].repel( new particle( mouseX, mouseY, 0, 0, 1 ) );
    }
    else {
      Z[i].deteriorate();
    }
    Z[i].update();
    r = float(i)/Z.length;
    stroke( colour, pow(r,0.1), 1-r, 0.15 );
    Z[i].display();
  }
  colorMode(RGB,255);
   
  colour+=random(0.01);
  if( colour > 1 ) {
    colour = colour%1;
  }
 
  filter(INVERT);
   
}