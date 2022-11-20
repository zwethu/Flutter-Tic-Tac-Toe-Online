import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';
import 'package:tic_tac_toe/style.dart';

enum playerType { player1, player2, none }

class OnlineMultiplayerScreen extends StatefulWidget {
  final bool isRoomOwner;
  final String roomID;
  const OnlineMultiplayerScreen({
    Key? key,
    required this.isRoomOwner,
    required this.roomID,
  }) : super(key: key);

  @override
  State<OnlineMultiplayerScreen> createState() =>
      _OnlineMultiplayerScreenState();
}

class _OnlineMultiplayerScreenState extends State<OnlineMultiplayerScreen> {
  List<dynamic> gameData = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  final _firestore = FirebaseFirestore.instance;
  dynamic data;
  int currentIndex = -1;
  int timeCount = 1;
  bool isPlayer1 = false;
  bool isPlayer2 = false;
  bool isGameEnd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: StreamBuilder(
            stream: _firestore
                .collection('GameData')
                .doc(widget.roomID)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                final data = snapshot.data;
                timeCount = data['timeCount'];
                gameData = data['gameData'];
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  checkPlayer1IsWinner();
                  checkPlayer2IsWinner();
                  if (timeCount == 10) {
                    showTieMessage(context);
                  }
                });
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      playerScreen(),
                      const SizedBox(
                        height: 30,
                      ),
                      touchscreenGridView(),
                      const SizedBox(height: 50),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const CircularProgressIndicator();
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Container playerScreen() {
    return Container(
      child: timeCount % 2 == 0 && widget.isRoomOwner
          ? const Text("Other Player's turn", style: bigFont)
          : timeCount % 2 == 0 && widget.isRoomOwner == false
              ? const Text("Your turn", style: bigFont)
              : timeCount % 2 == 1 && widget.isRoomOwner
                  ? const Text("Yours turn", style: bigFont)
                  : const Text("Other Player's turn", style: bigFont),
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
            });
          },
          icon: gameData[index] == 1
              ? Icons.lens_outlined
              : gameData[index] == 2
                  ? Icons.close_outlined
                  : Icons.question_mark_outlined,
          iconColor: gameData[index] == 0 ? Colors.transparent : Colors.white,
        );
      },
    );
  }

  Future<dynamic> showTieMessage(BuildContext context) {
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
    if ((gameData[0] == 1 && gameData[1] == 1 && gameData[2] == 1) ||
        (gameData[3] == 1 && gameData[4] == 1 && gameData[5] == 1) ||
        (gameData[6] == 1 && gameData[7] == 1 && gameData[8] == 1) ||
        (gameData[1] == 1 && gameData[4] == 1 && gameData[7] == 1) ||
        (gameData[0] == 1 && gameData[3] == 1 && gameData[6] == 1) ||
        (gameData[2] == 1 && gameData[5] == 1 && gameData[8] == 1) ||
        (gameData[0] == 11 && gameData[4] == 1 && gameData[8] == 1) ||
        (gameData[2] == 1 && gameData[4] == 11 && gameData[6] == 1)) {
      showWinner(context, 1);
      isGameEnd = true;
    }
  }

  void checkPlayer2IsWinner() {
    if ((gameData[0] == 2 && gameData[1] == 2 && gameData[2] == 2) ||
        (gameData[3] == 2 && gameData[4] == 2 && gameData[5] == 2) ||
        (gameData[6] == 2 && gameData[7] == 2 && gameData[8] == 2) ||
        (gameData[1] == 2 && gameData[4] == 2 && gameData[7] == 2) ||
        (gameData[0] == 2 && gameData[3] == 2 && gameData[6] == 2) ||
        (gameData[2] == 2 && gameData[5] == 2 && gameData[8] == 2) ||
        (gameData[0] == 2 && gameData[4] == 2 && gameData[8] == 2) ||
        (gameData[2] == 2 && gameData[4] == 2 && gameData[6] == 2)) {
      showWinner(context, 2);
      isGameEnd = true;
    }
  }

 

  void showXorOAccordingToPlayer() {
    if (timeCount % 2 == 1 && widget.isRoomOwner) {
      if (gameData[currentIndex] == 0) {
        gameData[currentIndex] = 1;
        setState(() {
          timeCount++;
        });
        _firestore
            .collection('GameData')
            .doc(widget.roomID)
            .update({'gameData': gameData, 'timeCount': timeCount});
      }
    }
    if (timeCount % 2 == 0 && !widget.isRoomOwner) {
      if (gameData[currentIndex] == 0) {
        gameData[currentIndex] = 2;
        setState(() {
          timeCount++;
        });
        _firestore
            .collection('GameData')
            .doc(widget.roomID)
            .update({'gameData': gameData, 'timeCount': timeCount});
      }
    }
  }

  Future<dynamic> showWinner(BuildContext context, int player) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            'player$player win!!!',
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
