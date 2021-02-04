// Paddle
//
// A class that defines a paddle that can be moved up and down on the screen
// using keys passed through to the constructor.

class Paddle {

  /////////////// Properties ///////////////

  // Default values for speed and size
  float SPEED = 5;
  int HEIGHT = 70;
  int WIDTH = 16;

  // The position and velocity of the paddle (note that vx isn't really used right now)
  int x;
  int y;
  float vx;
  float vy;

  //set the paddles boundaries
  int upperBound;
  int lowerBound;

  // The characters used to make the paddle move up and down, defined in constructor
  char upKey;
  char downKey;

  //declare players images
  PImage bluePlayer;
  PImage yellowPlayer;


  /////////////// Constructor ///////////////

  // Paddle(int _x, int _y, char _upKey, char _downKey)
  //
  // Sets the position and controls based on arguments,
  // starts the velocity at 0

  Paddle(int _x, int _y, int _upperBound, int _lowerBound, char _upKey, char _downKey) {
    x = _x;
    y = _y;
    vx = 0;
    vy = 0;
    upperBound = _upperBound;
    lowerBound = _lowerBound;

    //initialize players images
    bluePlayer = loadImage("bluePlayer.png");
    yellowPlayer = loadImage("yellowPlayer.png");


    upKey = _upKey;
    downKey = _downKey;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Updates position based on velocity and constraints the paddle to the window

  void update() {
    // Update position with velocity (to move the paddle)
    y += vy;

    // Constrain the paddle's y position to be in the window
    y = constrain(y, upperBound, lowerBound);
  }
  
  //cpuAi ()
  //set the logic for Ai depending on the ball location
  void cpuAi(Ball ball) {

    // if the location of the ball in the x axis is greater or equal to half of the canvas...
    if (ball.x >= width/2) {
      
      //if y is less than the ball location on y less the ball size then...
      if (y < ball.y-ball.SIZE) {
        
        //add speed to y
        y +=SPEED - 0.35;
        
      //else if is y is greater than the ball location on y less the ball size then...
      } else if (y > ball.y +ball.SIZE) {
        
        //substract speed to y
        y -= SPEED - 0.35;
      }
      
    // else if y is less than half of height then add speed to y
    //if y is greter than half of height then substract speed to y
    } else {
      if (y < height/2) {
        y+=SPEED;
        ;
      } 
      if ( y > height/2) {
        y-= SPEED;
      }
    }
    
    //constrain y to the boundaries
    y = constrain(y, upperBound, lowerBound);
  }

  // display()
  //
  // Display the paddle at its location

  void bluePlayersDisplay() {
    // Set display properties for blue players
    imageMode(CENTER);
    image(bluePlayer, x, y);
  }

  void yellowPlayersDisplay() {
    // Set display properties for yellow players
    imageMode(CENTER);
    image(yellowPlayer, x, y);
  }

  

  // keyPressed()
  //
  // Called when keyPressed is called in the main program

  void keyPressed() {
    // Check if the key is our up key
    if (key == upKey) {
      // If so we want a negative y velocity
      vy = -SPEED;
    } // Otherwise check if the key is our down key 
    else if (key == downKey) {
      // If so we want a positive y velocity
      vy = SPEED;
    }
  }

  // keyReleased()
  //
  // Called when keyReleased is called in the main program

  void keyReleased() {
    // Check if the key is our up key and the paddle is moving up
    if (key == upKey && vy < 0) {
      // If so it should stop
      vy = 0;
    } // Otherwise check if the key is our down key and paddle is moving down 
    else if (key == downKey && vy > 0) {
      // If so it should stop
      vy = 0;
    }
  }
}