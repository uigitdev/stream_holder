import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uigitdev_stream_holder/src/stream_holder.dart';

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
            ],
          ),
        ),
      ),
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
        return StreamBuilder<int>(
          stream: provider.countStreamHolder.stream,
          initialData: provider.countStreamHolder.data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.toString());
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Text('Loading');
            }
          },
        );
      },
    );
  }
}

class MainProvider extends ChangeNotifier {
  final countStreamHolder = StreamHolder<int>(0);
}
