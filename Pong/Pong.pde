// FUSPONG!
// A fusball game inspired by pong

//import sound library from processing
import processing.sound.*;

//declare audio variables
SoundFile initialSong;

// Global variables for the paddles and the ball
Paddle goaliePlayer1;
Paddle topPlayer1;
Paddle bottomPlayer1;
Paddle goaliePlayer2;
Paddle topPlayer2;
Paddle bottomPlayer2;
Ball ball;

//Timer variable
Timer timer;

// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 25;
int PADDLE_HEIGHT = 70;
int PADDLE_WIDTH = 16;

//Size of the field lines
int borderSize = 8;

//declare image for background
PImage field;

//declare variable for score
int player1Scores;
int player2Scores;

//declare font variable and initialice strings for end game message
PFont win;
String player1Wins = "Player 1 Wins!";
String player2Wins = "Player 2 Wins!";


// setup()
//
// Sets the size and creates the paddles and ball

void setup() {
  // Set the size
  size(780, 480);
  
  //initialize background image and font
  field = loadImage("grass.jpg");
  win = createFont("Insanibc.ttf", 50);
  
  //initialize sound files
  initialSong = new SoundFile(this, "elPibe.mp3");
  

  //play song
  initialSong.play();

  //create left side paddles 
  goaliePlayer1 = new Paddle(PADDLE_INSET, height/2, PADDLE_HEIGHT/2, height-PADDLE_HEIGHT/2, '1', 'q');
  topPlayer1 = new Paddle(PADDLE_INSET*10, height/3, PADDLE_HEIGHT/2 + borderSize, height/2, '2', 'w');
  bottomPlayer1 = new Paddle(PADDLE_INSET*10, (height/3) + 200, height/2, height-PADDLE_HEIGHT/2-borderSize, '2', 'w');

  //create right side paddles 
  goaliePlayer2 = new Paddle(width - PADDLE_INSET, height/2, PADDLE_HEIGHT/2, height-PADDLE_HEIGHT/2, 'j', 'm');
  topPlayer2 = new Paddle(width - PADDLE_INSET*10, height/3, PADDLE_HEIGHT/2 + borderSize, height/2 - 100, 'h', 'n');
  bottomPlayer2 = new Paddle(width - PADDLE_INSET*10, (height/3) + 200, height/2 + 100, height-PADDLE_HEIGHT/2-borderSize, 'h', 'n');
  
  //create timer
  timer = new Timer();

  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2);
}

// draw()
//
// Handles all the magic of making the paddles and ball move, checking
// if the ball has hit a paddle, and displaying everything.

void draw() {
  //calls function where the background is handled
  soccerField();

  //makes the sound "move" according to where the ball is
  initialSong.pan(map(ball.x, 0, width, -1.0, 1.0));
  
  //update timer depending on the scores
  timer.update(player1Scores, player2Scores, ball);

  /// Update the paddles by calling its update method
  goaliePlayer1.update();
  topPlayer1.update();
  bottomPlayer1.update();

  //update the Ai paddles by calling cpuAi method which depends on the ball
  goaliePlayer2.cpuAi(ball);
  topPlayer2.cpuAi(ball);
  bottomPlayer2.cpuAi(ball);
  
  //update the ball by calling its update method
  ball.update();
  
  //calls the function that handles the score counting
  scoreCounter();

  // Display the paddles and the ball
  display();
  ball.display();  
}

