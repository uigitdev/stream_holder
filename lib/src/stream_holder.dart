import 'dart:async';

class StreamHolder<T> {
  final _controller = StreamController<T>.broadcast();
  T _data;

  /// Add default [StreamHolder] data, when you create it.
  StreamHolder(this._data) {
    addData(_data);
  }

  /// Add stream value to the stream attribute of StreamBuilder.
  Stream<T> get stream => _controller.stream;

  /// Manage [StreamHolder] with controller.
  StreamController<T> get controller => _controller;

  /// Add data value to the stream attribute of StreamBuilder.
  T get data => _data;

  /// Call it when you want to update the old [StreamHolder] data.
  void addData(T data) {
    _data = data;
    _controller.add(data);
  }
}
