import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';
import 'package:tic_tac_toe/style.dart';

enum PlayerType { player1, player2, none }

class OfflineTwoPlayerScreen extends StatefulWidget {
  const OfflineTwoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<OfflineTwoPlayerScreen> createState() => _OfflineTwoPlayerScreenState();
}

class _OfflineTwoPlayerScreenState extends State<OfflineTwoPlayerScreen> {
  List<PlayerType> gameData = [
    PlayerType.none,
    PlayerType.none,
    PlayerType.none,
    PlayerType.none,
    PlayerType.none,
    PlayerType.none,
    PlayerType.none,
    PlayerType.none,
    PlayerType.none,
  ];
  int currentIndex = -1;
  int timeCount = 1;
  bool isPlayer1 = false;
  bool isPlayer2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            playerScreen(),
            const SizedBox(height: 50),
            touchscreenGridView(),
          ],
        ),
      ),
    );
  }

  Container playerScreen() {
    return Container(
      child: timeCount % 2 == 0
          ? const Text("Player2's turn", style: bigFont)
          : const Text("Player1's turn", style: bigFont),
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
              currentIndex = index;
              showXorOAccordingToPlayer();
              checkPlayer1IsWinner();
              checkPlayer2IsWinner();
              if (timeCount == 10) {
                showTie(context);
              }
            });
          },
          icon: gameData[index] == PlayerType.player1
              ? Icons.lens_outlined
              : gameData[index] == PlayerType.player2
                  ? Icons.close_outlined
                  : Icons.question_mark_outlined,
          iconColor: gameData[index] == PlayerType.none
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
    if ((gameData[0] == PlayerType.player1 &&
            gameData[1] == PlayerType.player1 &&
            gameData[2] == PlayerType.player1) ||
        (gameData[3] == PlayerType.player1 &&
            gameData[4] == PlayerType.player1 &&
            gameData[5] == PlayerType.player1) ||
        (gameData[6] == PlayerType.player1 &&
            gameData[7] == PlayerType.player1 &&
            gameData[8] == PlayerType.player1) ||
        (gameData[1] == PlayerType.player1 &&
            gameData[4] == PlayerType.player1 &&
            gameData[7] == PlayerType.player1) ||
        (gameData[0] == PlayerType.player1 &&
            gameData[3] == PlayerType.player1 &&
            gameData[6] == PlayerType.player1) ||
        (gameData[2] == PlayerType.player1 &&
            gameData[5] == PlayerType.player1 &&
            gameData[8] == PlayerType.player1) ||
        (gameData[0] == PlayerType.player1 &&
            gameData[4] == PlayerType.player1 &&
            gameData[8] == PlayerType.player1) ||
        (gameData[2] == PlayerType.player1 &&
            gameData[4] == PlayerType.player1 &&
            gameData[6] == PlayerType.player1)) {
      showWinner(context, PlayerType.player1);
    }
  }

  void checkPlayer2IsWinner() {
    if ((gameData[0] == PlayerType.player2 &&
            gameData[1] == PlayerType.player2 &&
            gameData[2] == PlayerType.player2) ||
        (gameData[3] == PlayerType.player2 &&
            gameData[4] == PlayerType.player2 &&
            gameData[5] == PlayerType.player2) ||
        (gameData[6] == PlayerType.player2 &&
            gameData[7] == PlayerType.player2 &&
            gameData[8] == PlayerType.player2) ||
        (gameData[1] == PlayerType.player2 &&
            gameData[4] == PlayerType.player2 &&
            gameData[7] == PlayerType.player2) ||
        (gameData[0] == PlayerType.player2 &&
            gameData[3] == PlayerType.player2 &&
            gameData[6] == PlayerType.player2) ||
        (gameData[2] == PlayerType.player2 &&
            gameData[5] == PlayerType.player2 &&
            gameData[8] == PlayerType.player2) ||
        (gameData[0] == PlayerType.player2 &&
            gameData[4] == PlayerType.player2 &&
            gameData[8] == PlayerType.player2) ||
        (gameData[2] == PlayerType.player2 &&
            gameData[4] == PlayerType.player2 &&
            gameData[6] == PlayerType.player2)) {
      showWinner(context, PlayerType.player2);
    }
  }

  void showXorOAccordingToPlayer() {
    if (timeCount % 2 == 1) {
      if (gameData[currentIndex] == PlayerType.none) {
        gameData[currentIndex] = PlayerType.player1;
        timeCount++;
      }
    } else if (timeCount % 2 == 0) {
      if (gameData[currentIndex] == PlayerType.none) {
        gameData[currentIndex] = PlayerType.player2;
        timeCount++;
      }
    }
  }

  Future<dynamic> showWinner(BuildContext context, PlayerType player) {
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
