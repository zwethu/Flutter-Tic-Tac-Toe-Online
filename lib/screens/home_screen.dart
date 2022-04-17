///this screen is home screen. User need to select one of modes(single, multiplayer offline, multiplayer online)
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/reusable_widgets.dart';
import 'package:tic_tac_toe/screens/offline_two_player_screen.dart';
import 'package:tic_tac_toe/screens/single_player_mode_screen.dart';
import 'package:tic_tac_toe/screens/two_player_online_mode_screen.dart';
import 'package:tic_tac_toe/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              'Tic-Tac-Toe',
              style: bigFont,
            ),
            const SizedBox(height: 50),
            //single player mode with AI
            GameMode(
                modeText: 'Single Player',
                color: TouchedIndex == 0 ? onTapColor : Colors.white,
                onTap: () {
                  setState(() {
                    TouchedIndex = 0;
                    resetTouchAnimation();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SinglePlayerModeScreen()),
                    );
                  });
                }),
            const SizedBox(height: 30),
            //Multiplayer offline mode. Tow players can play together with a phone
            GameMode(
                modeText: 'Two Player Offline',
                color: TouchedIndex == 1 ? onTapColor : Colors.white,
                onTap: () {
                  setState(() {
                    TouchedIndex = 1;
                    resetTouchAnimation();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        settings: const RouteSettings(name: '/OfflineTwoPlayerScreen'),
                          builder: (context) => const OfflineTwoPlayerScreen()),
                    );
                  });
                }),
            const SizedBox(height: 30),
            //Multiplayer online mode.
            // Two players can play together using internet connection.
            //U need a server code to play with other.
            GameMode(
                modeText: 'Two Player Online',
                color: TouchedIndex == 2 ? onTapColor : Colors.white,
                onTap: () {
                  setState(() {
                    TouchedIndex = 2;
                    resetTouchAnimation();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TwoPlayerOnlineModeScreen()),
                    );
                  });
                }),
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
