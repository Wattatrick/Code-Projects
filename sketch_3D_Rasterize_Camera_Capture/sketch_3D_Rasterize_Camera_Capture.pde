import processing.video.*;
import gab.opencv.*;
import java.awt.*;
Capture video;
OpenCV opencv;
float x = 100;
float y = 700;



PImage img;


void setup() {
  size(900, 900, P3D);
  
  //img = loadImage("cat2.jpg");
  img = createImage(900,900,RGB);
  img.resize(900,900);
  
  textSize(70);
  
  //noStroke();
  
  String[] cameras = Capture.list();
  println(cameras);
    if (cameras.length == 0) 
    {
      println("There are no cameras available for capture.");
      //exit();
    } 
    else 
    {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) 
      {
        println(cameras[i]);
      }
      video = new Capture(this, cameras[0]);
      video.start();
      opencv = new OpenCV(this, 640, 480);
      opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
     
    }
}



void draw() {
  background(#f1f1f1);
  
  video.read();
  opencv.loadImage(video);
  Rectangle[] faces;
  faces = opencv.detect();
  println(faces);
  if(faces.length > 0)
  {
    //
    float sum = 0;
    int index = -1;
    for (int i = 0; i < faces.length; i++) 
    {
      float buf = faces[i].width+faces[i].height;
      if(buf > sum)
      {
        sum = buf;
        index = i;
      }
   }
   noFill();
   stroke(255,0,0);
   strokeWeight(1);
   rect(faces[index].x,faces[index].y,faces[index].width,faces[index].height);
   img.resize(faces[index].width,faces[index].height);
   img.copy(video,faces[index].x,faces[index].y,faces[index].width,faces[index].height,0,0,faces[index].width,faces[index].height);
   img.resize(900,900);
   
  }
  
  
  image(video, 0, 0 );
   
  background(255);

{
  fill(204, 120);
  rect(0, 0, width, height);
  fill(124);
  // If cursor is over the text, change the position
  if ((mouseX >= x) && (mouseX <= x+55) &&
    (mouseY >= y-24) && (mouseY <= y)) {
    x += random(-20, 20);
    y += random(-20, 20);
  }
  text("BE YOUR TRUE SELF", x, y);
}

  //image(img,0,0);
  fill(0);
  


  
  noStroke();
  sphereDetail(3);
  //ellipse(mouseX,mouseY,40,40);
  
  
  float tiles = 100;
  float tileSize = width/tiles;
  
  push();
  translate(width/2,height/2);
  rotateY(radians(frameCount));
  
  for (int x = 0; x < tiles; x++) {
     for (int y = 0; y < tiles; y++) {
       color c = img.get(int(x*tileSize),int(y*tileSize));
       float b = map(brightness(c),0,255,1,0);
       
       float z = map(b,0,1,-100,100);
       
       
       push();
       translate(x*tileSize -width/2,y*tileSize - height/2, z);
       sphere(tileSize*b*0.8);
       pop();
      //ellipse(x * tileSize,y*tileSize,10,10);
     }
  }
  pop();
}
