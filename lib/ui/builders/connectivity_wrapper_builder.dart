import 'package:atym_flutter_app/cubits/connectivity_wrapper_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef BuilderWrapperCallback = Widget Function(
  BuildContext context,
  bool isOnline,
);

typedef ConnectivityListenerCallback = void Function(
  BuildContext context,
  bool isOnline,
);

class ConnectivityWrapperBuilder extends StatelessWidget {
  final BlocWidgetBuilder builder;
  final BlocWidgetListener listener;

  const ConnectivityWrapperBuilder({
    Key? key,
    required this.builder,
    required this.listener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityWrapperCubit, bool>(
      bloc: context.watch<ConnectivityWrapperCubit>(),
      builder: builder,
      listener: listener,
    );
  }
}
