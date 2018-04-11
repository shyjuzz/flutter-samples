import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  final String _result;
  Home(this._result);
    @override
  createState() => new HomeState();
}

class HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Home"),
        ),
        body:new Center(child:  new Text(widget._result)),
      )
    );
  }
}