Bacteria[] chemotaxis;
Atom[] oxygen;
float x_pos;
float y_pos;
float radius = 30;
float colorR = (float)(Math.random() * 255);
float colorG = (float)(Math.random() * 255);
float colorB = (float)(Math.random() * 255);
int screen = 0;
int atomicNum = 16;
void setup() {
  size(800, 600);
  background(200);
  chemotaxis = new Bacteria[100];
  oxygen = new Atom[atomicNum];
  for (int i = 0; i < chemotaxis.length; i++) {
    x_pos = (float)(Math.random() * width);
    y_pos = (float)(Math.random() * height);
    colorR = (float)(Math.random() * 255);
    colorG = (float)(Math.random() * 255);
    colorB = (float)(Math.random() * 255);
    chemotaxis[i] = new Bacteria(x_pos, y_pos, radius, colorR, colorG, colorB);
  }

  for (int j = 0; j < 4; j ++) {
    float yPos = 15 * j + height/2 - 50;
    for (int i = 0; i < 4; i ++) {
      float xPos = 15 * i + width/2 - 50;
      oxygen[j*4 + i] = new Atom(xPos, yPos, 20);
    }
  }
}   
void draw() {
  if (screen == 0) {
    initScreen();
  } else if (screen == 1) {
    chemotaxisSim();
  } else if (screen == 2) {
    atomSim();
  }
}  

void chemotaxisSim() {
  fill(200, 30);
  rect(0, 0, width, height);
  for (int i = 0; i < chemotaxis.length; i++) {
    chemotaxis[i].show();
  }

  fill(0);
  textSize(12);
  text("Return to home >", 70, 15);
  if (mouseX > 0 && mouseX < 150 && mouseY > 0 && mouseY < 30) {
    if (mousePressed) {
      screen = 0;
    } else {
      cursor(HAND);
    }
  } else {
    cursor(ARROW);
  }
}

void atomSim() {
  fill(200, 20);
  rect(0, 0, width, height);
  noStroke();

  for (int i = 1; i < 100; i++) {
    fill(154, 250, 225, i* 0.5);
    ellipse(width/2 - 25, height/2 - 25, 400-(2*i), 400-(2*i));
  }

  for (int i = 0; i < oxygen.length; i++) {
    oxygen[i].show();
  }
  fill(0);
  textSize(12);
  text("Return to home >", 70, 15);
  if (mouseX > 0 && mouseX < 150 && mouseY > 0 && mouseY < 30) {
    if (mousePressed) {
      screen = 0;
    } else {
      cursor(HAND);
    }
  } else {
    cursor(ARROW);
  }
}

void initScreen() {
  background(80);
  textAlign(CENTER);
  fill(135, 206, 250);
  textSize(80);
  text("Chemotaxis", width/2, height/2);
  textSize(25); 
  text("Chemotaxis Simulator", width/2 - 150, height- 80);
  text("Atom", width/2 + 150, height-80);

  if (mouseX > width/2 - 300 && mouseX < width/2 && mouseY > height - 120 && mouseY < height -40) {
    if (mousePressed) {
      screen = 1;
    } else {
      cursor(HAND);
    }
  } else {
    cursor(ARROW);
  }

  if (mouseX > width/2 + 120 && mouseX < width/2 + 180 && mouseY > height - 120 && mouseY < height -40) {
    if (mousePressed) {
      screen = 2;
    } else {
      cursor(HAND);
    }
  } else {
    cursor(ARROW);
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
    popMatrix();
    move();
    colorDot();
    bringIn();
    bringOut();
  }

  void move() {
    xPos += (float)(Math.random() * 10) - 5;
    yPos += (float)(Math.random() * 10) - 5;
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
        xPos -= 3;

      if (xPos < mouseX)
        xPos += 3;

      if (yPos > mouseY)
        yPos -= 3;

      if (yPos < mouseY)
        yPos += 3;
    }
  }
  
  void bringOut() {
    if (mousePressed && mouseButton == RIGHT) {
      if (xPos >= mouseX)
        xPos += 2;

      if (xPos <= mouseX)
        xPos -= 2;

      if (yPos > mouseY)
        yPos += 2;

      if (yPos < mouseY)
        yPos -= 2;
    }
  }
}   


class Atom {     
  float xPos;
  float yPos;
  float temp_x_pos;
  float temp_y_pos;
  float radius;
  float posX, posY;
  float radiusX, radiusY;
  float theta;
  boolean toggleTurn = true;
  public Atom(float x, float y, float radius) {
    xPos = x;
    yPos = y;
    this.radius = radius;
    posX = posY = 0;
    radiusX = random(100, 150);
    radiusY = random(100, 150);
    theta = 0;
  }

  void show() {
    if (toggleTurn) {
      moveRight();
    } else {
      moveReset();
    }

    stroke(7);
    stroke(255, 255, 255);
    fill(242, 35, 12);
    ellipse(xPos + 5, yPos - 7, radius, radius);
    fill(5, 56, 250);
    ellipse(xPos, yPos, radius, radius);
    bringIn();
    electron();
  }

  void moveRight() {
    temp_x_pos = xPos;
    temp_y_pos = yPos;
    xPos += ((float)(Math.random() * 2) - 1) * 3;
    yPos += ((float)(Math.random() * 2) - 1) * 3;
    toggleTurn = !toggleTurn;
  }

  void moveReset() {
    xPos = temp_x_pos;
    yPos = temp_y_pos;
    toggleTurn = !toggleTurn;
  }

  void electron() {
    theta += 0.4;

    posX = ((float)(Math.random() * 6) - 3) + radiusX * cos( theta );
    posY = ((float)(Math.random() * 6) - 3) + radiusY * sin( theta );
    pushMatrix();
    translate(width / 2 - 25, height / 2 - 25);
    fill(234, 234, 234);
    ellipse( posX, posY, 10, 10);
    popMatrix();
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
