import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/reusable_widgets.dart';
import 'package:tic_tac_toe/screens/single_player_easy_screen.dart';
import 'package:tic_tac_toe/style.dart';

class SinglePlayerModeScreen extends StatefulWidget {
  const SinglePlayerModeScreen({Key? key}) : super(key: key);

  @override
  State<SinglePlayerModeScreen> createState() => _SinglePlayerModeScreenState();
}

class _SinglePlayerModeScreenState extends State<SinglePlayerModeScreen> {
  final Color onTapColor = const Color(0xff035956);
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
              'Single Player Mode',
              style: bigFont,
            ),
            const SizedBox(height: 50),
            //stupid ai bot
            GameMode(
                modeText: 'Easy',
                color: TouchedIndex == 0 ? onTapColor : Colors.white,
                onTap: () {
                  setState(() {
                    TouchedIndex = 0;
                    resetTouchAnimation();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SinglePlayerEasyScreen(),
                      ),
                    );
                  });
                }),
            const SizedBox(height: 30),
            //normal easy ai bot
            GameMode(
                modeText: 'Normal',
                color: TouchedIndex == 1 ? onTapColor : Colors.white,
                onTap: () {
                  setState(() {
                    TouchedIndex = 1;
                    resetTouchAnimation();
                  });
                  // Navigator.of(context).pop(const SinglePlayerModeScreen());
                }),
            const SizedBox(height: 30),
            //hard ai god mode
            GameMode(
                modeText: 'Hard',
                color: TouchedIndex == 2 ? onTapColor : Colors.white,
                onTap: () {
                  setState(() {
                    TouchedIndex = 2;
                    resetTouchAnimation();
                  });
                  // Navigator.of(context).pop(const SinglePlayerModeScreen());
                }),
            const SizedBox(height: 30),
            ButtonBack(
              iconName: const Icon(Icons.arrow_back_outlined),
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
