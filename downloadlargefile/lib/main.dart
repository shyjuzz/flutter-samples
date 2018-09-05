import 'package:simple_permissions/simple_permissions.dart';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new DownloadApp(),
    );
  }
}
class DownloadApp extends StatefulWidget {
  @override
  _DownloadAppState createState() => new _DownloadAppState();
}

class _DownloadAppState extends State<DownloadApp> {
  final imgUrl = "https://unsplash.com/photos/iEJVyyevw-U/download?force=true";
  bool downloading = false;
  var progressString = "";
  Future<Directory> _externalDocumentsDirectory;

  @override
  void initState() {
    //downloadFile();
    checkPer();
    super.initState();
  }

  void checkPer() async{
    bool checkResult = await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
    if(!checkResult) {
      bool resReq = await SimplePermissions.requestPermission(
          Permission.WriteExternalStorage);
      //print("permission request result is " + resReq.toString());
      if(resReq){
        await downloadFile();
      }
    }
    else{
      await downloadFile();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),
      ),
      body: Center(
        child: downloading
            ? Container(
          height: 120.0,
          width: 200.0,
          child: Card(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Downloading File: $progressString",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        )
            : Text("No Data"),
      ),
    );
  }

  Future<void> downloadFile() async {
    //_externalDocumentsDirectory =  getExternalStorageDirectory();

    var dio = new Dio();
    //var dir = await getApplicationDocumentsDirectory();
    var dir = await getExternalStorageDirectory();
    print(dir.path);

    await dio.download(imgUrl, '${dir.path}/myimage.jpg',
    onProgress: (rec,total){
      print("Rec: $rec , Total: $total");

      setState(() {
        downloading = true;
        progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
      });
    });
    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
  }

  void downloadFlutter() async{

    int fileSize;
    int downloadProgress = 0;

    new HttpClient().get(imgUrl, 80, '/file.img')
        .then((HttpClientRequest request) => request.close())
        .then((HttpClientResponse response) {
      fileSize ??= response.contentLength;
      response.transform(utf8.decoder).listen((contents) {
        downloadProgress += contents.length;
        print(downloadProgress);
        // handle data
      });
    });

  }
}


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  Future<Directory> _tempDirectory;
  Future<Directory> _appDocumentsDirectory;
  Future<Directory> _externalDocumentsDirectory;

  void _requestTempDirectory() {
    setState(() {
      _tempDirectory = getTemporaryDirectory();
    });
  }

  Widget _buildDirectory(
      BuildContext context, AsyncSnapshot<Directory> snapshot) {
    Text text = const Text('');
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        text = new Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        text = new Text('path: ${snapshot.data.path}');
      } else {
        text = const Text('path unavailable');
      }
    }
    return new Padding(padding: const EdgeInsets.all(16.0), child: text);
  }

  void _requestAppDocumentsDirectory() {
    setState(() {
      _appDocumentsDirectory = getApplicationDocumentsDirectory();
    });
  }

  void _requestExternalStorageDirectory() {
    setState(() {
      _externalDocumentsDirectory = getExternalStorageDirectory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('tit'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new RaisedButton(
                    child: const Text('Get Temporary Directory'),
                    onPressed: _requestTempDirectory,
                  ),
                ),
              ],
            ),
            new Expanded(
              child: new FutureBuilder<Directory>(
                  future: _tempDirectory, builder: _buildDirectory),
            ),
            new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new RaisedButton(
                    child: const Text('Get Application Documents Directory'),
                    onPressed: _requestAppDocumentsDirectory,
                  ),
                ),
              ],
            ),
            new Expanded(
              child: new FutureBuilder<Directory>(
                  future: _appDocumentsDirectory, builder: _buildDirectory),
            ),
            new Column(children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new RaisedButton(
                  child: new Text('${Platform.isIOS ?
                  "External directories are unavailable "
                      "on iOS":
                  "Get External Storage Directory" }'),
                  onPressed:
                  Platform.isIOS ? null : _requestExternalStorageDirectory,
                ),
              ),
            ]),
            new Expanded(
              child: new FutureBuilder<Directory>(
                  future: _externalDocumentsDirectory,
                  builder: _buildDirectory),
            ),
          ],
        ),
      ),
    );
  }
}