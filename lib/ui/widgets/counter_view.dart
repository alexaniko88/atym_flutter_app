import 'package:atym_flutter_app/constants.dart';
import 'package:atym_flutter_app/cubits/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<CounterCubit, int>(
          builder: (context, count) => Center(
            child: Text(
              '$count',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(
              right: defaultPadding,
              bottom: counterActionsBottomPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'sync',
                  child: const Icon(Icons.sync),
                  onPressed: () => context.read<CounterCubit>().reset(),
                ),
                const SizedBox(height: 4),
                FloatingActionButton(
                  heroTag: 'add',
                  child: const Icon(Icons.add),
                  onPressed: () => context.read<CounterCubit>().increment(),
                ),
                const SizedBox(height: 4),
                FloatingActionButton(
                  heroTag: 'remove',
                  child: const Icon(Icons.remove),
                  onPressed: () => context.read<CounterCubit>().decrement(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
