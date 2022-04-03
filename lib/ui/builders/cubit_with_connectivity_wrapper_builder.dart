import 'package:atym_flutter_app/constants.dart';
import 'package:atym_flutter_app/core/cubit_states/cubit_state.dart';
import 'package:atym_flutter_app/core/cubit_states/data_state.dart';
import 'package:atym_flutter_app/core/cubit_states/error_state.dart';
import 'package:atym_flutter_app/core/cubit_states/loading_state.dart';
import 'package:atym_flutter_app/ui/builders/connectivity_wrapper_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ConnectivityListenerCallback<B> = Function(
  BuildContext context,
  B bloc,
  bool isOnline,
);

typedef DataStateBuilderCallback<B, D> = Function(
  BuildContext context,
  B bloc,
  D data,
  bool isOnline,
);

typedef DefaultStateBuilderCallback<B, S> = Function(
  BuildContext context,
  B bloc,
  S state,
  bool isOnline,
);

class CubitWithConnectivityWrapperBuilder<B extends Cubit<CubitState>, D>
    extends StatelessWidget {
  final B bloc;
  final DataStateBuilderCallback<B, D> builder;
  final BlocWidgetListener<CubitState> listener;
  final ConnectivityListenerCallback<B>? connectivityListenerCallback;
  final BlocBuilderCondition<CubitState>? buildWhen;
  final BlocListenerCondition<CubitState>? listenWhen;
  final DefaultStateBuilderCallback<B, CubitState>? defaultStateBuilder;

  const CubitWithConnectivityWrapperBuilder({
    Key? key,
    required this.bloc,
    required this.listener,
    required this.builder,
    this.connectivityListenerCallback,
    this.buildWhen,
    this.listenWhen,
    this.defaultStateBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConnectivityWrapperBuilder(
      listener: (context, isOnline) => connectivityListenerCallback?.call(
        context,
        bloc,
        isOnline,
      ),
      builder: (context, isOnline) {
        return BlocConsumer<B, CubitState>(
          bloc: bloc,
          buildWhen: buildWhen ??
              (prev, current) => (current is LoadingState ||
                  current is ErrorState ||
                  current is DataState),
          listenWhen: listenWhen,
          listener: listener,
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: errorStateIconSize),
                    Text(
                      state.exception.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else if (state is DataState) {
              return builder.call(context, bloc, state.data, isOnline);
            } else {
              return defaultStateBuilder?.call(context, bloc, state, isOnline);
            }
          },
        );
      },
    );
  }
}
