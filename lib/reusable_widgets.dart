import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/style.dart';

class GameMode extends StatefulWidget {
  final String modeText;
  final Function onTap;
  final Color color;
  const GameMode(
      {Key? key,
      required this.modeText,
      required this.onTap,
      required this.color})
      : super(key: key);

  @override
  State<GameMode> createState() => _GameModeState();
}

class _GameModeState extends State<GameMode> {
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
          child: TextButton(
            onPressed: () => widget.onTap(),
            child: Text(
              widget.modeText,
              style: normalFont.copyWith(color: widget.color),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonBack extends StatelessWidget {
  final Icon iconName;
  final Function onTap;
  final Color color;
  const ButtonBack(
      {Key? key,
      required this.iconName,
      required this.onTap,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [15, 10],
        color: color,
        strokeWidth: 2,
        child: SizedBox(
          width: 60,
          height: 60,
          child: TextButton(
            onPressed: () => onTap(),
            child: Icon(
              Icons.arrow_back_outlined,
              color: color,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