void display() {

  //if eliminatePlayer2First is not true then display the blue top player and allow the ball to collide
  // the same logic applies to the bottom blue player and the top and bottom yellow players
  if (!eliminatePlayer2First()) {
    fill(0);
    topPlayer2.bluePlayersDisplay();
    ball.collide(topPlayer2);
  }

  if (!eliminatePlayer2Second()) {
    fill(0);
    bottomPlayer2.bluePlayersDisplay();
    ball.collide(bottomPlayer2);
  }

  //if eliminatePlayer2Third is not true then display blue goalie and allow the ball to colide. If it is true then end the game and display winner message
  //the same applies for the yellow goalie
  if (!eliminatePlayer2Third()) {
    fill(0);
    goaliePlayer2.bluePlayersDisplay();
    ball.collide(goaliePlayer2);
  } else {
    fill(232, 223, 46);
    textFont(win);
    text(player1Wins, width/2, height/2);
    ball.gameEnded();
  }

  if (!eliminatePlayer1First()) {
    fill(255);
    topPlayer1.yellowPlayersDisplay();
    ball.collide(topPlayer1);
  }

  if (!eliminatePlayer1Second()) {
    fill(255);
    bottomPlayer1.yellowPlayersDisplay();
    ball.collide(bottomPlayer1);
  }

  if (!eliminatePlayer1Third()) {
    fill(255);
    goaliePlayer1.yellowPlayersDisplay();
    ball.collide(goaliePlayer1);
  } else {
    fill(42, 32, 183);
    textFont(win);
    text(player2Wins, width/2, height/2);
    ball.gameEnded();
  }
}

//booleand that check wether or not a player should be displaying. 
//it checks the score of each player in order to call the display conditions
boolean eliminatePlayer2First() {

  return (player1Scores>0);
}

boolean eliminatePlayer2Second() {

  return (player1Scores>1);
}

boolean eliminatePlayer2Third() {

  return (player1Scores>2);
}

boolean eliminatePlayer1First() {

  return (player2Scores>0);
}

boolean eliminatePlayer1Second() {

  return (player2Scores>1);
}

boolean eliminatePlayer1Third() {

  return (player2Scores>2);
}

// scoreCounter() handles the counting of the score
void scoreCounter() {

  // if the ball crosses the left "net" then add 1 to player 2 score and reset the ball
  if (ball.offLeft()) {
    player2Scores++;
    ball.reset();
  }

  if (ball.offRight()) {

    // if the ball crosses the right "net" then add 1 to player 1 score and reset the ball
    player1Scores++;
    ball.reset();
  }
}

// soccerField() 
// creates the background
void soccerField() {

  //create background image
  background(field);

  //set ellipses to center and rect to corner
  ellipseMode(CENTER);
  rectMode(CORNER);

  //set no fill to the middle field circle, set white stroke and a weight of 8
  noFill();
  stroke(255);
  strokeWeight(8);

  //set ellipse to be in the middle
  ellipse(width/2, height/2, 200, 200);

  //create the middle field point
  fill(255);
  ellipse(width/2, height/2, 15, 15);
  
  //create top and bottom lines
  for (int x = 0; x <= width; x += borderSize) {
    fill(255);
    noStroke();
    rect(x, 0, borderSize, borderSize);
    rect(x, 472, borderSize, borderSize);
  }

  //create top side lines
  for (int y=0; y <= height/4; y+= borderSize) {
    fill(255);
    noStroke();
    rect(0, y, borderSize, borderSize);
    rect(772, y, borderSize, borderSize);
  }

  //create bottom side lines
  for (int y=360; y <= height; y+= borderSize) {
    fill(255);
    noStroke();
    rect(0, y, borderSize, borderSize);
    rect(772, y, borderSize, borderSize);
  }

  //create middle lines
  for (int y=0; y <= height; y+= borderSize) {
    fill(255);
    noStroke();
    rectMode(CENTER);
    rect(width/2, y, borderSize, borderSize);
  }
}


// keyPressed()
//
// The paddles need to know if they should move based on a keypress
// so when the keypress is detected in the main program we need to
// tell the paddles

void keyPressed() {
  // Just call both paddles' own keyPressed methods
  goaliePlayer1.keyPressed();
  topPlayer1.keyPressed();
  bottomPlayer1.keyPressed();
  goaliePlayer2.keyPressed();
  topPlayer2.keyPressed();
  bottomPlayer2.keyPressed();
}

// keyReleased()
//
// As for keyPressed, except for released!

void keyReleased() {
  // Call both paddles' keyReleased methods
  goaliePlayer1.keyReleased();
  topPlayer1.keyReleased();
  bottomPlayer1.keyReleased();
  goaliePlayer2.keyReleased();
  topPlayer2.keyReleased();
  bottomPlayer2.keyReleased();
}