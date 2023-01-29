import 'package:flutter/material.dart';
import 'package:uigitdev_stream_holder/uigitdev_stream_holder.dart';

/// There are 3 types of States. [StreamHolderState.none], [StreamHolderState.hasError], [StreamHolderState.hasData]
/// [StreamHolderState.none] will be activated when [StreamHolder] generic type is nullable <T?> and the current data is null.
enum StreamHolderState { none, hasError, hasData }

/// Custom builder [Widget], [Function] which will give the [context], [sate], [data] and [error].
typedef AsyncStreamHolderBuilder<T> = Widget Function(
    BuildContext context, StreamHolderState state, T? data, Object? error);

/// Input type is a [StreamHolder] and [builder] these parameters are [required].
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

  /// Known [StreamBuilder] implementation which will return with [AsyncStreamHolderBuilder] type.
  /// Which is a [Widget], [Function]
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: _streamHolder.stream,
      initialData: _streamHolder.data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _builder(
              context, StreamHolderState.hasData, snapshot.data, null);
        } else if (snapshot.hasError) {
          return _builder(
              context, StreamHolderState.hasError, null, snapshot.error);
        } else {
          return _builder(context, StreamHolderState.none, null, null);
        }
      },
    );
  }
}
