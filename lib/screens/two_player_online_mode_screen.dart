import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/reusable_widgets.dart';
import 'package:tic_tac_toe/style.dart';

class TwoPlayerOnlineModeScreen extends StatefulWidget {
  const TwoPlayerOnlineModeScreen({ Key? key }) : super(key: key);

  @override
  State<TwoPlayerOnlineModeScreen> createState() => _TwoPlayerOnlineModeScreenState();
}

class _TwoPlayerOnlineModeScreenState extends State<TwoPlayerOnlineModeScreen> {
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
              'Online Mode',
              style: bigFont,
            ),
            const SizedBox(height: 50),
            //online mode using internet connection
            GameMode(
                modeText: 'Data Connection',
                color: TouchedIndex == 0 ? onTapColor : Colors.white,
                onTap: () {
                  setState(() {
                    TouchedIndex = 0;
                    resetTouchAnimation();
                  });
                  // Navigator.of(context).pop(const SinglePlayerModeScreen());
                }),
            const SizedBox(height: 30),
            //use hotspot connnection to play together
            GameMode(
                modeText: 'Hotspot',
                color: TouchedIndex == 1 ? onTapColor : Colors.white,
                onTap: () {
                  setState(() {
                    TouchedIndex = 1;
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