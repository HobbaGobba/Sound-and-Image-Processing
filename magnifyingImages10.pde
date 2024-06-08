PImage ducks;
PGraphics mask;
PGraphics circularmask;
String zoom;
int size = 2;

void setup (){
  size (960, 1280, P2D);
  ducks = loadImage("ducks.jpg");
//creating a mask with same dimensions of image
  mask = createGraphics(ducks.width, ducks.height, P2D);
  circularmask = createGraphics(ducks.width, ducks.height, P2D);
//  mask = createGraphics(620, 827);

  
}

void draw() {
  image(ducks, 0, 0);
  loadPixels(); //collecting canvas pixel data and turning it into an array from which we can extract colour info for rectangles
  
  mask.beginDraw(); //everything with "mask." in front of it is because it has to be drawn to the mask object.
  //background(shade, alpha);
  //clear only works on createGraphics object, makes everything transparent to start with, gets rid of the additive problem when zooming back out.
  mask.clear();
  for(int j = -50; j <= 50; j++){ //maybe change from j = -50 to j = 50 so that the new image made of rectangles is centered on the circle
      mask.pushMatrix();
      mask.translate(0, mouseY + (j * size)); //translating future rectangles by j * rect y dimension.
      for(int i = -50; i <= 50; i++){ //maybe change from i = -50 to i = 50
      mask.pushMatrix();
          mask.translate(mouseX + (i * size), 0); //translating future rectangles by i * rect x dimension.
          mask.noStroke();
          color sample = get(mouseX + i, mouseY + j); //colour sample extracted from original display not mask to extract colour.
          mask.fill(sample);//filling the rectangle with its respective pixel colour.
          mask.rect(0, 0, size, size); //the size of the rectangles will determine our magnifying level.
      mask.popMatrix();
      }
    mask.popMatrix();
  }
    mask.endDraw();
  
    //CONSTRUCTING A CIRCULAR MASK TO FRAME OUR MAGNIFIED REGION
    circularmask.beginDraw();
    circularmask.clear();
    circularmask.noStroke();
    circularmask.fill(255);
    circularmask.ellipse(mouseX, mouseY, 200, 200);
    circularmask.endDraw();
    
    //masking the mask into the circular mask. So the mask(rectangles) is displayed as a circle
    mask.mask(circularmask);
    //drawing the image at mouse position
    image(mask, mouseX/200, mouseY/200);//DIVIDING BY 200 is a bruteforce fix to the circle moving offset from the cursor
      
    //MAGNIFIER REGION OUTLINE //<>//
    fill(200, 0);
    stroke(220,120,120);
    strokeWeight(10);
    ellipse(mouseX, mouseY, 200, 200);
    //ZOOM TEXT DISPLAY
    fill(255); 
    textSize(32);
    textAlign(LEFT, CENTER);
    text("ZOOM LEVEL:" + size, 20, height - 40);    
        
    
}

void mouseWheel(MouseEvent event) {
  //event.getCount() returns 1 scrolling towards you and -1 away. 
  //Therefore subtracting the values instead makes scrolling away add to zoom level
  float scroll = event.getCount();
  size = size - event.getCount();
  
  //MINIMUM ZOOM SIZE = 2
    if (size < 2) {
    size = 2;
    
    }
  //MAXIMUM ZOOM SIZE = 100
    if (size > 100) {
    size = 100;
    }
  //TROUBLESHOOTING PRINTS
  println(scroll);
  println(zoom);
  println(size);
}
