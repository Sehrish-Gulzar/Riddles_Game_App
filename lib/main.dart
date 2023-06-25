import 'package:flutter/material.dart';
import 'package:riddles/Start_Screen.dart';

void main() => runApp(RiddleGame());

class RiddleGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: StartGame());
  }
}
