import 'package:flutter/material.dart';
import 'dart:math';

const double IMAGE_SIZE = 100.0;

class CircleWithImage extends StatelessWidget {
  final String image;

  CircleWithImage(this.image);

  Widget _centerCircle(double radius, double opacity){
    return new Positioned(
      width: radius,
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape:  BoxShape.circle,
          color: Colors.white.withOpacity(opacity),
        ),
      ),
    );
  }

  Widget _largeCircle(Size size){
    Random rnd = new Random();
    double top = rnd.nextDouble();
    double radius = rnd.nextDouble() * size.height;
    double opacity = rnd.nextDouble() * 0.1;

    return new Positioned(
      top: top,
      width: radius,
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape:  BoxShape.circle,
          color: Colors.white.withOpacity(opacity),
        ),
      ),
    );
  }

  Widget _smallCircle(Size size){
    Random rnd = new Random();
    double top = rnd.nextDouble() * size.height;
    double left = rnd.nextDouble() * size.width;
    double radius = rnd.nextDouble() * 15.0;
    double opacity = rnd.nextDouble() * 0.75;

    return new Positioned(
      top: top,
      left: left,
      width: radius,
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape:  BoxShape.circle,
          color: Colors.white.withOpacity(opacity),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    List<Widget> widgets = [];
    List<Widget> smallCircles = List(10).map((_) => _smallCircle(MediaQuery.of(context).size)).toList();
    List<Widget> largeCircles = List(5).map((_) => _largeCircle(MediaQuery.of(context).size)).toList();
    List<Widget> centerCircles = [
      _centerCircle(width * 1.35, 0.07),
      _centerCircle(width * 1.25, 0.1),
      _centerCircle(width * 1.0, 0.15),
      _centerCircle(width * 0.40, 0.5),
    ];
    widgets.addAll(smallCircles);
    widgets.addAll(largeCircles);
    widgets.addAll(centerCircles);
    /*
    widgets.add(
      SizedBox(
        child: Image(
          image: AssetImage(image),
          fit: BoxFit.fitHeight,
        ),
        height: IMAGE_SIZE,
        width: IMAGE_SIZE,
      ),
    );
    */
    return Stack(
      children: widgets,
      alignment: FractionalOffset.center,
    );
  }
}