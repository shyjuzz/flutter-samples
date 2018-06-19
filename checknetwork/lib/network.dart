
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';

class NetworkConnectivity {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = new Connectivity();

  Future<bool> checkConnectivity() async {
    try {
      _connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on Exception catch (e) {
      print(e.toString());
      print(e.toString());
      _connectionStatus = 'ConnectivityResult.none';
    }
    print(_connectionStatus);
    return _connectionStatus != 'ConnectivityResult.none';
  }
}

Future<bool> checkNetwork() async {
  var connectivity = new NetworkConnectivity();
  bool result = await connectivity.checkConnectivity();
  if (!result) {
    print('No Network');
    /*scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('Check connectivity')));*/
  }
  return result;
}