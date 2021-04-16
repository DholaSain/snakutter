import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snakutter/myFood.dart';
import 'package:snakutter/myPixel.dart';
import 'package:snakutter/mySnake.dart';

// double scores;
List<int> snakePositione = [45, 65, 85, 105, 125];
var scores = snakePositione.length.toString();

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int numberofSquares = 500;
  int numberInRow = 20;
  bool gameHasStarted = false;

  static var randomNumber = Random();
  int food = randomNumber.nextInt(499);
  void generateNewFood() {
    food = randomNumber.nextInt(499);
  }

  void startGame() {
    gameHasStarted = true;
    snakePositione = [45, 65, 85, 105, 125];
    const duration = const Duration(milliseconds: 250);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        _showGameOverScreen();
      }
    });
  }

  var direction = 'down';
  void updateSnake() {
    setState(
      () {
        switch (direction) {
          case 'down':
            if (snakePositione.last > numberofSquares - numberInRow) {
              snakePositione
                  .add(snakePositione.last + numberInRow - numberofSquares);
            } else {
              snakePositione.add(snakePositione.last + numberInRow);
            }
            break;

          case 'up':
            if (snakePositione.last < numberInRow) {
              snakePositione
                  .add(snakePositione.last - numberInRow + numberofSquares);
            } else {
              snakePositione.add(snakePositione.last - numberInRow);
            }
            break;

          case 'left':
            if (snakePositione.last % numberInRow == 0) {
              snakePositione.add(snakePositione.last - 1 + numberInRow);
            } else {
              snakePositione.add(snakePositione.last - 1);
            }
            break;

          case 'right':
            if ((snakePositione.last + 1) % numberInRow == 0) {
              snakePositione.add(snakePositione.last + 1 - numberInRow);
            } else {
              snakePositione.add(snakePositione.last + 1);
            }
            break;

          default:
        }
        if (snakePositione.last == food) {
          generateNewFood();
        } else {
          snakePositione.removeAt(0);
        }
      },
    );
  }

  bool gameOver() {
    for (int i = 0; i < snakePositione.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePositione.length; j++) {
        if (snakePositione[i] == snakePositione[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  _showGameOverScreen() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('Your Score: ' + snakePositione.length.toString()),
            actions: [
              FlatButton(
                onPressed: () {
                  startGame();
                  Navigator.of(context).pop();
                },
                child: Text('Play Again'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 6,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (direction != 'up' && details.delta.dy > 0) {
                  direction = 'down';
                } else if (direction != 'down' && details.delta.dy < 0) {
                  direction = 'up';
                }
              },
              onHorizontalDragUpdate: (details) {
                if (direction != 'left' && details.delta.dx > 0) {
                  direction = 'right';
                } else if (direction != 'right' && details.delta.dx < 0) {
                  direction = 'left';
                }
              },
              child: Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: numberofSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 20),
                  itemBuilder: (BuildContext context, int index) {
                    if (snakePositione.contains(index)) {
                      return MySnake();
                    }
                    if (index == food) {
                      return MyFood();
                    } else {
                      return MyPixels();
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  height: 50,
                  onPressed: () {
                    direction = 'up';
                  },
                  color: Colors.grey[900],
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      height: 50,
                      splashColor: Colors.grey,
                      onPressed: () {
                        direction = 'left';
                      },
                      color: Colors.grey[900],
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20),
                    MaterialButton(
                      // minWidth: 30,
                      height: 50,
                      onPressed: () {
                        if (gameHasStarted == false) {
                          startGame();
                        }
                      },
                      color: Colors.grey[900],
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20),
                    MaterialButton(
                      height: 50,
                      onPressed: () {
                        direction = 'right';
                      },
                      color: Colors.grey[900],
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                MaterialButton(
                  height: 50,
                  onPressed: () {
                    direction = 'down';
                  },
                  color: Colors.grey[900],
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         startGame();
          //       },
          //       child: Text(
          //         'Start Game',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 20,
          //         ),
          //       ),
          //     ),
          //     Text(
          //       '@DholaSain',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 20,
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
