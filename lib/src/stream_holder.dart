import 'dart:async';

class StreamHolder<T> {
  final _controller = StreamController<T>.broadcast();
  T _data;

  StreamHolder(this._data) {
    addData(_data);
  }

  Stream<T> get stream => _controller.stream;

  StreamController<T> get controller => _controller;

  T get data => _data;

  void addData(T data) {
    _data = data;
    _controller.add(data);
  }
}