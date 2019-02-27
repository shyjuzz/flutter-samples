import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as Im;
import 'dart:io';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage(this.firestore);

  final Firestore firestore;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CollectionReference get quotes => widget.firestore.collection('quotesdb');
  File imageFile;
  var uuid = new Uuid();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var postButton = Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: () async {
            if (imageFile == null) {
              _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(content: Text('Please select the image!')));
              return;
            }
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return new Center(
                    child: CircularProgressIndicator(),
                  );
                });
            await new Future.delayed(new Duration(seconds: 1));

            var firebaseURL = await _upload();
            print(firebaseURL);
            var data = <String, dynamic>{
              'url': firebaseURL,
              'created_at': FieldValue.serverTimestamp(),
            };
            await quotes.add(data);
            Navigator.pop(context);
            if (firebaseURL != null) {
              _scaffoldKey.currentState
                  .showSnackBar(new SnackBar(content: Text('Success!')));
            } else {
              _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(content: Text('Something went wrong!')));
            }
          },
          child: Text('Post'),
        ));
    var content = Container(
      padding: new EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                new Card(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2 - 100.0,
                    width: MediaQuery.of(context).size.width,
                    child: imageFile == null
                        ? Center(
                      child: new Text('No image selected.'),
                    )
                        : new Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                new Positioned(
                    bottom: 10.0,
                    right: 10.0,
                    child: new FloatingActionButton(
                      onPressed: getImage,
                      tooltip: 'Pick Image',
                      backgroundColor: Colors.black54,
                      child: new Icon(Icons.add_a_photo),
                    ))
              ],
            ),
            postButton
          ],
        ),
      ),
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Upload - DailyMot'),
      ),
      body: content,
    );
  }

  Future<String> _upload() async {
    try {
      if (imageFile != null) {
        final tempDir = await getTemporaryDirectory();
        final path = tempDir.path;
        var imageName = '${uuid.v1()}.jpg';
        Im.Image image = Im.decodeImage(imageFile.readAsBytesSync());
        // Resize the image to a 200? thumbnail (maintaining the aspect ratio).
        Im.Image smallerImage = Im.copyResize(
            image, 200); // choose the size here, it will maintain aspect ratio

        var compressedImage = new File('$path/$imageName')
          ..writeAsBytesSync(Im.encodeJpg(image, quality: 50));

        //compressedImage.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);
        //save to firebase storage
        StorageReference ref =
        FirebaseStorage.instance.ref().child('userposts').child(imageName);
        StorageUploadTask uploadTask = ref.putFile(compressedImage);
        var downloadUrl =
        await (await uploadTask.onComplete).ref.getDownloadURL();
        var _path = downloadUrl.toString();
        return _path;
      }
    } on Exception {
      print('caught image exception');
      return null;
    }
    return null;
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var len = await image.length();
      print(len);
      if (len / (1024 * 1024) > 2) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: new Text(
                      'The image is too large. The maximum image size allowed is 2 MB'),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: new Text(
                        'OK',
                        style: new TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ]);
            });
      } else {
        setState(() {
          imageFile = image;
        });
      }
    }
  }
}
