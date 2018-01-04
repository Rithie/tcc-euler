import processing.serial.*;
import processing.opengl.*;

Serial fd;

int y = 0;

ArrayList<Points> poop = new ArrayList();
ArrayList<Points> teste = new ArrayList();

void setup () 
{
  size(640, 400,OPENGL); 
  //Connect to the corresponding serial port
  fd = new Serial(this, "/dev/cu.usbmodem1411", 19200);
  // Defer callback until new line
  fd.bufferUntil('\n');
}


void draw() {
  background(-1);
  //translate(width/2f, height/2f, 0f); // put 0,0 at screen center
  //scale(1,-1,1);  // flip y axis
  noFill();
  stroke(0,0,255);
  beginShape();
  for (int i=0; i< poop.size(); i++) {
    Points P = (Points) poop.get(i);
    vertex(P.x, P.y);
    if (P.x<0) poop.remove(i);
    P.x--;
  }
  endShape();
  noFill();
  stroke(0,250,0);
  beginShape();
  for (int i=0; i<teste.size(); i++) {
    Points P2 = (Points) teste.get(i);
    vertex(P2.x, P2.y);
    if (P2.x < 0) teste.remove(i);
    P2.x--;
  }
  endShape();
}

 void keyPressed() {
   float t = random(0, height-20);
   Points P = new Points(width, t );
   teste.add(P);
 }


void serialEvent (Serial fd) {

  try {
    // get the ASCII string:
    String rpstr = fd.readStringUntil('\n').trim();
 
      if (rpstr != null) {
          //print("teste: " + rpstr);
          y = parseInt(rpstr); 
          float m = map(y, 0, 1000, 0, height);
          print("\n\nvalor : " + m);
          Points P = new Points(width/2, y );
          poop.add(P); 
      }
  }
  catch(RuntimeException e) {
    //e.printStackTrace();
  }

}
class Points {
  float x, y;
  Points(float x, float y) {
    this.x = x;
    this.y = y;
  }
}