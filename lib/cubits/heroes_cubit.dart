import 'package:atym_flutter_app/core/cubit_states/cubit_state.dart';
import 'package:atym_flutter_app/core/cubit_states/data_state.dart';
import 'package:atym_flutter_app/core/cubit_states/error_state.dart';
import 'package:atym_flutter_app/core/cubit_states/loading_state.dart';
import 'package:atym_flutter_app/repositories/heroes_repository.dart';
import 'package:atym_flutter_app/view_models/hero_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeroesCubit extends Cubit<CubitState> {
  final HeroesRepository repository;
  List<HeroViewModel> data = [];

  HeroesCubit(this.repository) : super(LoadingState());

  Future getHeroes() async {
    emit(LoadingState());
    final result = await repository.getAllHeroes();
    if (result.isSuccess && result.data != null) {
      data = List.from(
        result.data!.map(
          (heroModel) => HeroViewModel.fromDataModel(heroModel),
        ),
      );
      emit(DataState(data));
    } else {
      emit(ErrorState(result.exception));
    }
  }
}
