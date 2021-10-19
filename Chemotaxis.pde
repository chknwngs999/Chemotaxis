//left mouse to toggle biased movement
//middle mouse to clear trails
//right mouse to toggle trails
//enter to reset board/bacteria
//space to change background color
//shift to toggle bias strength (experimental)

//bias walk to have higher chance of moving towards mouse or move more towards mouse
//toggle bias strength (always biased or only biased when moving right direction)
//"species" of bacteria with "traits"
boolean bias = true;
boolean bias_strength = true;
boolean clear = false;
boolean trail = true;
color bg = color((int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
Bacteria [] bacteria = new Bacteria[(int)(Math.random()*26+5)];

void setup() {
  size(700, 700);
  background(bg);

  int i = 0;
  while (i < bacteria.length) {
    bacteria[i] = new Bacteria();
    i++;
  }
}

void draw() {
  if (clear) {
    fill(bg);
    clear = !clear;
  } else {
    if (trail) {
      fill(bg, 3);
    } else {
      fill(bg, 15);
    }
  }
  rect(0, 0, 700, 700);

  for (int i = 0; i < bacteria.length; i++) {
    bacteria[i].walk();
    bacteria[i].show();
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    bias = !bias;
  }
  if (mouseButton == RIGHT) {
    trail = !trail;
  }
  if (mouseButton == CENTER) {
    clear = !clear;
  }
}

void keyPressed() {
  if (keyCode == 32) {
    bg = color((int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
    //background(bg);
  }
  if (keyCode == ENTER) {
    background(bg);
    bacteria = new Bacteria[(int)(Math.random()*26+5)];
    int i = 0;
    while (i < bacteria.length) {
      bacteria[i] = new Bacteria();
      i++;
    }
  }
  if (keyCode == SHIFT){
    bias_strength = !bias_strength;
  }
}

//count mouse touch bacteria
//increased chance of moving towards mouse AND/OR increased movement when moving towards mouse/decreased movement when not moving towards mouse
class Bacteria {
  int myX, myY, oldX, oldY, xInc, yInc, dimension, speed;
  color linecolor;
  Bacteria() {
    myX = (int)(Math.random()*701);
    myY = (int)(Math.random()*701);
    xInc = (int)(Math.random()*9)-4;
    yInc = (int)(Math.random()*9)-4;
    linecolor = color((int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
    dimension = (int)(Math.random()*70+10);
    speed = 16 - dimension/5;
  }
  void walk() {
    oldX = myX;
    oldY = myY;
    if (bias) {
      if (bias_strength){ 
        if (mouseX > myX)
          xInc += 2;
        else if (mouseX < myX)
          xInc -= 2;
  
        if (mouseY > myY)
          yInc += 2;
        else if (mouseY < myY)
          yInc -= 2;
      } else { 
        if (mouseX > myX && xInc > 0)
          xInc += 2;
        else if (mouseX < myX && xInc < 0)
          xInc -= 2;
  
        if (mouseY > myY && yInc > 0)
          yInc += 2;
        else if (mouseY < myY && yInc < 0)
          yInc -= 2;
      }
    }
    myX += xInc;
    myY += yInc;
    xInc = (int)(Math.random()*(9+speed))-((9+speed)/2)+((9+speed)%2);
    yInc = (int)(Math.random()*(9+speed))-((9+speed)/2)+((9+speed)%2);
  }
  void show() {
    fill(linecolor);
    stroke(linecolor);
    ellipse(myX, myY, dimension, dimension);
  }
}
