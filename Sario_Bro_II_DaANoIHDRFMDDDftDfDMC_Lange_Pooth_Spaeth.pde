//full name: Sario Bro. II: Don’t ask about no. I, HD Remake: Forgotten memory, Dream Drop Distance and knuckles, 
//           lost in time feat. Dante from Devil May Cry

// By Austin Lange, Tim Pooth, and Nick Spaeth.

import processing.sound.*;
SoundFile music;

Obj[] a;

float[] xa, ya, s;

float objectX, objectY;               //object/enemy values
int attention;

float playerX, playerY, playerSize, playerWidth, playerHeight;       //player values

float go, fall;
boolean jump = false;
boolean lose;

int count, obj;
float clrChange;
int spawn1, spawn2;

int numFrames = 12;  
int currentFrame = 0;
PImage[] GenEric = new PImage[numFrames];

PImage forest;
PImage Dirt;

float scroll,scroll2;
void setup() {//////////////////////////////////////////////////////////////////////
  size(600, 400);
  
  scroll = 0;
  scroll2 = width;

  background(0);
  colorMode(HSB, 360, 100, 100);
  
  music = new SoundFile(this, "Action Music Loop 1.wav");
  music.play();
  
  forest = loadImage("pexels-photo-640781.jpeg");
  Dirt = loadImage("Dirt.jpg");

  GenEric[0]  = loadImage("Gen Eric-0.png");
  GenEric[1]  = loadImage("Gen Eric-1.png"); 
  GenEric[2]  = loadImage("Gen Eric-2.png");
  GenEric[3]  = loadImage("Gen Eric-3.png"); 
  GenEric[4]  = loadImage("Gen Eric-4.png");
  GenEric[5]  = loadImage("Gen Eric-5.png");
  GenEric[6]  = loadImage("Gen Eric-6.png");
  GenEric[7]  = loadImage("Gen Eric-7.png");
  GenEric[8]  = loadImage("Gen Eric-8.png");
  GenEric[9]  = loadImage("Gen Eric-9.png");
  GenEric[10]  = loadImage("Gen Eric-10.png");
  GenEric[11]  = loadImage("Gen Eric-11.png");



  playerX = width/4;
  playerY = height*0.75;
  playerSize = 10;
  playerHeight = 90;
  playerWidth = 50;

  spawn1 = 0;
  spawn2 = 0;

  obj = 0;
  count = max(width, height);
  fall = 0.1;

  attention = 0;

  lose = false;

  a = new Obj[count];
  for (int i = 0; i<200; ++i) {
    a[i] = new Obj();
    xa = new float[200];
    xa[i] = a[i].objx;
  }
}

void draw() {
  image(forest, 0, 0, width, height);
  image(Dirt, 0,300,width,100);

  scroll2 -=3;
  scroll -=3;
  if (scroll < -width){
    scroll = 0;
  }
  if (scroll2 <=0){
    scroll2 = width;
  }
  
    
  spawn();

  objectX = a[attention].objx;
  objectY = a[attention].objy;
  player();
  currentFrame = (currentFrame+1) % numFrames;  
  image(GenEric[(currentFrame) % numFrames], playerX, playerY-playerHeight, playerWidth, playerHeight);

  update(xa, ya);
  bg();
  noFill();
  if (objectX+50 < playerX) {
    attention = attention+1;
  }
  if (lose == true) {
    lose();
    music.stop();
    if (keyPressed) {
      if (keyCode == ' ') {
        setup();
      }
    }
  }
}

void spawn() {
  xa = new float[200];
  for (int i = 0; i<obj; i++) {
    xa[i] = a[i].objx;
  }
  spawn1 = spawn1 + round(random(1, 700));
  spawn2 = spawn2 + round(random(1, 500));
  if (spawn1 >= 50000) {
    obj += 1;
    spawn1 = 0;
  }
  if (spawn2 >= 70000) {
    obj += 1;
    spawn2 = 0;
  }
  for (int i=0; i<=obj; ++i) {
    a[i].draw();
  }
}

void player() {///////////////////////////////////////////////////////////////////

  if (keyPressed) {
    if (keyCode == UP || key == 'w' || key == 'W' || keyCode==' ') {
      if (playerY == height*0.75) {
        jump = true;
      }
    }
  }
  if (jump == false) {
    go = 6;
    fall = 0;
    playerY = height*0.75;
  }
  if (jump == true) {
    fall +=0.01;
    if (go > 0) {
      go -= fall;
    }
    if (go <=0) {
      go -= fall;
    }
    playerY-= go;
  }
  if (jump == true && playerY > height*0.75) {
    jump = false;
  }
  if (playerX >= xa[attention] && playerX <= (xa[attention]+50) && playerY >= objectY) {
    go = 6;
    fall = 0;
  }
}

void update(float[] x, float[] y) {////////////////////////////////////////////////////////////////////////////
  if (hitbox(playerX, playerY, playerWidth)) {
    lose = true;
  }
}


void bg() {////////////////////////////////////////////////////////////////////////
  image(Dirt, scroll,300,width,100);
  image(Dirt, scroll2,300,width,100);
}

void lose() {
  clrChange += 0.5;
  int score=0;
  if (xa[attention] < playerX) {
    score = score+1;
  }
  fill(0, 100, map(clrChange,0,100,100,0));
  rect(0, 0, width, height);
  fill(255);
  stroke(255);
  text("YOU LOSE", width/2, height/2-20);
  text("click to continue, hold on to your butt it takes a bit", width/2-100, height/2+10);
 // text("Your score was: " + (attention-score), width/2, height/2+30);
  if (keyPressed) {
    if (keyCode == ' ') {
      setup();
      lose = false;
    }
  }
}

void mousePressed() {
  setup();
}
void keyReleased() {
  if (go < height*0.75) {
    fall = 0.2;
  }
}

boolean hitbox(float x, float y, float d) {
  float disX1 = x - xa[attention];
  float disY1 = y - objectY;
  float disY2 = y - (objectY+25);
  float disY3 = y - (objectY+50);

  if (sqrt(sq(disX1) + sq(disY1)) < d/2 ||
    sqrt(sq(disX1) + sq(disY2)) < d/2 ||
    sqrt(sq(disX1) + sq(disY3)) < d/2 ) {
    return true;
  } else {
    return false;
  }
}