//global
float a = (float) Math.PI/8;
float i = 0.75;
int c = 0;
boolean flag = false;
Leaves[] leaves;

void setup() {
  size(500,500);
  background(0);
  
  //tree
  translate(width/2, height);
  branch(100);
  c = 256;
  
  //leaves
  translate(0, 0);
  leaves = new Leaves[c/4];
  for (int i = 0; i < leaves.length; i++) {
    int x1 = (int) ( (width*0.25) + (i*(i/12)) );
    int y1 = (int) ( (height*0.35) + i );
    int x2 = (int) (x1 + (Math.random() * 11));
    int y2 = (int) (y1 + (Math.random() * 11));
    leaves[i] = new Leaves(x1, y1, x2, y2);
  }
}

void draw() {
  if (flag) {
    background(0);
    
    for (int j = 0; j < leaves.length; j++) {
      leaves[j].drop();
      leaves[j].show();
    }
    
    translate(width/2, height);
    branch(100);
  } 
}

//sc: https://natureofcode.com/book/chapter-8-fractals/
void branch(float len) {
  //color
  stroke(255);
  if (len < 11) {  // count: 256
    c++;
    stroke(#588157);
  }
  
  //draw the line after rotation
  line(0,0,0,-len);
  //moves the origin to tip of second branch
  translate(0,-len);
  
  if (len > 12) {
    //push + pop so that it doesn't rotate subsequent shapes
    pushMatrix();
    rotate(a);
    branch(len * i);
    popMatrix();
    
    //opp rotation
    pushMatrix();  
    rotate(-a/2.5);
    branch(len * i);
    popMatrix();
  }
}

class Leaves {
  float x1, y1, x2, y2, r, g, b;
  
  Leaves(float myX1, float myY1, float myX2, float myY2) {
    x1 = myX1;
    y1 = myY1;
    x2 = myX2;
    y2 = myY2;
    //color: 88, 129, 87
    r = (int)(Math.random()*20) + 88;
    g = (int)(Math.random()*20) + 129;
    b = (int)(Math.random()*20) + 87;
  }
  
  void drop() {
    if (y2 < height + 5) {
      y1 += (float) (Math.random());
      y2 += 0.5;
    }
  }
  
  void show() {
    translate(0, 0);
    stroke(r, g, b);
    line(x1, y1, x2, y2);
  }
} 

void mouseClicked() {
  flag = true;
}
