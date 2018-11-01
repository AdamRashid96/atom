Bacteria[] chemotaxis;
float x_pos;
float y_pos;
float radius = 40;
float colorR = (float)(Math.random() * 255);
float colorG = (float)(Math.random() * 255);
float colorB = (float)(Math.random() * 255);
void setup() {
  size(800, 600);
  background(200);
  chemotaxis = new Bacteria[100];
  for (int i = 0; i < chemotaxis.length; i++) {
    x_pos = (float)(Math.random() * width);
    y_pos = (float)(Math.random() * height);
    colorR = (float)(Math.random() * 255);
    colorG = (float)(Math.random() * 255);
    colorB = (float)(Math.random() * 255);
    chemotaxis[i] = new Bacteria(x_pos, y_pos, radius, colorR, colorG, colorB);
  }
}   
void draw() {
  background(200);
  for (int i = 0; i < chemotaxis.length; i++) {
    chemotaxis[i].show();
  }
  /*
  for (int i = 0; i < chemotaxis.length; i++) {
    chemotaxis[i].move();
  }
  */
}  
class Bacteria {     
  float xPos;
  float yPos;
  float radius;
  float colorR;
  float colorG;
  float colorB;
  public Bacteria(float x, float y, float radius, float colorR, float colorG, float colorB) {
    xPos = x;
    yPos = y;
    this.radius = radius;
    this.colorR = colorR;
    this.colorG = colorG;
    this.colorB = colorB;
  }

  void show() {
    pushMatrix();
    fill(0);
    stroke(5);
    translate(xPos, yPos);
    fill(colorR, colorG, colorB);
    ellipse(0, 0, radius, radius);
    popMatrix();
    move();
  }
  
  void move(){
    xPos += (float)(Math.random() * 4) - 2;
    yPos += (float)(Math.random() * 4) - 2;
  }
}    
