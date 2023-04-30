import processing.video.*;

Movie movie;
PImage dementorImg;
PImage carImg;
PImage bg;
PImage dd;
float ddY = height; // starting position of the image
boolean slideUp = false; // flag to indicate if the image should slide up or down
ArrayList<Dementor> dementors;
Car car;

void setup() {
  size(1454, 941);
  bg = loadImage("hogwarts.jpg");
  dd = loadImage("dd.png");
  dementorImg = loadImage("dementor.png");
  dementors = new ArrayList<Dementor>();
  car = new Car(-50, random(0, 600), 15);
  movie = new Movie(this, "moviescene.mp4");
  movie.loop();
}

void keyPressed() {
  if (key == ' ') {
    slideUp = true;
  }
}
void mousePressed() {
  car.move();
}
void draw() {
  background(bg);
  car.display();
  car.move();

  stroke(0);
  strokeWeight(5);
  // Draw the lines
  line(784, 747, 857, 562);
  line(974, 742, 917, 621);

  noStroke();
  // Flash effect
  if (movie.time() >= 8 && movie.time() < 8.1) { // Light blue flash at 8 seconds
    fill(lerpColor(color(150, 200, 255, 0), color(150, 200, 255, 105), map(movie.time(), 8, 8.1, 0, 1)));
  } else if (movie.time() >= 16 && movie.time() < 16.1) { // Light yellow flash at 16 seconds
    fill(lerpColor(color(255, 255, 150, 0), color(255, 255, 150, 150), map(movie.time(), 16, 16.1, 0, 1)));
  } else if (movie.time() >= 24 && movie.time() < 24.1) { // Green flash at 24 seconds
    fill(lerpColor(color(0, 255, 0, 0), color(0, 255, 0, 150), map(movie.time(), 24, 24.1, 0, 1)));
  } else if (movie.time() >= 30 && movie.time() < 30.1) { // Red flash at 30 seconds
    fill(lerpColor(color(255, 0, 0, 0), color(255, 0, 0, 150), map(movie.time(), 30, 30.1, 0, 1)));
  } else if (movie.time() >= 43 && movie.time() < 43.1) { // Light blue flash at 43 seconds
    fill(lerpColor(color(150, 200, 255, 0), color(150, 200, 255, 150), map(movie.time(), 43, 43.1, 0, 1)));
  } else if (movie.time() >= 89 && movie.time() < 89.1) { // White flash at 1 min 29 sec
    fill(lerpColor(color(255, 255, 255, 0), color(255, 255, 255, 150), map(movie.time(), 89, 89.1, 0, 1)));
  } else if (movie.time() >= 95 && movie.time() < 95.1) { // White flash at 1 min 35 sec
    fill(lerpColor(color(255, 255, 255, 0), color(255, 255, 255, 150), map(movie.time(), 95, 95.1, 0, 1)));
  } else { // Default color
    fill(150, 200, 255, 0); // Light blue color that fades out over time
  }
  rect(567, 379, 611, 323);


  for (int i = dementors.size() - 1; i >= 0; i--) {
    Dementor d = dementors.get(i);
    d.update();
    d.display();
    if (!d.active) {
      dementors.remove(i);
    }
  }

  if (random(1) < 0.01 && dementors.size() < 4) {
    dementors.add(new Dementor());
  }
  // Slide up the image
  if (slideUp) {
    ddY = lerp(ddY, height / 2, 0.05);
    image(dd, 0, ddY);

    // Check if the image has reached the top
    if (ddY < height / 2 + 130) {
      slideUp = false;
    }
  }
  // Slide down the image
  else {
    ddY = lerp(ddY, height, 0.07);
    image(dd, 0, ddY);
  }
  image(movie, 650, 419, 461, 220);
}
void movieEvent(Movie movie) {
  movie.read();
}
