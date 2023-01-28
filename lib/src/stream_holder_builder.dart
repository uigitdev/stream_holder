import 'package:flutter/material.dart';
import 'package:uigitdev_stream_holder/uigitdev_stream_holder.dart';

enum StreamHolderState { placeholder, error, success }

typedef AsyncStreamHolderBuilder<T> = Widget Function(BuildContext context, StreamHolderState state, T? data, Object? error);

class StreamHolderBuilder<T> extends StatelessWidget {
  final StreamHolder<T> _streamHolder;
  final AsyncStreamHolderBuilder<T> _builder;

  const StreamHolderBuilder({
    Key? key,
    required StreamHolder<T> streamHolder,
    required AsyncStreamHolderBuilder<T> builder,
  })  : _streamHolder = streamHolder,
        _builder = builder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: _streamHolder.stream,
      initialData: _streamHolder.data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _builder(context, StreamHolderState.success, snapshot.data, null);
        } else if (snapshot.hasError) {
          return _builder(context, StreamHolderState.error, null, snapshot.error);
        } else {
          return _builder(context, StreamHolderState.placeholder, null, null);
        }
      },
    );
  }
}
