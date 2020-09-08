import 'package:flutter/material.dart';
import 'package:flutter_app/screens/landing.dart';

void main() => runApp(MaxFitApp());

class MaxFitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Max fitness",
      theme: ThemeData(
        primaryColor: Color.fromRGBO(50, 65, 85, 1),
        textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white))
      ),
      home: LandingPage(),
    );
  }
}


