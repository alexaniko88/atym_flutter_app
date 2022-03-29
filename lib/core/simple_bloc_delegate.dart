import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print("onEvent -> $event");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("onTransition -> $transition");
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print("onClose -> $bloc");
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print("onCreate -> $bloc");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print("onError -> $error");
  }
}
