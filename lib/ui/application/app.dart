import 'package:flutter/cupertino.dart';
import 'package:mvvm_structure/domain/constants/constants.dart';
import 'package:mvvm_structure/ui/application/app_state.dart';
import 'package:mvvm_structure/ui/application/app_view_model.dart';
import 'package:mvvm_structure/ui/navigation/app_navigation.dart';
import 'package:provider/provider.dart';

class MVVMStructure extends StatelessWidget {
  const MVVMStructure({Key? key}) : super(key: key);

  static Widget render() {
    return ChangeNotifierProvider(
      create: (context) => AppViewModel(),
      child: const MVVMStructure(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppNavigation appNavigation = AppNavigation();
    final AppState state = context.select((AppViewModel viewModel) => viewModel.state);
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        brightness: state.isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      supportedLocales: Language.locales,
      routes: appNavigation.routes,
      initialRoute: AppNavigationRoutes.homeWidget,
    );
  }
}
