import 'package:flutter/material.dart';
import 'package:flurosample/app_route.dart';
import 'package:flurosample/login.dart';
import 'package:flurosample/home.dart';
import 'package:fluro/fluro.dart';

void main() {
  router.define('home/:data', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return new Home(params['data'][0]);
      }));
  runApp(new Login());
}