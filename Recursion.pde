float rotX = 0, rotY = 0;
int total = 0, saved = 0;
Wiggles wigs;

void setup() {
  fullScreen(P3D);
  background(0);
  wigs = new Wiggles();
}

void draw() {
  background(0);
  translate(width/2, height/2);
  
  if(!mousePressed)
    rotY += .01;
  rotateX(rotX);
  rotateY(rotY);

  strokeWeight(5);
  
  show();
}

void mouseDragged(){
  rotY += (mouseX - pmouseX) * 0.01;
  rotX -= (mouseY - pmouseY) * 0.01;
}

void show() {
  if(total < 3000) {
    total = millis() - saved;
    wigs.show();
  } else {
    saved += total;
    total = 0;
    wigs.update();
    wigs.show();
  }
}

class Wiggles {
  ArrayList<Wiggle> parts;
  
  Wiggles() {
    update();
  }
  
  void update() {
    parts = new ArrayList<Wiggle>();
    build(0, 0, 0, 1);
  }
  
  void build(float x, float y, float z, int layer) {
    int size;
    color c;
    if(layer == 3) {
      size = 10;
      c = #2BA25B;
    } else if(layer == 2) {
      size = 20;
      c = #4F5CAA;
    } else {
      size = 70;
      c = #CB5454;
    }
    for(int i = 0; i < 5; i++) {
      Wiggle temp = new Wiggle(x, y, z, size, c);
      parts.add(temp);
      if(layer != 3) {
        Line last = temp.lines[temp.lines.length-1];
        build(last.ex, last.ey, last.ez, layer+1);
      }
    }
  }
  
  void show() {
    for(Wiggle w : parts) {
      w.show();
    }
  }
}

class Wiggle {
  float x, y, z, len, angle;
  color c;
  Line[] lines;
  
  Wiggle(float x, float y, float z, float len, color c) {
    this.angle = random(2*PI);
    this.x = x;
    this.y = y;
    this.z = z;
    this.len = len;
    this.c = c;
    lines = new Line[10];
    update();
  }
  
  void update() {
    float sx = x;
    float sy = y;
    float sz = z;
    
    for(int i = 0; i < lines.length; i++) {
      angle += random(-.2, .2);
      float ex = sx + cos(angle) * len;
      float ey = sy + sin(angle) * len;
      float ez = sz + random(-1, 1) * len;
      lines[i] = new Line(sx, sy, sz, ex, ey, ez);
      sx = ex;
      sy = ey;
      sz = ez;
    }
  }
  
  void show() {
    for(Line l : lines) {
      stroke(c);
      line(l.sx, l.sy, l.sz, l.ex, l.ey, l.ez);
    }
  }
}

class Line {
  float sx, sy, sz, ex, ey, ez;
  
  Line(float sx, float sy, float sz, float ex, float ey, float ez) {
    this.sx = sx;
    this.sy = sy;
    this.sz = sz;
    this.ex = ex;
    this.ey = ey;
    this.ez = ez;
  }
}
