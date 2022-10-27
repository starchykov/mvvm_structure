import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_structure/ui/counter_page/counter_state.dart';
import 'package:mvvm_structure/ui/counter_page/counter_view_model.dart';

import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  static Widget render() {
    return ChangeNotifierProvider<CounterViewModel>(
      create: (context) => CounterViewModel(),
      child: const CounterPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _CountTitle(),
            _CountIncrementButton(),
            _CountDecrementButton(),
          ],
        ),
      ),
    );
  }
}

class _CountTitle extends StatelessWidget {
  const _CountTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CountViewModelState state = context.select((CounterViewModel counterViewModel) => counterViewModel.state);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(state.count),
      ],
    );
  }
}

class _CountIncrementButton extends StatelessWidget {
  const _CountIncrementButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterViewModel viewModel = context.read<CounterViewModel>();

    return ElevatedButton(
      onPressed: viewModel.onIncrementButtonPressed,
      child: const Icon(Icons.add),
    );
  }
}

class _CountDecrementButton extends StatelessWidget {
  const _CountDecrementButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterViewModel viewModel = context.read<CounterViewModel>();

    return ElevatedButton(
      onPressed: viewModel.onDecrementButtonPressed,
      child: const Icon(Icons.remove),
    );
  }
}
