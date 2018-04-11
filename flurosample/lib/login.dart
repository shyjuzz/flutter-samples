import 'package:flutter/material.dart';
import 'package:flurosample/app_route.dart';
class Login extends StatefulWidget{
  @override
  createState() => new LoginState();
}

class LoginState extends State<Login>{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fluro sample',


      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Login"),
        ),
        body: new Builder(builder: (BuildContext context) {
          return new Center(child:
          new Container(
              height: 30.0,
              color: Colors.blue,
              child:new FlatButton(
                child: const Text('Go to Home'),
                onPressed: () {
                  var bodyJson = '{"buyerId":1281,"orgId":3041}';
                  router.navigateTo(context, '/login/$bodyJson');
                  // Perform some action
                },
              )),
          );
        }),

      /**/

    ));
  }
}