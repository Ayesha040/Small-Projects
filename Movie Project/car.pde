class Car {
  PImage carImage;
  float xpos, ypos, xspeed;

  Car(float xpos, float ypos, float xspeed) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.xspeed = xspeed;
    carImage = loadImage("hpcar.png");
  }

  void display() {
    push();
    scale(0.3);
    image(carImage, xpos, ypos);
    pop();
  }

  void move() {
    if (mousePressed) {
      xpos += xspeed;
      if (xpos > width * 4 - 50) {
        xpos = -carImage.width;
        ypos = random(0, 600);
      }
    }
  }
}
