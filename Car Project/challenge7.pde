Car[] cars = new Car[3];
int rectWidth = 20;
int rectHeight = 20;
int rectSpacing = 80;
boolean gameStarted = true;
int winner = 0;
int winnerFrameCount = 0;

void setup() {
  size(1000, 500);
  cars[0] = new Car(color(#FFC5D9), 0, 150, random(4) + 3);
  cars[1] = new Car(color(#AEC6CF), 0, 250, random(4) + 3);
  cars[2] = new Car(color(#B19CD9), 0, 350, random(4) + 3);
}

void draw() {
  if (gameStarted) {
    background(227);
    drawBackground();
    for (int i = 0; i < cars.length; i++) {
      Car car = cars[i];
      car.move();
      car.display();
      if (car.xpos > width && winner == 0) {
        winner = i + 1;
        winnerFrameCount = frameCount;
      }
    }
    if (winner != 0) {
      fill(230, 100, 40);
      textSize(50);
      textAlign(CENTER);
      text("Car " + winner + " has won!", width/2, height/2);
      fill(0);
      textSize(30);
      text("Click to start again", width/2, height/2 + 40);
      if (frameCount - winnerFrameCount > 100) {
        winner = 0;
        gameStarted = false;
      }
    }
  }
}


void drawBackground() {
  strokeWeight(3);
  //lanes
  line(1030, 200, 0, 200);
  line(1030, 300, 0, 300);
  line(1030, 400, 0, 400);
  line(1030, 100, 0, 100);

  //grass
  fill(81, 166, 81);
  rect(198, 551, 1615, 298);
  rect(517, 22, 1085, 153);

  //top and bottom rows of rects
  drawRow(70);
  drawRow(430);
}

void drawRow(int y) {
  //red rectangles
  strokeWeight(1);
  fill(247, 0, 0);
  for (int i = 0; i < 20; i++) {
    float x = i * (rectWidth + rectSpacing) - frameCount * 5 % (rectWidth + rectSpacing);
    rect(x, y, rectWidth, rectHeight);
  }
  //white rectangles
  strokeWeight(1);
  fill(255);
  for (int i = 0; i < 20; i++) {
    float x = i * (rectWidth + rectSpacing) - frameCount * 5 % (rectWidth + rectSpacing) + rectSpacing / 2;
    rect(x, y, rectWidth, rectHeight);
  }
}
void resetCars() {
  cars = new Car[3];
  cars[0] = new Car(color(#FFC5D9), 0, 150, random(3) + 2);
  cars[1] = new Car(color(#AEC6CF), 0, 250, random(3) + 2);
  cars[2] = new Car(color(#B19CD9), 0, 350, random(3) + 2);
}

void mousePressed() {
  resetCars();
  for (Car car : cars) {
    car.xpos = 0;
  }
  gameStarted = true;
  winner = 0;
}
