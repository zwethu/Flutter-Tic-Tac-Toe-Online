import 'dart:async';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/reusable_widgets.dart';
import 'package:tic_tac_toe/screens/online_multiplayer_screen.dart';
import 'package:tic_tac_toe/style.dart';

class OnlinePlayer2PrepareScreen extends StatefulWidget {
  final bool isRoomOwner;
  // ignore: use_key_in_widget_constructors
  const OnlinePlayer2PrepareScreen({required this.isRoomOwner});

  @override
  State<OnlinePlayer2PrepareScreen> createState() =>
      _OnlinePlayer2PrepareScreenState();
}

class _OnlinePlayer2PrepareScreenState
    extends State<OnlinePlayer2PrepareScreen> {
  final Color onTapColor = const Color(0xff035956);
  final TextEditingController controller = TextEditingController();
  String id = '';
  List<int> gameData = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  String roomId = '';
  // ignore: non_constant_identifier_names
  int TouchedIndex = -1;

  @override
  void initState() {
    controller.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Enter Room ID',
                style: bigFont,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  controller: controller,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    ForwardButton(
                      onTap: () {
                        TouchedIndex = 4;
                        resetTouchAnimation();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OnlineMultiplayerScreen(
                              isRoomOwner: widget.isRoomOwner,
                              roomID: controller.text,
                            ),
                          ),
                        );
                      },
                      color: TouchedIndex == 4 ? onTapColor : Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
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

class IDCopyboard extends StatefulWidget {
  final String id;
  final Function onTap;
  final Color color;
  final IconData icon;
  const IDCopyboard(
      {Key? key,
      required this.id,
      required this.onTap,
      required this.color,
      required this.icon})
      : super(key: key);

  @override
  State<IDCopyboard> createState() => _IDCopyboardState();
}

class _IDCopyboardState extends State<IDCopyboard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [20, 10],
        color: widget.color,
        strokeWidth: 2,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 20),
              Text(
                widget.id,
                style: smallFont,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(widget.icon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
