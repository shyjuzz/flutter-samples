import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:math' as math;
void main() {
  runApp(new MaterialApp(
    theme: new ThemeData(
      primaryColor: Colors.white,
    ),
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    home: new FloatSpeed(),
  ));
}

class FloatSpeed extends StatefulWidget {
  @override
  createState() {
    return new FloatSpeedState();
  }
}

class FloatSpeedState extends State<FloatSpeed> with TickerProviderStateMixin{
  AnimationController _controller;

  static const List<IconData> icons = const [ Icons.sms, Icons.mail, Icons.phone ];

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    var customFloat = new Column(
      mainAxisSize: MainAxisSize.min,
      children: new List.generate(icons.length, (int index) {
        Widget child = new Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: new ScaleTransition(
            scale: new CurvedAnimation(
              parent: _controller,
              curve: new Interval(
                  0.0,
                  1.0 - index / icons.length / 2.0,
                  curve: Curves.easeOut
              ),
            ),
            child: new FloatingActionButton(
              backgroundColor: backgroundColor,
              mini: true,
              child: new Icon(icons[index], color: foregroundColor),
              onPressed: () {print('hi');},
            ),

          ),
        );
        return child;
      }).toList()..add(
        new FloatingActionButton(
          child: new AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return new Transform(
                transform: new Matrix4.rotationZ(_controller.value * 0.5 * math.PI),
                alignment: FractionalOffset.center,
                child: new Icon(_controller.isDismissed ? Icons.share : Icons.close),
              );
            },
          ),
          onPressed: () {
            if (_controller.isDismissed) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          },
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Sample'),
        centerTitle: true,
      ),
      body: Center(child: Text('Speed Dial'),),
      floatingActionButton: customFloat,
    );
  }
}
