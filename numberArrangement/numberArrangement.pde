int n = 20;

Dictionairy numbers = new Dictionairy();

class Dictionairy {
  
  ArrayList main;
  
  Dictionairy() {  
    main = new ArrayList();
  }
  
  void add( float x ) {
    main.add(x);
  }
  
  float[] min() {
    
    float[] minSet = {0, 100000}; 
    
    for (int x=0; x<main.size(); x++) {
      if ((float) main.get(x) < minSet[1]) {
        minSet[0] = x;
        minSet[1] = (float) main.get(x);
      }
    }
    
    return minSet;
  }
  
  void removeIndex(int i) {
    main.remove(i);
  }
  
  float getIndex(int i) {
    return (float) main.get(i);
  }
  
  int findIndex(float member) {
    int i = 0;
    
    for (int x=0; x<main.size(); x++) {
      if ((float) main.get(x) == member) {
        i = x;
      }
    }
    
    return i;    
  }
}

void draw() {
  
}

void setup() {
  
  for (int i=0; i<n; i++) {
    numbers.add(random(width));
    println(numbers.getIndex(i));
  }
  
  println(numbers.min());
}