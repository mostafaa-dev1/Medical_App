import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_system/core/themes/colors.dart';

lightTheme(TextStyle Function() fontStyle, BuildContext context) => ThemeData(
      textTheme: TextTheme(
        headlineLarge: fontStyle().copyWith(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue),
        headlineMedium: fontStyle().copyWith(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue),
        headlineSmall: fontStyle().copyWith(
            fontSize: 24.sp,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.bold),
        titleLarge: fontStyle().copyWith(
          fontSize: 22.sp,
          color: AppColors.darkBlue,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: fontStyle().copyWith(
          fontSize: 20.sp,
          color: AppColors.darkBlue,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: fontStyle().copyWith(
          fontSize: 18.sp,
          color: AppColors.darkBlue,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: fontStyle().copyWith(
            fontSize: 16.sp,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.bold),
        bodyMedium: fontStyle().copyWith(
            fontSize: 14.sp,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.bold),
        bodySmall: fontStyle().copyWith(
            fontSize: 12.sp,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.bold),
        labelLarge:
            fontStyle().copyWith(fontSize: 14.sp, color: AppColors.darkBlue),
        labelMedium:
            fontStyle().copyWith(fontSize: 12.sp, color: AppColors.darkBlue),
        labelSmall:
            fontStyle().copyWith(fontSize: 11.sp, color: AppColors.darkBlue),
      ),
      iconTheme: const IconThemeData(color: AppColors.darkBlue),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
        iconColor: WidgetStateProperty.all(AppColors.darkBlue),
      )),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all(AppColors.darkBlue),
        ),
      ),
      brightness: Brightness.light,
      cardColor: Colors.grey[300],
      highlightColor: const Color.fromARGB(255, 243, 243, 243),
      dividerColor: Colors.grey[100],
      canvasColor: AppColors.darkBlue,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: AppColors.mainColor,
        primary: Colors.white,
        secondary: Colors.grey[100],
        shadow: AppColors.mainColor.withAlpha(10),
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
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
