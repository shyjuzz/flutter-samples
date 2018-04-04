import 'package:flutter/material.dart';
import 'package:pickimage/dialog.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
void main() => runApp(new MyApp());

BuildContext _context;
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Image Picker',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Image Picker Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    _context=context;
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Select Image',
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: setImage,
        tooltip: 'Select Image',
        child: new Icon(Icons.camera_rear),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  setImage() {
    Navigator.push(
      context,
      new HeroDialogRoute(
        builder: (BuildContext context) {
          return new Center(
            child: new AlertDialog(
              content: new Text("Choose from"),
              actions: <Widget>[
                new FlatButton(
                    child: const Text('Camera'),
                    onPressed: () {
                      Navigator.of(_context).pop(false);
                      getImage(ImageSource.camera);
                    }),
                new FlatButton(
                    child: const Text('Gallary'),
                    onPressed: () async {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    })
              ],
            ),
          );
        },
      ),
    );
  }
  getImage(ImageSource source) async {
    var _fileName = await ImagePicker.pickImage(source: source);
    setState(() {
      var imageFile = _fileName;
      print(_fileName);
    });
  }
}
