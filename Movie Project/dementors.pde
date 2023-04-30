class Dementor {
  float x, y, speed, xSpeed;
  boolean active;
  int opacity;

  Dementor() {
    x = random(-dementorImg.width/2, width+dementorImg.width/2);
    y = random(0, height/6);
    speed = random(-1, 2);
    xSpeed = random(-8, 2);
    active = true;
    opacity = 255; // Set initial opacity to 255 (fully visible)
  }

  void update() {
    y -= speed;
    x += xSpeed;

    // Remove the dementor if it goes off the right or left of the screen
    if (x > width+dementorImg.width || x < -dementorImg.width) {
      active = false;
    }
    // Randomize the y position of the dementor within the top sixth of the screen
    if (y < 0) {
      y = random(0, height/2);
    }
    // Decrease opacity gradually as the dementor moves upwards
    opacity -= 3;
    if (opacity < 0) {
      active = false; // Remove the dementor when opacity reaches 0
    }
  }


void display() {
  if (active) {
    tint(255, opacity); // Set the tint to the current opacity value
    image(dementorImg, x, y, dementorImg.width/6, dementorImg.height/6);
    noTint(); // Reset the tint back to normal
  }
}
}
