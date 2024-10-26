import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';
import 'package:tic_tac_toe/style.dart';

enum PlayerType { player1, player2, none }

class SinglePlayerHardScreen extends StatefulWidget {
  const SinglePlayerHardScreen({Key? key}) : super(key: key);

  @override
  State<SinglePlayerHardScreen> createState() => _SinglePlayerHardScreenState();
}

class _SinglePlayerHardScreenState extends State<SinglePlayerHardScreen> {
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
  int randomNumber = -1;
  bool isPlayer1 = false;
  bool isPlayer2 = false;
  bool gotUniqueId = false;
  bool isPlayer1Winner = false;
  bool isPlayer2Winner = false;
  bool isGameEnd = false;

  @override
  @override
  void initState() {
    super.initState();
    makeFirstMove();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(timeCount);
    }
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
      setState(() {
        isPlayer1Winner = true;
        isGameEnd = true;
      });
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
      setState(() {
        isPlayer2Winner = true;
        isGameEnd = true;
      });
    }
  }

  void showXorOAccordingToPlayer() {
    if (timeCount % 2 == 0 && !isPlayer2Winner) {
      if (gameData[currentIndex] == PlayerType.none) {
        gameData[currentIndex] = PlayerType.player1;
        setState(() {
          timeCount++;
        });
        checkPlayer1IsWinner();
        checkPlayer2IsWinner();
      }
    }
    if (timeCount % 2 == 1 && !isPlayer1Winner && !isPlayer2Winner) {
      if (timeCount == 1) {
        makeFirstMove();
      }
      if (timeCount == 3) {
        makeThirdMove();
      }
      if (timeCount == 5) {
        makeFifthMove();
      }
      if (timeCount == 7) {
        makeSeventhMove();
      }
      if (timeCount == 9) {
        makeSeventhMove();
      }
      checkPlayer1IsWinner();
      checkPlayer2IsWinner();
    }
  }

  void makeFirstMove() {
    gameData[4] = PlayerType.player2;
    timeCount++;
  }

  void makeThirdMove() {
    if (gameData[1] == PlayerType.none &&
        gameData[0] == PlayerType.none &&
        gameData[2] == PlayerType.none) {
      gameData[1] = PlayerType.player2;
      timeCount++;
    } else if (gameData[3] == PlayerType.none &&
        gameData[0] == PlayerType.none &&
        gameData[6] == PlayerType.none) {
      gameData[3] = PlayerType.player2;
      timeCount++;
    } else if (gameData[5] == PlayerType.none &&
        gameData[2] == PlayerType.none &&
        gameData[8] == PlayerType.none) {
      gameData[5] = PlayerType.player2;
      timeCount++;
    } else if (gameData[7] == PlayerType.none &&
        gameData[6] == PlayerType.none &&
        gameData[8] == PlayerType.none) {
      gameData[7] = PlayerType.player2;
      timeCount++;
    }
  }

  void makeFifthMove() {
    if (gameData[1] == PlayerType.player2 && gameData[7] == PlayerType.none) {
      gameData[7] = PlayerType.player2;
      timeCount++;
    } else if (gameData[3] == PlayerType.player2 &&
        gameData[5] == PlayerType.none) {
      gameData[5] = PlayerType.player2;
      timeCount++;
    } else if (gameData[5] == PlayerType.player2 &&
        gameData[3] == PlayerType.none) {
      gameData[3] = PlayerType.player2;
      timeCount++;
    } else if (gameData[7] == PlayerType.player2 &&
        gameData[1] == PlayerType.none) {
      gameData[1] = PlayerType.player2;
      timeCount++;
    } else {
      if (gameData[1] == PlayerType.player2 &&
          gameData[7] == PlayerType.player1) {
        if (gameData[0] == PlayerType.none) {
          gameData[0] = PlayerType.player2;
        } else if (gameData[2] == PlayerType.none) {
          gameData[2] = PlayerType.player2;
        }
        timeCount++;
      } else if (gameData[3] == PlayerType.player2 &&
          gameData[5] == PlayerType.player1) {
        if (gameData[0] == PlayerType.none) {
          gameData[0] = PlayerType.player2;
        } else if (gameData[6] == PlayerType.none) {
          gameData[6] = PlayerType.player2;
        }
        timeCount++;
      } else if (gameData[5] == PlayerType.player2 &&
          gameData[3] == PlayerType.player1) {
        if (gameData[2] == PlayerType.none) {
          gameData[2] = PlayerType.player2;
        } else if (gameData[8] == PlayerType.none) {
          gameData[8] = PlayerType.player2;
        }
        timeCount++;
      } else if (gameData[7] == PlayerType.player2 &&
          gameData[1] == PlayerType.player1) {
        if (gameData[6] == PlayerType.none) {
          gameData[6] = PlayerType.player2;
        } else if (gameData[8] == PlayerType.none) {
          gameData[8] = PlayerType.player2;
        }
        timeCount++;
      }
    }
  }

  void makeSeventhMove() {
    if (gameData[0] == PlayerType.player2 &&
        gameData[1] == PlayerType.player2 &&
        gameData[2] == PlayerType.none) {
      gameData[2] = PlayerType.player2;
    } else if (gameData[0] == PlayerType.player2 &&
        gameData[2] == PlayerType.player2 &&
        gameData[1] == PlayerType.none) {
      gameData[1] = PlayerType.player2;
    } else if (gameData[1] == PlayerType.player2 &&
        gameData[2] == PlayerType.player2 &&
        gameData[0] == PlayerType.none) {
      gameData[0] = PlayerType.player2;
    } else if (gameData[3] == PlayerType.player2 &&
        gameData[4] == PlayerType.player2 &&
        gameData[5] == PlayerType.none) {
      gameData[5] = PlayerType.player2;
    } else if (gameData[3] == PlayerType.player2 &&
        gameData[5] == PlayerType.player2 &&
        gameData[4] == PlayerType.none) {
      gameData[4] = PlayerType.player2;
    } else if (gameData[4] == PlayerType.player2 &&
        gameData[5] == PlayerType.player2 &&
        gameData[3] == PlayerType.none) {
      gameData[3] = PlayerType.player2;
    } else if (gameData[6] == PlayerType.player2 &&
        gameData[7] == PlayerType.player2 &&
        gameData[8] == PlayerType.none) {
      gameData[8] = PlayerType.player2;
    } else if (gameData[6] == PlayerType.player2 &&
        gameData[8] == PlayerType.player2 &&
        gameData[7] == PlayerType.none) {
      gameData[7] = PlayerType.player2;
    } else if (gameData[7] == PlayerType.player2 &&
        gameData[8] == PlayerType.player2 &&
        gameData[6] == PlayerType.none) {
      gameData[6] = PlayerType.player2;
    } else if (gameData[0] == PlayerType.player2 &&
        gameData[3] == PlayerType.player2 &&
        gameData[6] == PlayerType.none) {
      gameData[6] = PlayerType.player2;
    } else if (gameData[0] == PlayerType.player2 &&
        gameData[6] == PlayerType.player2 &&
        gameData[3] == PlayerType.none) {
      gameData[3] = PlayerType.player2;
    } else if (gameData[3] == PlayerType.player2 &&
        gameData[6] == PlayerType.player2 &&
        gameData[0] == PlayerType.none) {
      gameData[0] = PlayerType.player2;
    } else if (gameData[1] == PlayerType.player2 &&
        gameData[4] == PlayerType.player2 &&
        gameData[7] == PlayerType.none) {
      gameData[7] = PlayerType.player2;
    } else if (gameData[1] == PlayerType.player2 &&
        gameData[7] == PlayerType.player2 &&
        gameData[4] == PlayerType.none) {
      gameData[4] = PlayerType.player2;
    } else if (gameData[4] == PlayerType.player2 &&
        gameData[7] == PlayerType.player2 &&
        gameData[1] == PlayerType.none) {
      gameData[1] = PlayerType.player2;
    } else if (gameData[2] == PlayerType.player2 &&
        gameData[5] == PlayerType.player2 &&
        gameData[8] == PlayerType.none) {
      gameData[8] = PlayerType.player2;
    } else if (gameData[2] == PlayerType.player2 &&
        gameData[8] == PlayerType.player2 &&
        gameData[5] == PlayerType.none) {
      gameData[5] = PlayerType.player2;
    } else if (gameData[8] == PlayerType.player2 &&
        gameData[5] == PlayerType.player2 &&
        gameData[2] == PlayerType.none) {
      gameData[2] = PlayerType.player2;
    } else if (gameData[0] == PlayerType.player2 &&
        gameData[4] == PlayerType.player2 &&
        gameData[8] == PlayerType.none) {
      gameData[8] = PlayerType.player2;
    } else if (gameData[4] == PlayerType.player2 &&
        gameData[8] == PlayerType.player2 &&
        gameData[0] == PlayerType.none) {
      gameData[0] = PlayerType.player2;
    } else if (gameData[2] == PlayerType.player2 &&
        gameData[4] == PlayerType.player2 &&
        gameData[6] == PlayerType.none) {
      gameData[6] = PlayerType.player2;
    } else if (gameData[6] == PlayerType.player2 &&
        gameData[4] == PlayerType.player2 &&
        gameData[2] == PlayerType.none) {
      gameData[2] = PlayerType.player2;
    }
    setState(() {
      timeCount++;
    });
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
