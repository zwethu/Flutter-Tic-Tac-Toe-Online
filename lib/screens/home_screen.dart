import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/reusable_widgets.dart';
import 'package:tic_tac_toe/screens/offline_two_player_screen.dart';
import 'package:tic_tac_toe/screens/room_create_screen.dart';
import 'package:tic_tac_toe/screens/single_player_mode_screen.dart';
import 'package:tic_tac_toe/style.dart';

enum Mode { singlePlayer, twoPlayerOffline, twoPlayerOnline, none}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color onTapColor = const Color(0xff035956);
  Mode touchedMode = Mode.none;

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
            GameMode(
              modeText: 'Single Player',
              color: touchedMode == Mode.singlePlayer? onTapColor : Colors.white,
              onTap: () {
                setState(
                  () {
                    touchedMode = Mode.singlePlayer;
                    
                    Timer(const Duration(milliseconds: 600), () {
                      setState(() {
                        touchedMode = Mode.none;
                        navigateToSinglePlayerModeScreen(context);
                      });
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 30),
            GameMode(
              modeText: 'Two Player Offline',
              color: touchedMode == Mode.twoPlayerOffline ? onTapColor : Colors.white,
              onTap: () {
                setState(
                  () {
                    touchedMode = Mode.twoPlayerOffline;
                    Timer(const Duration(milliseconds: 600), () {
                      setState(() {
                        touchedMode = Mode.none;
                        navigateToOfflineTwoPlayerScreen(context);
                      });
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 30),
            GameMode(
              modeText: 'Two Player Online',
              color: touchedMode == Mode.twoPlayerOnline ? onTapColor : Colors.white,
              onTap: () {
                setState(
                  () {
                    touchedMode = Mode.twoPlayerOnline;
                    Timer(const Duration(milliseconds: 600), () {
                      setState(() {
                        touchedMode = Mode.none;
                        navigateToRoomCreateScreen(context);
                      });
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void navigateToRoomCreateScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RoomCreateScreen(),
      ),
    );
  }

  void navigateToOfflineTwoPlayerScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OfflineTwoPlayerScreen(),
      ),
    );
  }

  void navigateToSinglePlayerModeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SinglePlayerModeScreen(),
      ),
    );
  }
}
