import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_system/core/networking/shared_preferances.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  ThemeMode _themeMode = ThemeMode.light; // Default theme
  Locale _locale = const Locale('en'); // Default language
  TextStyle Function() _fontStyle = () => GoogleFonts.poppins();

  AppCubit() : super(AppInitial());

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  TextStyle Function() get fontStyle => _fontStyle;

  void changeThemeMode() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(AppThemeChanged(_themeMode));
    _saveThemePreferances(_locale);
  }

  void toggleLanguage(BuildContext context) {
    if (_locale.languageCode == 'en') {
      _locale = const Locale('ar');
      _fontStyle = () => GoogleFonts.cairo();
    } else {
      _locale = const Locale('en');
      _fontStyle = () => GoogleFonts.poppins();
    }
    context.setLocale(_locale);
    emit(AppLanguageChanged(_locale));
    emit(AppFontChanged(_fontStyle));
    _saveLanguagePreferances(_locale);
  }

  Future<void> _saveThemePreferances(Locale locale) async {
    await CashHelper.putString(
        key: 'theme', value: _themeMode == ThemeMode.light ? 'light' : 'dark');
  }

  Future<void> _saveLanguagePreferances(Locale locale) async {
    await CashHelper.putString(key: 'language', value: locale.languageCode);
  }

  Future<void> loadPreferences() async {
    // Load language preference or default to English
    final languageCode = CashHelper.getString(key: 'language') ?? 'en';
    _locale = Locale(languageCode);
    log('Language: $languageCode');

    // Load theme preference or default to light theme
    final themeString = CashHelper.getString(key: 'theme') ?? 'light';
    _themeMode = themeString == 'light' ? ThemeMode.light : ThemeMode.dark;
    log('Theme: $_themeMode');

    // Update font style based on language
    _fontStyle = languageCode == 'ar'
        ? () => GoogleFonts.cairo()
        : () => GoogleFonts.poppins();
    log('Font Style: $_fontStyle');

    emit(AppPreferencesLoaded(_themeMode, _locale));
  }
}
