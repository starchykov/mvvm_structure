import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mvvm_structure/domain/services/locale_service.dart';
import 'package:mvvm_structure/domain/services/theme_service.dart';
import 'package:mvvm_structure/ui/application/app_state.dart';

class AppViewModel extends ChangeNotifier {
  final ThemeService _themeService = ThemeService();
  final LocaleService _localeService = LocaleService();
  AppState _state = const AppState(isDarkTheme: false, isOfflineMode: false, locale: 'en');

  AppState get state => _state;

  late StreamSubscription<String> _themeSubscription;
  late StreamSubscription<String> _localeSubscription;

  AppViewModel() {
    _themeSubscription = _themeService.themeStream.listen((_) => _setCurrentTheme());
    _localeSubscription = _localeService.localeStream.listen((_) async => await _setCurrentLocale());
    _initialize();
  }

  void _initialize() async {
    await _setCurrentTheme();
    await _setCurrentLocale();
  }

  Future<void> _setCurrentTheme() async {
    await _themeService.getThemeMode();
    _state = _state.copyWith(isDarkTheme: _themeService.isDarkMode);
    notifyListeners();
  }

  Future<void> _setCurrentLocale() async {
    await _localeService.getlocaleMode();
    _state = _state.copyWith(locale: _localeService.locale);
    notifyListeners();
  }

  @override
  void dispose() {
    _themeSubscription.cancel();
    _localeSubscription.cancel();
    super.dispose();
  }
}
