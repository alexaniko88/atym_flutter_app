import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  late int currentIndex;

  CounterCubit({int initialIndex = 0})
      : this.currentIndex = initialIndex,
        super(initialIndex);

  void reset() {
    currentIndex = 0;
    emit(currentIndex);
  }

  void increment() {
    currentIndex++;
    emit(currentIndex);
  }

  void decrement() {
    currentIndex--;
    emit(currentIndex);
  }
}
