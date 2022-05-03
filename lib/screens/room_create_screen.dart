import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/reusable_widgets.dart';
import 'package:tic_tac_toe/screens/online_player1_prepare_screen.dart';
import 'package:tic_tac_toe/screens/online_player2_prepare_screen.dart';
import 'package:tic_tac_toe/style.dart';

class RoomCreateScreen extends StatefulWidget {
  const RoomCreateScreen({Key? key}) : super(key: key);

  @override
  State<RoomCreateScreen> createState() => _RoomCreateScreenState();
}

class _RoomCreateScreenState extends State<RoomCreateScreen> {
  final Color onTapColor = const Color(0xff035956);
  final _firestore = FirebaseFirestore.instance;
  List<int> gameData = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  String roomId = '';
  // ignore: non_constant_identifier_names
  int TouchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Online Mode',
              style: bigFont,
            ),
            const SizedBox(height: 50),
            GameMode(
              modeText: 'Create Room',
              color: TouchedIndex == 0 ? onTapColor : Colors.white,
              onTap: () async {
                setState(() {
                  TouchedIndex = 0;
                  resetTouchAnimation();
                  roomId = _firestore.collection('GameData').doc().id;
                });
                await _firestore
                    .collection('GameData')
                    .doc(roomId)
                    .set({'gameData': gameData, 'timeCount': 1});
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnlinePlayer1PrepareScreen(
                      roomID: roomId.toString(),
                      isRoomOwner: true,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            //use hotspot connnection to play together
            GameMode(
              modeText: 'Join Room',
              color: TouchedIndex == 1 ? onTapColor : Colors.white,
              onTap: () {
                setState(() {
                  TouchedIndex = 1;
                  resetTouchAnimation();
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const OnlinePlayer2PrepareScreen(isRoomOwner: false),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            ButtonBack(
              onTap: () {
                setState(() {
                  TouchedIndex = 3;
                  resetTouchAnimation();
                  Navigator.pop(context);
                });
              },
              color: TouchedIndex == 3 ? onTapColor : Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Timer resetTouchAnimation() {
    return Timer(const Duration(milliseconds: 300), () {
      setState(() {
        TouchedIndex = -1;
      });
    });
  }
}
