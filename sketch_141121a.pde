import arb.soundcipher.*;
import java.util.*;

class SoundSensor {
  float pitch;  // Depending on the soundcipher library
  color c;      // Color for the button
  float x, y;   // Where we will put this object on the screen
  float r;      // radius

  SoundSensor(float pitch, color c, float x, float y, float r) {
    this.pitch = pitch;    
    this.c = c;
    this.x = x;
    this.y = y;
    this.r = r;
  }

  SoundSensor(float pitch, color c, float x, float y) {
    this(pitch, c, x, y, 40);
  }

  SoundSensor(SoundSensor s) {
    this(s.pitch, s.c, s.x, s.y, s.r);
  }

  boolean isInside(float x, float y) {
    if (dist(x, y, this.x, this.y)<=this.r)
      return true;
    else
      return false;
  }

  boolean isMouseInside() {
    return this.isInside(mouseX, mouseY);
  }
}

boolean arraysAreEqual(ArrayList<Float> a1, ArrayList<Float> a2) {
  HashSet<Float> set1 = new HashSet<Float>(a1);
  HashSet<Float> set2 = new HashSet<Float>(a2);
  return set1.equals(set2);
}

SoundCipher sc;
ArrayList<SoundSensor> sensors;
ArrayList<Float> inside;

void setup() {
  sc      = new SoundCipher(this);
  sc.instrument = sc.CELLO;

  sensors = new ArrayList<SoundSensor>();
  inside = new ArrayList<Float>();

  sensors.add(new SoundSensor(55, color(#FF0000), 40, 40));
  sensors.add(new SoundSensor(60, color(#808000), 120, 40));
  sensors.add(new SoundSensor(62, color(#00FFFF), 200, 40));
  sensors.add(new SoundSensor(64, color(#FF00FF), 200, 120));
  sensors.add(new SoundSensor(65, color(#A000A0), 120, 120));
  sensors.add(new SoundSensor(67, color(#FF0000), 120, 200));
  sensors.add(new SoundSensor(69, color(#FFFF00), 120, 280));

  smooth();
  size(800, 600);
}


void mouseClicked() {
  for (int i=0; i<sensors.size (); i++) {
    if (sensors.get(i).isMouseInside()) {
      sensors.add(new SoundSensor(sensors.get(i)));
      break;
    }
  }
}

void mouseDragged() {
  for (int i=0; i<sensors.size (); i++) {
    if (sensors.get(i).isMouseInside()) {
      sensors.get(i).x = mouseX;
      sensors.get(i).y = mouseY;
      break;
    }
  }
}


void mouseMoved() {
  ArrayList<Float> pitchesAL = new ArrayList<Float>();

  for (int i=0; i<sensors.size (); i++) {
    if (sensors.get(i).isMouseInside()) {
      pitchesAL.add(sensors.get(i).pitch);
    }
  }

  if (!arraysAreEqual(inside, pitchesAL)) {
    int n = pitchesAL.size(); 
    float [] pitches = new float[n];
    for (int i=0; i<n; i++) {
      pitches[i] = pitchesAL.get(i);
    }
    sc.playChord(pitches, 80, 2);
    inside = pitchesAL;
  }
}

void draw() {
  background(10, 100, 0);
  noStroke();

  for (int i=0; i<sensors.size (); i++) {
    fill(sensors.get(i).c);
    ellipse(sensors.get(i).x, sensors.get(i).y, sensors.get(i).r*2, sensors.get(i).r*2);
    fill(255);
    text(str(int(sensors.get(i).pitch)), sensors.get(i).x-10, sensors.get(i).y);
  }
}

