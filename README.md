Stream and data holder class, which helps to ensure reusability
and reduce the number of lines of code.

## Usage

```dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uigitdev_stream_holder/src/stream_holder.dart';
import 'package:uigitdev_stream_holder/src/stream_holder_builder.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _countDataBuilder(),
              _countButton(),
              _errorButton(),
              _emptyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyButton() {
    return Consumer<MainProvider>(
      builder: (context, provider, _) {
        return TextButton(
          onPressed: () => provider.countStreamHolder.addData(null),
          child: Text('Empty'),
        );
      },
    );
  }

  Widget _errorButton() {
    return Consumer<MainProvider>(
      builder: (context, provider, _) {
        return TextButton(
          onPressed: () => provider.countStreamHolder.addError(ErrorHint('some-error')),
          child: Text('Add Error'),
        );
      },
    );
  }

  Widget _countButton() {
    return Consumer<MainProvider>(
      builder: (context, provider, _) {
        return TextButton(
          onPressed: () => provider.countStreamHolder.addData(Random().nextInt(500)),
          child: Text('+'),
        );
      },
    );
  }

  Widget _countDataBuilder() {
    return Consumer<MainProvider>(
      builder: (context, provider, _) {
        return StreamHolderBuilder<int?>(
          streamHolder: provider.countStreamHolder,
          builder: (context, state, data, error) {
            switch (state) {
              case StreamHolderState.none:
                return const CircularProgressIndicator();
              case StreamHolderState.hasData:
                return Text('success: $data');
              case StreamHolderState.hasError:
                return Text('error: ${error.toString()}');
            }
          },
        );
      },
    );
  }
}

class MainProvider extends ChangeNotifier {
  final countStreamHolder = StreamHolder<int?>(null);
}

```