import 'package:flutter/cupertino.dart';
import 'package:mvvm_structure/ui/counter_page/counter_page.dart';
import 'package:mvvm_structure/ui/home_page/home_view_model.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Widget render() => Provider<HomeViewModel>(
        create: (context) => HomeViewModel(context: context),
        child: const HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    final HomeViewModel model = context.read<HomeViewModel>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: const Text('MVVM architecture'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.settings),
          onPressed: () => model.onSettingButtonPressed(),
        ),
      ),
      child: CounterPage.render(),
    );
  }
}
