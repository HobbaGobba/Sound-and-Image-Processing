PVector gravity, wind;
PImage forest;
Leaf leaf;
ArrayList<Leaf> leaves = new ArrayList<Leaf>();

void setup() {
  size(1731, 871);
  forest = loadImage("hauntedForest.png");
  gravity = new PVector(0, 0.05);
  leaf = new Leaf(200,200);
  
  //wind = new PVector(map(mouseX,0,width,-0.5,0.5),0);
  //system = new ArrayList();
} 

void draw() {
  background(0);
  image(forest,0,0);
  //this is a basic way to simulate wind
    //wind = new PVector(map(mouseX, 0, width, 0.5, -0.5), map(mouseY, 0, height, 0.2, -0.2)); //if the mouse is to the left the wind will blow right, mouse on right wind will blow left, mouse on bottom it will
  //blow upwards, and mouse ontop it will blow downwards.
  
    // Iterate through the list in reverse order to safely remove elements. Iterating in reverse order helps avoid index shifting issues when removing elements from the list.
    for (int i = leaves.size() - 1; i >= 0; i--) {
    Leaf leaf = leaves.get(i);
    leaf.addForces(gravity);
    leaf.update();
    leaf.display();
    
    // Remove the leaf if its lifespan is 0 or less
    if (leaf.lifespan <= 0) {
      leaves.remove(i);
    }
  }
}

//void mousePressed() {
//  leaf = new Leaf(mouseX, mouseY);
//}

void keyPressed() { 
  //SPACEBAR to create particles
  if (key == ' ') {
    //leaf = new Leaf(random(0,width), height/2); SINGLE LEAF
    for(int i = 0; i < 10; i++) {
    leaves.add(new Leaf(random(0,width), 0));
  }
  
  }
}
