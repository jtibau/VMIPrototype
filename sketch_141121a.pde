import arb.soundcipher.*;

SoundCipher sc;
PVector[] centers;
int inside = -1;  // -1 -> outside, otherwise index indicates which circle

//float[] pitches = {
//  60, 62, 64, 65, 67,69,55
//};

float[] pitches = {
  55, 60, 62, 64, 65, 67,69
};
void setup() {
  sc = new SoundCipher(this);
  centers = new PVector[7];
  
  centers[0] = new PVector(40, 40);
  centers[1] = new PVector(120, 40);
  centers[2] = new PVector(200, 40);
  
  centers[4] = new PVector(120, 120);
  centers[3] = new PVector(200, 120);

  centers[5] = new PVector(120, 200);
  
  centers[6] = new PVector(120, 280);
  
  //frameRate(360); // Do we have lag?
  smooth();
  size(240, 320);
}

void mouseMoved() {
  boolean outside = true;
  for (int i=0; i<centers.length; i++) {
    if (dist(mouseX, mouseY, centers[i].x, centers[i].y)<=40) {
      if (inside!=i) sc.playNote(pitches[i], 80, 1);
      inside = i;
      outside = false;
    }
  }
  if (outside) inside = -1;
}

void draw() {
  background(10, 100, 0);
  noStroke();
  int c = 0;
  for (int i=0; i<centers.length; i++) {
    //fill(c+=40);
    fill((float)i/(pitches.length-1)*255);
    ellipse(centers[i].x, centers[i].y, 80, 80);
  }
}

