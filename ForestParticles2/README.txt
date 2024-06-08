'FOREST SCENE'

Design Choices:
For my 'Forest Scene' I decided to go with autumn colours for the environment and leaves,
the perspective is of the user is of a person in the middle of a dark and eerie forest where no light
creeps in and they've just found a carved tree stump.

At first for the wind effect: I had chosen to implement it by creating a wind force vector
wind = new PVector(map(mouseX, 0, width, 0.5, -0.5), map(mouseY, 0, height, 0.2, -0.2));
where depending if you are on the left or right half of the screen, the wind would be blowing
toward right and left respectively; and depending if you were on the top or bottom of the screen,
the wind would blow towards the bottom and top respectively.
However, this would mean that all particles are affected uniformly, and there is no real connection
between the particle and mouse. Therefore I changed my approach so that a vector is calculated
between mouse position and particle, and depending on the proximity of the mouse, the winds intensity
would scale in a way where if you are closer to the particle, it is blown more strongly. This 
result is a lot more fun to play with.
I wanted wind to also affect the y position as it its fun to make a leaf float.



Instructions:
- Press the SPACEBAR to generate leaves
- Move the mouse closer to the leaves to blow them away more strongly, or farther to blow them more weakly.