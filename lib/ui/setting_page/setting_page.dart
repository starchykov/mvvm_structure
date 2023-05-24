import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mvvm_structure/ui/setting_page/setting_page_state.dart';
import 'package:mvvm_structure/ui/setting_page/setting_page_view_model.dart';
import 'package:mvvm_structure/utils/constants.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  static Widget render() {
    return ChangeNotifierProvider(
      create: (context) => SettingPageViewModel(context: context),
      child: const SettingPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SettingPageViewModel viewModel = context.read<SettingPageViewModel>();
    SettingPageState state = context.select((SettingPageViewModel viewModel) => viewModel.state);

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        middle: Text(AppLocalizations.of(context)!.settings),
      ),
      child: Center(
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  leading: Icon(state.isDarkTheme ? CupertinoIcons.moon_fill : CupertinoIcons.sun_max_fill),
                  title: Text(AppLocalizations.of(context)!.darkMode),
                  trailing: CupertinoSwitch(
                    value: state.isDarkTheme,
                    onChanged: (value) => viewModel.changeTheme(),
                    activeColor: CupertinoColors.activeGreen,
                  ),
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.textformat),
                  title: CupertinoPicker(
                    itemExtent: kItemExtent,
                    selectionOverlay: Container(),
                    scrollController: viewModel.scrollController,
                    onSelectedItemChanged: (int selectedLocale) => viewModel.changeLocale(localeId: selectedLocale),
                    children: List<Widget>.generate(AppLocalizations.supportedLocales.length, (int index) {
                      String languageCode = AppLocalizations.supportedLocales[index].languageCode;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.language(languageCode),
                            style: CupertinoTheme.of(context).textTheme.textStyle,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
