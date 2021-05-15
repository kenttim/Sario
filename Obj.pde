class Obj {
  
  int numFrames = 9;  
  int currentFrame = 0;
  PImage[] images = new PImage[numFrames];
  
  float objx, objy, objsize, objheight, objwidth, speed;
  Obj () {
    this(width+50, height*0.75-50);
  }
  Obj(int x, float y) {
    this.objx = x;
    this.objy = y;
    objsize = 50;
    objheight = 90;
    objwidth = 50;
    speed = 3;

    images[0]  = loadImage("Orc Grunt-0.png");
    images[1]  = loadImage("Orc Grunt-1.png"); 
    images[2]  = loadImage("Orc Grunt-2.png");
    images[3]  = loadImage("Orc Grunt-3.png"); 
    images[4]  = loadImage("Orc Grunt-4.png");
    images[5]  = loadImage("Orc Grunt-5.png"); 
    images[6]  = loadImage("Orc Grunt-6.png");
    images[7]  = loadImage("Orc Grunt-7.png"); 
    images[8]  = loadImage("Orc Grunt-8.png");
  }

  void draw() {
    scroll();
    
    currentFrame = (currentFrame+1) % numFrames;  
    image(images[(currentFrame) % numFrames], objx+10, objy-35, objwidth, objheight);
  }
  void scroll() {
    objx-=speed;
  }
}