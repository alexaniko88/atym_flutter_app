import 'package:atym_flutter_app/core/simple_bloc_delegate.dart';
import 'package:atym_flutter_app/cubits/connectivity_wrapper_cubit.dart';
import 'package:atym_flutter_app/provider_setup.dart';
import 'package:atym_flutter_app/ui/pages/counter_page.dart';
import 'package:atym_flutter_app/ui/pages/heroes_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(
        MultiProvider(
          providers: providers
            ..add(
              BlocProvider(
                create: (context) => ConnectivityWrapperCubit(),
              ),
            ),
          child: const MyApp(),
        ),
      );
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
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  ElevatedButton(
                    child: Text('Go to counter page'),
                    onPressed: () => Navigator.push(
                      context,
                      CounterPage.route(),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Go to heroes page'),
                    onPressed: () => Navigator.push(
                      context,
                      HeroesPage.route(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
