# Tic-Tac-Toe
Final version of the project, with improved display and a play vs computer option, to play against AI.

Made by the Fantastic Duo [Oscar Nava](https://github.com/oscarnava) and [Matheus Silva](https://github.com/matheus-fls).

## INSTRUCTIONS

To start the game, in a terminal navigate to the root directory and type:

`ruby bin/main.rb`

or if using Windows you can simply run

`main.exe`

<img  align="right" width="400" src="img/screen_capture_1.jpg">

This is the starting screen of the game, here we have the header and two options, play vs human, which can be done by pressing "h" (not case sensitive) and pressing enter, or play vs computer, in a similar fashion typing "c" (not case sensitive) and pressing enter. This will lead to the main game.



On the main game state we have a numbered board, from 1 to 9, a list of valid moves and a message prompting for user input. Player X starts typing a number from the valid moves list and pressing enter. Player O will be prompted for a number from the valid moves list. If a player inputs an invalid number, he'll receive a warning and will be prompted for input again, until a valid value is provided. Game goes on until a player wins or ties. Players can play again by submitting "y", or quit after game over by submitting an "n". The game also keeps a score that is displayed by the end of each match.

<img src="img/screen_capture_2.jpg">
