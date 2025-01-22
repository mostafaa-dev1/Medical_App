import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_system/core/themes/colors.dart';

lightTheme(TextStyle Function() fontStyle) => ThemeData(
      textTheme: TextTheme(
        headlineLarge: fontStyle().copyWith(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: fontStyle().copyWith(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: fontStyle().copyWith(
          fontSize: 24.sp,
        ),
        bodyLarge: fontStyle().copyWith(
          fontSize: 20.sp,
        ),
        bodyMedium: fontStyle().copyWith(
          fontSize: 16.sp,
        ),
        bodySmall: fontStyle().copyWith(
          fontSize: 14.sp,
        ),
        labelLarge: fontStyle().copyWith(
          fontSize: 16.sp,
        ),
        labelMedium: fontStyle().copyWith(
          fontSize: 14.sp,
        ),
        labelSmall: fontStyle().copyWith(
          fontSize: 12.sp,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
        iconColor: WidgetStateProperty.all(Colors.black),
      )),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all(Colors.black),
        ),
      ),
      brightness: Brightness.light,
      cardColor: const Color.fromARGB(255, 245, 245, 245),
      highlightColor: const Color.fromARGB(255, 243, 243, 243),
      dividerColor: Colors.grey[300],
      canvasColor: Colors.black,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: AppColors.mainColor,
        primary: Colors.white,
        background: Colors.grey[300],
        secondary: Colors.grey[100],
        shadow: Colors.grey[100],
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          )),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor:
            AppColors.mainColor, // Color of the selection background
        cursorColor: AppColors.mainColor, // Color of the cursor
        // Color of the selection handles
      ),
    );
