int factorial(int n) {
  int f = 1;
  for (int x=1;x<n+1;x++) {
    f = f*x;
  }
  return f;
}

int coefficiant(int n, int i) {
  return (factorial(n)/(factorial(i-1)*factorial(n-i+1)));
}

void setup () {
  println(coefficiant(5, 3));
}

void draw() {
  
}