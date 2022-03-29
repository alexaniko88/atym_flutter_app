import 'package:atym_flutter_app/core/simple_bloc_delegate.dart';
import 'package:atym_flutter_app/ui/pages/counter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Page chooser')),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    child: Text('Go to counter page'),
                    onPressed: () => Navigator.push(
                      context,
                      CounterPage.route(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
