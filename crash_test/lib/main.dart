import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

final images = [
  'https://firebasestorage.googleapis.com/v0/b/eventurboapp.appspot.com/o/userposts%2F2019-09-14T19%3A42%3A13.717163.jpg?alt=media&token=733bf554-168b-4ef3-ac91-b7e4911a5531',
  'https://firebasestorage.googleapis.com/v0/b/eventurboapp.appspot.com/o/userposts%2F2019-08-26T15%3A11%3A41.359199.jpg?alt=media&token=c3d7876a-28c4-4800-aa85-39c980b5dc5',
  'https://firebasestorage.googleapis.com/v0/b/eventurboapp.appspot.com/o/userposts%2F2019-08-26T15%3A03%3A12.813399.jpg?alt=media&token=e0ba4903-0282-43f2-94bf-1f841a7c7d33',
  'https://firebasestorage.googleapis.com/v0/b/eventurboapp.appspot.com/o/userposts%2F2019-08-22T16%3A00%3A28.429855.jpg?alt=media&token=915b9ea8-8370-4ff0-aaa6-89c23c28b89b'
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    //var list = new List<int>.generate(60, (i) => i + 1);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text('$index'),
                        Center(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => CircularProgressIndicator(),
                            imageUrl: images[index],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
