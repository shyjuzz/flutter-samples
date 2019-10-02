import 'dart:async';
class CounterBloc{

  StreamController<int> _streamController = new StreamController();

  Sink<int> get _inAdd => _streamController.sink;
  Stream<int> get outCounter => _streamController.stream;

  void dispose() {
    _streamController.close();
  }
}