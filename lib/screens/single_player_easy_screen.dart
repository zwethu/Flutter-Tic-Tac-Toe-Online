import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';
import 'package:tic_tac_toe/style.dart';

enum playerType { player1, player2, none }

class SinglePlayerEasyScreen extends StatefulWidget {
  const SinglePlayerEasyScreen({Key? key}) : super(key: key);

  @override
  State<SinglePlayerEasyScreen> createState() => _SinglePlayerEasyScreenState();
}

class _SinglePlayerEasyScreenState extends State<SinglePlayerEasyScreen> {
  List<playerType> gameData = [
    playerType.none,
    playerType.none,
    playerType.none,
    playerType.none,
    playerType.none,
    playerType.none,
    playerType.none,
    playerType.none,
    playerType.none,
  ];
  int currentIndex = -1;
  int timeCount = 1;
  int randomNumber = -1;
  bool isPlayer1 = false;
  bool isPlayer2 = false;
  bool gotUniqueId = false;
  bool isPlayer1Winner = false;
  bool isPlayer2Winner = false;
  bool isGameEnd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Your turn", style: bigFont),
            const SizedBox(height: 50),
            touchscreenGridView(),
          ],
        ),
      ),
    );
  }

  GridView touchscreenGridView() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: 9,
      itemBuilder: (BuildContext context, int index) {
        return TouchScreen(
          onTap: () {
            setState(() {
              if (!isGameEnd) {
                currentIndex = index;
                showXorOAccordingToPlayer();
              }
              if (timeCount == 10) {
                showTie(context);
              }
            });
          },
          icon: gameData[index] == playerType.player1
              ? Icons.lens_outlined
              : gameData[index] == playerType.player2
                  ? Icons.close_outlined
                  : Icons.question_mark_outlined,
          iconColor: gameData[index] == playerType.none
              ? Colors.transparent
              : Colors.white,
        );
      },
    );
  }

  Future<dynamic> showTie(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text(
            'Tie!',
            style: normalFont,
          ),
        ),
        actions: [
          TextButton(
            onPressed: (() {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (Route<dynamic> route) => false);
            }),
            child: const Text(
              'Exit',
              style: normalFont,
            ),
          ),
        ],
      ),
    );
  }

  void checkPlayer1IsWinner() {
   
      if ((gameData[0] == playerType.player1 &&
              gameData[1] == playerType.player1 &&
              gameData[2] == playerType.player1) ||
          (gameData[3] == playerType.player1 &&
              gameData[4] == playerType.player1 &&
              gameData[5] == playerType.player1) ||
          (gameData[6] == playerType.player1 &&
              gameData[7] == playerType.player1 &&
              gameData[8] == playerType.player1) ||
          (gameData[1] == playerType.player1 &&
              gameData[4] == playerType.player1 &&
              gameData[7] == playerType.player1) ||
          (gameData[0] == playerType.player1 &&
              gameData[3] == playerType.player1 &&
              gameData[6] == playerType.player1) ||
          (gameData[2] == playerType.player1 &&
              gameData[5] == playerType.player1 &&
              gameData[8] == playerType.player1) ||
          (gameData[0] == playerType.player1 &&
              gameData[4] == playerType.player1 &&
              gameData[8] == playerType.player1) ||
          (gameData[2] == playerType.player1 &&
              gameData[4] == playerType.player1 &&
              gameData[6] == playerType.player1)) {
        showWinner(context, playerType.player1);

        setState(() {
          isPlayer1Winner = true;
          isGameEnd = true;
        });
      }
    
  }

  void checkPlayer2IsWinner() {
    if ((gameData[0] == playerType.player2 &&
            gameData[1] == playerType.player2 &&
            gameData[2] == playerType.player2) ||
        (gameData[3] == playerType.player2 &&
            gameData[4] == playerType.player2 &&
            gameData[5] == playerType.player2) ||
        (gameData[6] == playerType.player2 &&
            gameData[7] == playerType.player2 &&
            gameData[8] == playerType.player2) ||
        (gameData[1] == playerType.player2 &&
            gameData[4] == playerType.player2 &&
            gameData[7] == playerType.player2) ||
        (gameData[0] == playerType.player2 &&
            gameData[3] == playerType.player2 &&
            gameData[6] == playerType.player2) ||
        (gameData[2] == playerType.player2 &&
            gameData[5] == playerType.player2 &&
            gameData[8] == playerType.player2) ||
        (gameData[0] == playerType.player2 &&
            gameData[4] == playerType.player2 &&
            gameData[8] == playerType.player2) ||
        (gameData[2] == playerType.player2 &&
            gameData[4] == playerType.player2 &&
            gameData[6] == playerType.player2)) {
      showWinner(context, playerType.player2);
      setState(() {
        isPlayer2Winner = true;
        isGameEnd = true;
      });
    }
  }

  void showXorOAccordingToPlayer() {
    if (timeCount % 2 == 1 && !isPlayer2Winner) {
      if (gameData[currentIndex] == playerType.none) {
        gameData[currentIndex] = playerType.player1;
        timeCount = timeCount + 1;
        checkPlayer1IsWinner();
        checkPlayer2IsWinner();
      }
    }
    if (timeCount % 2 == 0 && !isPlayer1Winner) {
      gotUniqueId = false;
      do {
        randomNumber = Random().nextInt(8);
        if (gameData[randomNumber] == playerType.none &&
            gameData[randomNumber] != playerType.player1) {
          gotUniqueId = true;
          timeCount = timeCount + 1;
        }
      } while (!gotUniqueId);
      if (gotUniqueId) {
        gameData[randomNumber] = playerType.player2;
        checkPlayer1IsWinner();
        checkPlayer2IsWinner();
      }
    }
  }

  Future<dynamic> showWinner(BuildContext context, playerType player) {
    String winner = player.name;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            '$winner win!!!',
            style: normalFont,
          ),
        ),
        actions: [
          TextButton(
            onPressed: (() {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (Route<dynamic> route) => false);
            }),
            child: const Text(
              'Exit',
              style: normalFont,
            ),
          ),
        ],
      ),
    );
  }
}

class TouchScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TouchScreen(
      {required this.onTap, required this.icon, required this.iconColor});
  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;

  @override
  State<TouchScreen> createState() => _TouchScreenState();
}

class _TouchScreenState extends State<TouchScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        margin: const EdgeInsets.all(4),
        child: Icon(
          widget.icon,
          size: 100,
          color: widget.iconColor,
        ),
      ),
    );
  }
}
