import 'package:flutter/cupertino.dart';
import 'package:mvvm_structure/domain/services/theme_service.dart';
import 'package:mvvm_structure/ui/setting_page/setting_page_state.dart';

class SettingPageViewModel extends ChangeNotifier {
  final ThemeService _themeService = ThemeService();

  SettingPageState _state = const SettingPageState(isDarkTheme: false, isOfflineMode: false);

  SettingPageState get state => _state;

  SettingPageViewModel() {
    _initialize();
  }

  void _initialize() async {
    await _setTheme();
  }

  Future<void> _setTheme() async {
    await _themeService.getThemeMode();
    _state = _state.copyWith(isDarkTheme: _themeService.isDarkMode);
    notifyListeners();
  }

  Future<void> changeTheme() async {
    await _themeService.changeThemeMode();
    _state = _state.copyWith(isDarkTheme: _themeService.isDarkMode);
    notifyListeners();
  }
}
