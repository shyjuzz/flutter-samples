import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gkcash/intro/intro_screen.dart';
import 'package:gkcash/onboard/firstscreen.dart';
import 'package:gkcash/pages/homepage_slider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(new GKCashApp());
}
class GKCashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GKCash',
      theme: ThemeData(
          primarySwatch: Colors.orange
      ),
      home: IntroScreen(),
    );
  }
}
