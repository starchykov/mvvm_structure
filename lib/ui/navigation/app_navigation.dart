import 'package:flutter/cupertino.dart';
import 'package:mvvm_structure/ui/home_page/home_page.dart';
import 'package:mvvm_structure/ui/setting_page/setting_page.dart';

abstract class AppNavigationRoutes {
  static const homeWidget = '/';
  static const settingWidget = '/setting';
}

class AppNavigation {
  final Map<String, Widget Function(BuildContext)> routes = <String, Widget Function(BuildContext)>{
    AppNavigationRoutes.homeWidget: (context) => HomePage.render(),
    AppNavigationRoutes.settingWidget: (context) => SettingPage.render(),
  };
}
