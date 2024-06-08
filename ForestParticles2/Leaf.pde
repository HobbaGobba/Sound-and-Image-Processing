class Leaf {
 PVector position;
 PVector velocity;
 PVector acceleration;
 float lifespan;
 float decay;
 float size;
 int colour; //EXPERIMENTING WITH GIVING OUT COLOUR RANDOMLY
 
 
 //constructor takes an X and Y which will be mouse position to construct.
 Leaf(float x, float y){
   position = new PVector(x,y);
   velocity = new PVector(random(-2,2), random(0.5,1)); //adding some random lateral velocity to be able to spawn many particles with varied paths and initial downwards momentum
   acceleration = new PVector(0,0);
   colour = int(random(4));
   size = random(0.8,1.4);
   lifespan = 550; 
   decay = 1; //rate of decay
 }
 //function for adding on external forces
 void addForces(PVector f){
  acceleration.add(f);
 }
 void update() {
  //Simulating wind depending on mouse cursor location
  PVector mousePos = new PVector(mouseX, mouseY);
  float disttoMouse = PVector.dist(position, mousePos);
  if (disttoMouse < 500){
    PVector wind = PVector.sub(position, mousePos);
    wind.normalize();
    //mapping the multiplication to wind to the distance of the mouse from the particle. The closer the mouse, the stronger the force applied.
    wind.mult(map(disttoMouse, 500,0, 0.05, 0.2));
    acceleration.add(wind);
  }
  
  lifespan -= decay; //Subtracting the rate of decay from the lifespan.
  velocity.add(acceleration);
  position.add(velocity);
  acceleration.mult(0);
  if (position.y >= height -5) { //if the particles circumference touches the bottom of the screen, (height - 10), the particle will cease to move, effectively being grounded.
    position.y = height - 5;
    velocity.mult(0);
    acceleration.mult(0);
  }
  
 }
 
 void display() {
   pushMatrix();
   translate(position.x, position.y);
   stroke(0, lifespan);
   //autumn colour pallette, assigning a colour to the life based on the random colour generated earlier.
   if (colour == 0) { // Dark Green
     fill(40, 54, 24, lifespan);
     }
   else if (colour == 1) { // Green
     fill(96, 108, 56, lifespan);
     }
   else if (colour == 2) { // Yellow
     fill(221, 161, 94, lifespan);
     }
   else if (colour == 3) { // Orange
     fill(188, 108, 37, lifespan);
     }  
   //later make this some leaf shaped object and then adjust the condition for touching the bottom of the screen accordingly.
   scale(size); //scaling the leaves depending on size
   ellipse(0,0,20,10);
   popMatrix();
   
 }
 
}
