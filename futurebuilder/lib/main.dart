import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
        future:  _getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return new Text('Press button to start');
        case ConnectionState.waiting:
          return new Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: new CircularProgressIndicator()
          );// new Text('Awaiting result...');
        default:
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          else
            return createListView(context,snapshot);
      }
    });
    return new Scaffold(

      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: futureBuilder,
    );
  }

  Future<List<String>> _getData() async {

    var values = new List<String>();
    values.add("Horse");
    values.add("Man");

    await new Future.delayed(new Duration(seconds: 5));
    return values;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<String> values=snapshot.data;
    return new ListView.builder(
        itemCount: values.length,
        itemBuilder:(BuildContext context,int index){
          return new Column(
            children: <Widget>[
              new ListTile(
                title: new Text(values[index]),
              ),
              new Divider(height: 2.0),
            ],
          );
        }
    );
  }
}
