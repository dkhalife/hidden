import java.awt.event.*;

PImage img;
float radius;

void setup(){
  img = loadImage("images.jpg");
  size(img.width, img.height);
  radius = 5;
  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
  }});
}

void draw(){
  loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      // Calculate the 1D pixel location
      int loc = x + y*img.width;
      // Get the R,G,B values from image
      float r = red   (img.pixels[loc]);
      float g = green (img.pixels[loc]);
      float b = blue  (img.pixels[loc]);
      // Calculate an amount to change brightness 
      // based on proximity to the mouse
      float distance = dist(x,y,mouseX,mouseY);
      float adjustBrightness = (radius-distance)/radius;  
      r *= adjustBrightness;
      g *= adjustBrightness;
      b *= adjustBrightness;
      // Constrain RGB to between 0-255
      r = constrain(r,0,255);
      g = constrain(g,0,255);
      b = constrain(b,0,255);
      // Make a new color and set pixel in the window
      color c = color(r,g,b);
      pixels[loc] = c;
    }
  }
  updatePixels();
}

void mouseWheel(int delta){
 radius = constrain(radius += -delta, 0, 100); 
}
