// Import the sound library
import processing.sound.*;

SoundFile soundFile;
FFT fft;
float timbreFactor = 1.0; // Adjusts the timbre of the sound
float pitchFactor = 1.0; // Adjusts the pitch of the sound
LowPass filter;

void setup() {
  size(800, 600);
  // Load the sound file
  soundFile = new SoundFile(this, "sound.wav");
  fft = new FFT(this, 512);
  fft.input(soundFile);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(0);

  if (soundFile.isPlaying()) {
    // Adjust amplitude based on mouseY
    float amplitude = map(mouseY, height, 0, 0.1, 2);
    soundFile.amp(amplitude);

    // Adjust pitch based on mouseX
    float pitch = map(mouseX, 0, width, 0.1, 2);
    soundFile.rate(pitch * pitchFactor);

    // Visualize the waveform with noise and alternating transparency
    float[] waveform = new float[256];
    fft.analyze(waveform);

    noFill();
    beginShape();
    stroke(255);
    strokeWeight(2);
    for (int i = 0; i < waveform.length; i++) {
      float x = map(i, 0, waveform.length, 0, width);
      float y = height / 2 + map(waveform[i], -1, 1, -height, height) * 2; // Move twice as much
      // Add some noise to the y-coordinate
      y += random(-5, 5); // some vertical noise for more interesting shape. Although in terms of visualisation it will be misinforming :O
      if (i % 2 == 0) {
        stroke(255); // Not transparent
      } else {
        alpha(0); // Full transparency for odd
      }
      vertex(x, y);
      ellipse(x, y, 4, 4);
    }
    endShape();
  } else {
    // Drawing a horizontal line at the center of the screen when no sound is being played
    stroke(255);
    strokeWeight(2);
    line(0, height / 2, width, height / 2);
  }

  // Instructions
  fill(255);
  textSize(24);
  text("Click to play sound", width / 2, height / 2 + 40);
  text("Move mouse vertically to adjust volume", width / 2, height / 2 + 80);
  text("Move mouse horizontally to adjust pitch", width / 2, height / 2 + 120);
  text("Press '+' to increase timbre and '-' to decrease timbre", width / 2, height / 2 + 160);
  text("Press the spacebar to stop the sound being played", width / 2, height / 2 + 200);
  text("Timbre Factor: " + timbreFactor, width/2, height/4);
}

void keyPressed() {
  if (key == '+') {
    // Increase the cutoff frequency of the LowPass filter by 100
    timbreFactor += 0.1;
  } else if (key == '-' && timbreFactor > 0.1) {
    // Decrease the cutoff frequency of the LowPass filter by 100
    timbreFactor -= 0.1;
  } else if (key == ' ') {
    // Stop the sound if spacebar is pressed
    if (soundFile.isPlaying()) {
      soundFile.stop();
    }
  }
}

void mousePressed() {
  if (!soundFile.isPlaying()) {
    // Apply LowPass filter with adjusted timbre factor
    filter = new LowPass(this);
    filter.freq(1000 * timbreFactor); // Adjust the cutoff frequency based on the timbre factor
    filter.process(soundFile);
    soundFile.play();
  }
}
