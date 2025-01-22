import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_system/core/themes/colors.dart';

ThemeData darkTheme(TextStyle Function() fontStyle) => ThemeData(
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: AppColors.mainColor,
        applyThemeToAll: true,
      ),
      textTheme: TextTheme(
        headlineLarge: fontStyle().copyWith(
          color: Colors.white,
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: fontStyle().copyWith(
          color: Colors.white,
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: fontStyle().copyWith(
          color: Colors.white,
          fontSize: 24.sp,
        ),
        bodyLarge: fontStyle().copyWith(
          color: Colors.white,
          fontSize: 20.sp,
        ),
        bodyMedium: fontStyle().copyWith(
          color: Colors.white,
          fontSize: 16.sp,
        ),
        bodySmall: fontStyle().copyWith(
          color: Colors.white,
          fontSize: 14.sp,
        ),
        labelLarge: fontStyle().copyWith(
          color: Colors.white,
          fontSize: 16.sp,
        ),
        labelMedium: fontStyle().copyWith(
          color: Colors.white,
          fontSize: 14.sp,
        ),
        labelSmall: fontStyle().copyWith(
          color: Colors.white,
          fontSize: 12.sp,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
        iconColor: WidgetStateProperty.all(Colors.white),
      )),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all(Colors.white),
        ),
      ),
      canvasColor: Colors.white,
      brightness: Brightness.dark,
      cardColor: Colors.grey[850],
      highlightColor: Colors.grey[850],
      dividerColor: Colors.grey[800],
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColors.mainColor,
        primary: Colors.grey[850],
        background: Colors.grey[900],
        secondary: Colors.grey[800],
        shadow: Colors.grey[900],
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.grey[900],
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.grey[900],
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.grey[900],
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarContrastEnforced: true,
          )),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor:
            AppColors.mainColor, // Color of the selection background
        cursorColor: AppColors.mainColor, // Color of the cursor
        // Color of the selection handles
      ),
    );
