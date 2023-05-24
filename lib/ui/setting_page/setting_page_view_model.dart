import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mvvm_structure/domain/services/locale_service.dart';
import 'package:mvvm_structure/domain/services/theme_service.dart';
import 'package:mvvm_structure/ui/setting_page/setting_page_state.dart';

class SettingPageViewModel extends ChangeNotifier {
  final BuildContext context;
  final ThemeService _themeService = ThemeService();
  final LocaleService _localeService = LocaleService();
  final FixedExtentScrollController _scrollController = FixedExtentScrollController();

  SettingPageState _state = const SettingPageState(isDarkTheme: false, isOfflineMode: false);

  SettingPageState get state => _state;

  FixedExtentScrollController get scrollController => _scrollController;

  SettingPageViewModel({required this.context}) {
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
    int localeId = AppLocalizations.supportedLocales.indexWhere((element) => element.languageCode == _localeService.locale);
    _scrollController.jumpToItem(localeId);
    _state = _state.copyWith(locale: _localeService.locale, localeId: localeId);
    notifyListeners();
  }

  Future<void> changeTheme() async {
    await _themeService.changeThemeMode();
    _state = _state.copyWith(isDarkTheme: _themeService.isDarkMode);
    notifyListeners();
  }

  Future<void> changeLocale({required int localeId}) async {
    // print(localeId);
    // print(_state.locale);
    String languageCode = AppLocalizations.supportedLocales[localeId].languageCode;
    if (_state.localeId == 0 && localeId == 0) return;
    await _localeService.changeLocale(locale: languageCode);
    _state = _state.copyWith(locale: _localeService.locale, localeId: localeId);
    notifyListeners();
  }
}
