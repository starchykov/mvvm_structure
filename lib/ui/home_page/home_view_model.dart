import 'package:flutter/material.dart';
import 'package:mvvm_structure/ui/navigation/app_navigation.dart';

class HomeViewModel {
  final BuildContext context;

  HomeViewModel({required this.context});

  Future<void> onSettingButtonPressed() async {
    Navigator.of(context).pushNamed(AppNavigationRoutes.settingWidget);
  }

}
