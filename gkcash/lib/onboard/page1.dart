import 'package:flutter/material.dart';
import 'package:gkcash/onboard/circles_with_image.dart';
import 'package:gkcash/utils/assets.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: double.infinity,
      width: double.infinity,
      decoration: new BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.green[400],
                Colors.blue[600],
                Colors.blue[900],
              ],
              begin: Alignment(0.5, -1.0),
              end: Alignment(0.5, 1.0)
          )
      ),
      child: Stack(
        children: <Widget>[
          new Positioned(
            child: new CircleWithImage(Assets.pose1),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          new Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.attach_money,size: IMAGE_SIZE),
//                SizedBox(
//                  child: Image(
//                    image: AssetImage(Assets.pose1),
//                    fit: BoxFit.fitHeight,
//                  ),
//                  height: IMAGE_SIZE,
//                  width: IMAGE_SIZE,
//                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Workout at home, outside or in the studio',
                    style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text('Workout anywhere without any equipment!',
                  style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        ],
        alignment: FractionalOffset.center,
      ),
    );
  }
}