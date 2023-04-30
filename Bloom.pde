float MAX_SIZE = random(100,200);

class Bloom {
  float x, y;
  float size;
  int cycle = 0;
  color color_val;
  SoundFile sound;

  Bloom(float x, float y) {
    this.x = x;
    this.y = y;
    size = 0;
    color_val = color(random(200, 255), random(100, 150), random(150, 200));
    sound = audio.makeRandomSound();
  }

  void update() {
    if (cycle <= 15) {
      size = size + 1;
      if (size >= MAX_SIZE) {
        size = 0;
        cycle += 1;
        float volume = map(cycle, 0, 15, 1.0, .2);
        sound.amp(volume);
        sound.play();
      }
    }
  }

  void display() {
    if (cycle <= 15) {
      float max = map(cycle, 0, 15, 255, 20);
      float alpha = map(size, 0, MAX_SIZE, max, 0);
      noStroke();
      fill(color_val, alpha);
      rectMode(CENTER);
      ellipse(x, y, size , size); // center circle
      for (int i = 0; i < 6; i++) {
        float angle = i * TWO_PI / 6;
        float petalX = x + size * cos(angle);
        float petalY = y + size * sin(angle) ;
        ellipse(petalX, petalY, size + 10, size + 10); // petals
      }
    }
  }

  boolean isZombie() {
    return cycle > 15;
  }
}
