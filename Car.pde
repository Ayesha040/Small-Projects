class Car {
  color c;
  float xpos;
  float ypos;
  float xspeed;

  Car(color c, float xpos, float ypos, float xspeed) {
    this.c = c;
    this.xpos = xpos;
    this.ypos = ypos;
    this.xspeed = xspeed;
  }

  void display() {
    //wheels
    fill(0);
    ellipse(xpos - 25, ypos - 15, 23, 23);
    ellipse(xpos + 25, ypos - 15, 23, 23);
    ellipse(xpos - 25, ypos + 15, 23, 23);
    ellipse(xpos + 25, ypos + 15, 23, 23);

    //body
    stroke(0);
    fill(c);
    strokeWeight(0);
    rectMode(CENTER);
    rect(xpos, ypos, 80, 40);
    rect(xpos + 30, ypos, 40, 30);
    //add a lighter color stripe going down thw middle of the body
    fill(255);
    strokeWeight(0);
    rectMode(CENTER);
    rect(xpos, ypos, 80, 10);
    //add two small rects for head lights
  }

  void move() {
    xpos = xpos + xspeed;

  }
}
