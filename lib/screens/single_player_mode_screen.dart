import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/reusable_widgets.dart';
import 'package:tic_tac_toe/screens/single_player_easy_screen.dart';
import 'package:tic_tac_toe/screens/single_player_hard_screen.dart';
import 'package:tic_tac_toe/style.dart';

enum mode{none,easy,hard,back}

class SinglePlayerModeScreen extends StatefulWidget {
  const SinglePlayerModeScreen({Key? key}) : super(key: key);

  @override
  State<SinglePlayerModeScreen> createState() => _SinglePlayerModeScreenState();
}

class _SinglePlayerModeScreenState extends State<SinglePlayerModeScreen> {
  final Color onTapColor = const Color(0xff035956);
  // ignore: non_constant_identifier_names
  int TouchedIndex = -1;
  mode selectedMode = mode.none;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Single Player Mode',
              style: bigFont,
            ),
            const SizedBox(height: 50),
            //stupid ai bot
            GameMode(
              modeText: 'Easy',
              color: selectedMode == mode.easy ? onTapColor : Colors.white,
              onTap: () {
                setState(() {
                  selectedMode = mode.easy;
                  resetTouchAnimation();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SinglePlayerEasyScreen(),
                    ),
                  );
                });
              },
            ),
            const SizedBox(height: 30),
            //normal easy ai bot
            GameMode(
              modeText: 'Hard',
              color: selectedMode == mode.hard ? onTapColor : Colors.white,
              onTap: () {
                setState(() {
                  selectedMode = mode.hard;
                  resetTouchAnimation();
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SinglePlayerHardScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
            ButtonBack(
              onTap: () {
                setState(
                  () {
                    selectedMode = mode.back;
                    resetTouchAnimation();
                    Navigator.pop(context);
                  },
                );
              },
              color: selectedMode == mode.back ? onTapColor : Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Timer resetTouchAnimation() {
    return Timer(const Duration(milliseconds: 600), () {
    
        selectedMode = mode.none;
     
    });
  }
}
