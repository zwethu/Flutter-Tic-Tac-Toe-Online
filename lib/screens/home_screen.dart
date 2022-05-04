import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/reusable_widgets.dart';
import 'package:tic_tac_toe/screens/offline_two_player_screen.dart';
import 'package:tic_tac_toe/screens/room_create_screen.dart';
import 'package:tic_tac_toe/screens/single_player_mode_screen.dart';
import 'package:tic_tac_toe/style.dart';

enum mode { singlePlayer, twoPlayerOffline, twoPlayerOnline, none}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color onTapColor = const Color(0xff035956);
  mode touchedMode = mode.none;

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
              color: touchedMode == mode.singlePlayer? onTapColor : Colors.white,
              onTap: () {
                setState(
                  () {
                    touchedMode = mode.singlePlayer;
                    
                    Timer(const Duration(milliseconds: 600), () {
                      setState(() {
                        touchedMode = mode.none;
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
              color: touchedMode == mode.twoPlayerOffline ? onTapColor : Colors.white,
              onTap: () {
                setState(
                  () {
                    touchedMode = mode.twoPlayerOffline;
                    Timer(const Duration(milliseconds: 600), () {
                      setState(() {
                        touchedMode = mode.none;
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
              color: touchedMode == mode.twoPlayerOnline ? onTapColor : Colors.white,
              onTap: () {
                setState(
                  () {
                    touchedMode = mode.twoPlayerOnline;
                    Timer(const Duration(milliseconds: 600), () {
                      setState(() {
                        touchedMode = mode.none;
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
