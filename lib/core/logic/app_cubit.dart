import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/networking/services/auth/auth_service.dart';
import 'package:medical_system/core/networking/services/local_databases/shared_preferances.dart';
import 'package:medical_system/features/appointments/appointments.dart';
import 'package:medical_system/features/fav_doctors/favourite_doctors.dart';
import 'package:medical_system/features/home/home.dart';
import 'package:medical_system/features/profile/profile.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  ThemeMode _themeMode = ThemeMode.light; // Default theme
  Locale _locale = const Locale('en'); // Default language
  TextStyle Function() _fontStyle = () => GoogleFonts.poppins();

  AppCubit() : super(AppInitial());

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  TextStyle Function() get fontStyle => _fontStyle;

  int languageIndex = 0;
  int themeIndex = 0;
  void changeThemeMode(int index) {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    themeIndex = _themeMode == ThemeMode.light ? 0 : 1;
    emit(AppThemeChanged(_themeMode));
    _saveThemePreferances(_locale);
  }

  void toggleLanguage(BuildContext context, String language) {
    if (language == _locale.languageCode) {
      return;
    }
    if (language == 'ar') {
      languageIndex = 1;
      _locale = const Locale('ar');
      _fontStyle = () => GoogleFonts.cairo();
    } else {
      languageIndex = 0;
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
    log(PlatformDispatcher.instance.locale.languageCode);
    final languageCode = CashHelper.getString(key: 'language') ??
        PlatformDispatcher.instance.locale.languageCode;
    _locale = Locale(languageCode);
    log('Language: $languageCode');

    final themeString = CashHelper.getString(key: 'theme') ?? 'light';
    _themeMode = themeString == 'light' ? ThemeMode.light : ThemeMode.dark;
    log('Theme: $_themeMode');

    languageIndex = languageCode == 'ar' ? 1 : 0;
    themeIndex = _themeMode == ThemeMode.light ? 0 : 1;

    _fontStyle = languageCode == 'ar'
        ? () => GoogleFonts.almarai()
        : () => GoogleFonts.poppins();
    log('Font Style: $_fontStyle');

    emit(AppPreferencesLoaded(_themeMode, _locale));
  }

  List<Widget> pages(User user) {
    return [
      Home(),
      Appointments(),
      FavouriteDoctors(),
      Profile(
        user: user,
      )
    ];
  }

  int pageIndex = 0;

  void changePageIndex(int index) {
    pageIndex = index;
    emit(AppPageIndexChanged());
  }

  bool isUserRegistered() {
    return AuthService().currentUser != null;
  }

  void logout() async {
    await AuthService().signOut().then((_) {
      emit(AppLogout());
    });
  }
}
