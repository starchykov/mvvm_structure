import 'package:flutter/cupertino.dart';
import 'package:mvvm_structure/ui/setting_page/setting_page_state.dart';
import 'package:mvvm_structure/ui/setting_page/setting_page_view_model.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  static Widget render() {
    return ChangeNotifierProvider(
      create: (context) => SettingPageViewModel(),
      child: const SettingPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SettingPageViewModel viewModel = context.read<SettingPageViewModel>();
    SettingPageState state = context.select((SettingPageViewModel viewModel) => viewModel.state);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        middle: Text('Setting'),
      ),
      child: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(state.isDarkTheme ? CupertinoIcons.moon_fill : CupertinoIcons.sun_max_fill),
                  const SizedBox(width: 16.0),
                  const Text('Dark theme'),
                  const Spacer(),
                  CupertinoSwitch(
                    value: state.isDarkTheme,
                    onChanged: (value) => viewModel.changeTheme(),
                    activeColor: CupertinoColors.activeGreen,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
