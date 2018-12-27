import 'package:simple_permissions/simple_permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Email Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('samples.flutter.io/email');
  List<dynamic> emailList = <dynamic>[];
  Future<void> _getEmails() async {
    final result = await SimplePermissions.checkPermission(Permission.ReadContacts);
    if(!result){
      var status = await SimplePermissions.requestPermission(
          Permission.ReadContacts);
      if (status != PermissionStatus.authorized) {
        print('Not Authorized');
        return;
      }
    }
    try {
      var list   = await platform.invokeMethod('getEmailList');
      if(list != null && mounted){
        setState(() {
          emailList=list;
        });
      }
    } on PlatformException catch (e) {
      print(e.message);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text('Get Emails'),
              onPressed: _getEmails,
            ),
            Container(
              height: 200.0,
              child: ListView.builder(
                padding: new EdgeInsets.all(10.0),
                itemCount: emailList.length,
                itemBuilder: (context, int) {
                  return Column(
                    children: <Widget>[
                      Text(emailList[int]),
                      Divider()
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
