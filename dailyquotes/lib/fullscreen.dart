import 'dart:io' as Io;
import 'package:image/image.dart' as IM;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:flutter/material.dart';

class FullScreenImagePage extends StatelessWidget {
  String imgPath;

  FullScreenImagePage(this.imgPath);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final LinearGradient backgroundGradient = new LinearGradient(
      colors: [new Color(0x10000000), new Color(0x30000000)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: new SizedBox.expand(
        child: new Container(
          decoration: new BoxDecoration(gradient: backgroundGradient),
          child: new Stack(
            children: <Widget>[
              new Align(
                alignment: Alignment.center,
                child: new Hero(
                  tag: imgPath,
                  child: new Image.network(imgPath),
                ),
              ),
              Positioned(
                  bottom: 100.0,
                  right: 20.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: new IconButton(
                      icon: new Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  )),
              new Positioned(
                bottom: 150.0,
                right: 20.0,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: new Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return new Center(
                                child: CircularProgressIndicator());
                          });
                      var res = await downloadImage(imgPath);
                      Navigator.pop(context);
//                      _scaffoldKey.currentState.showSnackBar(SnackBar(
//                          content: Text(res ? 'Saved to gallery!' : 'Error')));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//      floatingActionButton: FloatingActionButton.extended(
//          onPressed: () async {
//            showDialog(
//                context: context,
//                barrierDismissible: false,
//                builder: (BuildContext context) {
//                  return new Center(child: CircularProgressIndicator());
//                });
//
//          },
//          icon: new Icon(Icons.save),
//          label: Text('Save')),
    );
  }

  Future<bool> downloadImage(String url) async {
    await new Future.delayed(new Duration(seconds: 1));
    bool checkResult = await SimplePermissions.checkPermission(
        Permission.WriteExternalStorage);
    if (!checkResult) {
      var status = await SimplePermissions.requestPermission(
          Permission.WriteExternalStorage);
      if (status == PermissionStatus.authorized) {
        var res = await saveImage(url);
        return res != null;
      }
    } else {
      var res = await saveImage(url);
      return res != null;
    }
    return false;
  }

  Future<Io.File> saveImage(String url) async {
    try {
      final file = await getImageFromNetwork(url);
      var dir = await getExternalStorageDirectory();
      var testdir = await new Io.Directory('${dir.path}/DailyMot')
          .create(recursive: true);
      IM.Image image = IM.decodeImage(file.readAsBytesSync());
      return new Io.File(
          '${testdir.path}/${DateTime.now().toUtc().toIso8601String()}.png')
        ..writeAsBytesSync(IM.encodePng(image));
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Io.File> getImageFromNetwork(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);
//    var cacheManager = await CacheManager.getInstance();
//    Io.File file = await cacheManager.getFile(url);
    return file;
  }
}
