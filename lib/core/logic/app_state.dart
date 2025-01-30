part of 'app_cubit.dart';

@immutable
sealed class AppState {}

class AppInitial extends AppState {}

class AppThemeChanged extends AppState {
  final ThemeMode themeMode;
  AppThemeChanged(this.themeMode);
}

class AppLanguageChanged extends AppState {
  final Locale locale;
  AppLanguageChanged(this.locale);
}

class AppFontChanged extends AppState {
  final TextStyle Function() fontStyle;
  AppFontChanged(this.fontStyle);
}

class AppPreferencesLoaded extends AppState {
  final ThemeMode themeMode;
  final Locale locale;

  AppPreferencesLoaded(this.themeMode, this.locale);
}

final class AppPageIndexChanged extends AppState {}
