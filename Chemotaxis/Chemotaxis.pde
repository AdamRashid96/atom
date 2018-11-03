Bacteria[] chemotaxis;
float x_pos;
float y_pos;
float radius = 30;
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
  fill(200, 30);
  rect(0, 0, width, height);
  for (int i = 0; i < chemotaxis.length; i++) {
    chemotaxis[i].show();
  }
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
    translate(xPos, yPos);
    noStroke();
    fill(colorR, colorG, colorB);
    ellipse(0, 0, radius, radius);
    //stroke(5, colorR, colorG, colorB);
    popMatrix();
    move();
    colorDot();
    bringIn();
  }

  void move() {
    xPos += (float)(Math.random() * 20) - 10;
    yPos += (float)(Math.random() * 20) - 10;
  }

  void colorDot() {
    if (dist(mouseX, mouseY, xPos, yPos) <= 20) {
      if (mousePressed && mouseButton == RIGHT) {
        colorR = 0;
        colorG = 0;
        colorB = 0;
      }

      if (mousePressed && mouseButton == CENTER) {
        colorR = 255;
        colorG = 255;
        colorB = 0;
      }
    }
  }

  void bringIn() {
    if (mousePressed && mouseButton == LEFT) {
      if (xPos > mouseX)
        xPos -= 2;

      if (xPos < mouseX)
        xPos += 2;

      if (yPos > mouseY)
        yPos -= 2;

      if (yPos < mouseY)
        yPos += 2;
    }
  }
}    
