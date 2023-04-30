ArrayList<Bloom> blooms = new ArrayList<Bloom>();
Audio audio;
color[] colors = {color(212, 237, 255), color(245, 215, 236), color(227, 240, 220), color(255, 224, 212), color(212, 237, 255)};
float t = 0; // time variable for gradient animation

void setup() {
  size(1000, 800);
  rectMode(CENTER);
  frameRate(60);
  audio = new Audio(this);
}

void draw() {
  // interpolate between the different colors based on t
  int i1 = floor(t * (colors.length - 1));
  int i2 = ceil(t * (colors.length - 1));
  color c = lerpColor(colors[i1], colors[i2], (t - i1 / (float)(colors.length - 1)) * (colors.length - 1));
  background(c);
  // increment t to animate the gradient
  t += 0.0005;
  if (t > 1) {
    t = 0;
  }
  for (int i = 0; i < blooms.size(); i++) {
    Bloom bloom = (Bloom)blooms.get(i);
    bloom.update();
    bloom.display();
  }
  for (int i = blooms.size() - 1; i >= 0; i--) {
    Bloom bloom = (Bloom)blooms.get(i);
    if (bloom.isZombie()){
      blooms.remove(i);
    }
  }
}

void makeBloom(float x, float y) {
  Bloom bloom = new Bloom(x, y);
  blooms.add(bloom);
}

void mousePressed() {
  makeBloom(mouseX, mouseY);
}
