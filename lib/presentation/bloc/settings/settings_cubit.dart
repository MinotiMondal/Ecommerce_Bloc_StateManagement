import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../core/constants/app_constants.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final box = await Hive.openBox(AppConstants.settingsBoxName);

      final themeModeIndex = box.get(AppConstants.themeKey, defaultValue: 0);
      final languageCode = box.get(
        AppConstants.languageKey,
        defaultValue: 'en',
      );

      final themeMode = ThemeMode.values[themeModeIndex];
      final locale = Locale(languageCode);

      print('Loaded settings - theme: ${themeMode.name}, locale: ${languageCode}');
      emit(state.copyWith(themeMode: themeMode, locale: locale));
    } catch (e) {
      print('Error loading settings: $e');
      // Use default values if loading fails
    }
  }

  Future<void> changeThemeMode(ThemeMode themeMode) async {
    try {
      final box = await Hive.openBox(AppConstants.settingsBoxName);
      await box.put(AppConstants.themeKey, themeMode.index);
      emit(state.copyWith(themeMode: themeMode));
    } catch (e) {
      // Handle error
    }
  }

  Future<void> changeLocale(Locale locale) async {
    try {
      final box = await Hive.openBox(AppConstants.settingsBoxName);
      await box.put(AppConstants.languageKey, locale.languageCode);
      print('Saved language: ${locale.languageCode}');
      emit(state.copyWith(locale: locale));
      print('Emitted new state with locale: ${state.locale.languageCode}');
    } catch (e) {
      print('Error changing locale: $e');
    }
  }

  void toggleTheme() {
    final newThemeMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    changeThemeMode(newThemeMode);
  }

  void toggleLanguage() {
    final newLocale = state.locale.languageCode == 'en'
        ? const Locale('es')
        : const Locale('en');
    print('Toggling language from ${state.locale.languageCode} to ${newLocale.languageCode}');
    changeLocale(newLocale);
  }
}
