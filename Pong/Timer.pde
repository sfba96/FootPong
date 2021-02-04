//Timer()
//Creates timer class

class Timer {

  //declare font variable for clock, string for the time, t to keep track of the time and interval to set the lapse of time
  PFont timeFont;
  String time;
  int t;
  int interval = 120;
  
  //declare font for the end message, initialize strings of winner messages and draw
  PFont win;
  String player1WinsMessage = "Player 1 Wins!";
  String player2WinsMessage = "Player 2 Wins!";
  String drawMessage = "Draw!";
  
  // Timer()
  //Constructor
  Timer() {
    
    //Set text to align in the center
    textAlign(CENTER);
    
    //initialize fonts
    timeFont = createFont("digital-7.regular.ttf", 50);
    win = createFont("Insanibc.ttf", 50);
  }

  //update()
  //set conditions for the timer to work depending on the scores
  
  void update(int player1Wins, int player2Wins, Ball ball) {

    //t substract the seconds from the interval
    t = interval-int(millis()/1000);
    
    //initialize integers for minutes and seconds
    int minutes = floor(t/60);
    int seconds = t - (minutes*60);

    //if t is greater than 0 and none of the players have won then display the clock
    if (t > 0 && player1Wins < 3 && player2Wins < 3) {
      fill(255);
      textFont(timeFont);
      text(nf(minutes, 2) + ":" + nf(seconds, 2), 60, 60);
    } 
    //if any of the players wins or is a draw then display the respective message and... 
    else {
      if (player1Wins > player2Wins) {
        fill(232, 223, 46);
        textFont(win);
        text(player1WinsMessage, width/2, height/2);
      } else if (player2Wins > player1Wins){
        fill(42,32, 183);
        textFont(win);
        text(player2WinsMessage, width/2, height/2);
      } else if (player2Wins == player1Wins){
        fill(0,255,0);
        textFont(win);
        text(drawMessage, width/2, height/2);
      }
      
      //set the clock to 0 and display red
      fill(255, 0, 0);
      textFont(timeFont);
      text(nf(0, 2) + ":" + nf(0, 2), 60, 60);
      ball.gameEnded();
     
    }
  }
}