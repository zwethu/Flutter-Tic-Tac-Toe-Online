import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/reusable_widgets.dart';
import 'package:tic_tac_toe/screens/online_player1_prepare_screen.dart';
import 'package:tic_tac_toe/screens/online_player2_prepare_screen.dart';
import 'package:tic_tac_toe/style.dart';

enum ClickableThings{none,createRoom,joinRoom,back}

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
  ClickableThings clickedThings = ClickableThings.none;
  @override
  void dispose() {
    super.dispose();
  }
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
              color: clickedThings == ClickableThings.createRoom ? onTapColor : Colors.white,
              onTap: () async {
                setState(() {
                  clickedThings = ClickableThings.createRoom;
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
              color: clickedThings == ClickableThings.joinRoom ? onTapColor : Colors.white,
              onTap: () {
                setState(() {
                  clickedThings = ClickableThings.joinRoom;
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
                  clickedThings = ClickableThings.back;
                  resetTouchAnimation();
                  Navigator.pop(context);
                });
              },
              color: clickedThings == ClickableThings.back ? onTapColor : Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Timer resetTouchAnimation() {
    return Timer(const Duration(milliseconds: 600), () {
 
        clickedThings = ClickableThings.none;
  
    });
  }
}
