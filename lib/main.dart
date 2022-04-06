import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}