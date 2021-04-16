import 'package:flutter/material.dart';
import 'package:snakutter/gameOverScreen.dart';

class GameOverScreen extends StatefulWidget {
  @override
  _GameOverScreenState createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            // children: [Text('Game is Over'), Text('Your Score: ' + scores)],
            ),
      ),
    );
  }
}

// _showGameOverScreen() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Game Over'),
//             content: Text('Your Score: ' + snakePositione.length.toString()),
//             actions: [
//               FlatButton(
//                 onPressed: () {
//                   startGame();
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Play Again'),
//               ),
//             ],
//           );
//         });
//   }