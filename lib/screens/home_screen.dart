///this screen is home screen. User need to select one of modes(single, multiplayer offline, multiplayer online)
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
  int touchedIndex = -1;
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
                    touchedIndex = 0;
                    
                    Timer(const Duration(milliseconds: 600), () {
                      setState(() {
                        touchedIndex = -1;
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
              color: touchedIndex == 1 ? onTapColor : Colors.white,
              onTap: () {
                setState(
                  () {
                    touchedIndex = 1;
                    Timer(const Duration(milliseconds: 600), () {
                      setState(() {
                        touchedIndex = -1;
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
              color: touchedIndex == 2 ? onTapColor : Colors.white,
              onTap: () {
                setState(
                  () {
                    touchedIndex = 2;
                    Timer(const Duration(milliseconds: 600), () {
                      setState(() {
                        touchedIndex = -1;
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

  Future<dynamic> navigateToOfflineTwoPlayerScreen(BuildContext context) {
    return Navigator.push(
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
