import 'package:flutter/material.dart';

const TextStyle bigFont = TextStyle(
  fontSize: 36,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const TextStyle normalFont = TextStyle(
  fontSize: 24,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const TextStyle smallFont = TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

// builder: (BuildContext context, AsyncSnapshot snapshot) {
//                     if (snapshot.hasData) {
//                       final count = snapshot.data;
//                       timeCount = count['timeCount'];
//                       return playerScreen();
//                     } else if (snapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return const CircularProgressIndicator();
//                     } else {
//                       return const Center(
//                         child: Text('Error Occured'),
//                       );
//                     }
//                   },

// builder: (BuildContext context, AsyncSnapshot snapshot) {
//                     if (snapshot.hasData) {
//                       final data = snapshot.data;
//                       gameData = data['gameData'];
//                       timeCount = data['timeCount'];
//                       WidgetsBinding.instance?.addPostFrameCallback((_) {
//                         checkPlayer1IsWinner();
//                         checkPlayer2IsWinner();
//                         if (timeCount == 10) {
//                           showTieMessage(context);
//                         }
//                       });

//                       return touchscreenGridView();
//                     } else if (snapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return const CircularProgressIndicator();
//                     } else {
//                       return const Center(
//                         child: Text('Error Occured'),
//                       );
//                     }
//                   },



