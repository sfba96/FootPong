// Ball
//
// A class that defines a ball that can move around in the window, bouncing
// of the top and bottom, and can detect collision with a paddle and bounce off that.

class Ball {

  //Set the speed and size of the ball
  float SPEED = 5;
  int SIZE = 16;

  // The location of the ball
  float x;
  float y;

  // The velocity of the ball
  float vx;
  float vy;

  //declare ball image
  PImage ballImage;

    /////////////// Constructor ///////////////

  // Ball(int _x, int _y)
  //
  // The constructor sets the variable to their starting values
  // x and y are set to the arguments passed through (from the main program)
  // and the velocity starts at SPEED for both x and y 
  // NOTE that I'm using an underscore in front of the arguments to distinguish
  // them from the class's properties
  Ball(int _x, int _y) {

    //set x and y to the location passed
    x = _x;
    y = _y;

    //set vx and vy to be equal to speed
    vx = SPEED;
    vy = SPEED;

    //load ball image
    ballImage = loadImage("ball.png");
  }

  // update()
  //
  // This is called by the main program once per frame. It makes the ball move
  // and also checks whether it should bounce of the top or bottom of the screen
  // and whether the ball has gone off the screen on either side.

  void update() {

    //ball movement change 
    //if ball 
    if (x <= width/2) {
      x += vx++;
      y += vy;
      
      vx = constrain(vx, -27,27);
      
      
    } else if (x>width/2) {
      x += vx--;
      y += vy;
      
      vx = constrain(vx, -27,27);
    }
    
    
    
    

    // Check if the ball is going off the top of bottom
    if (y - SIZE/2 < 16 || y + SIZE/2 > height - 16) {
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
    }

  // Check if the ball is going off the side boundaries
    if (x  < 16 || x > width - 16) {
      if (y - SIZE/2 <= height/4 -10 || y + SIZE/2 >= 370) { 
        vx = -vx;
      }
    }
  }

  //reset function locates the ball in the middle
  void reset() {
    x = width/2;
    y = height/2;
  }

  //booleans to check if the ball crosses any of the nets
  boolean offLeft() {

    return (x + SIZE/2 < 0);
  }

  boolean offRight() {

    return (x - SIZE/2 > width);
  }


  
  void collide(Paddle paddle) {
    // Calculate possible overlaps with the paddle side by side
    boolean insideLeft = (x + SIZE/2 > paddle.x - paddle.WIDTH/2);
    boolean insideRight = (x - SIZE/2 < paddle.x + paddle.WIDTH/2);
    boolean insideTop = (y + SIZE/2 > paddle.y - paddle.HEIGHT/2);
    boolean insideBottom = (y - SIZE/2 < paddle.y + paddle.HEIGHT/2);

    // Check if the ball overlaps with the paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = paddle.x + paddle.WIDTH/2 + SIZE/2;
      } else if (vx > 0) {
        // Reset its position to align with the left side of the paddle
        x = paddle.x - paddle.WIDTH/2 - SIZE/2;
      }
      // And make it bounce
      vx = -vx;
    }
  }

  // game ended resets the velocity of the ball to 0
  void gameEnded() {
    vx = 0;
    vy = 0;
  }

  void display() {
    
    // Set up image of the ball and resize it
    imageMode(CENTER);
    image(ballImage, x, y);
    ballImage.resize(SIZE, SIZE);
  }
}