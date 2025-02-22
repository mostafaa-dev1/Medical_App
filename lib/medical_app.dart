import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_system/core/logic/app_cubit.dart';
import 'package:medical_system/core/routing/router.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/dark_theme.dart';
import 'package:medical_system/core/themes/light_theme.dart';

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
      designSize: Size(width, height),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => AppCubit()..loadPreferences(),
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.read<AppCubit>().locale,
                debugShowCheckedModeBanner: false,
                title: 'Medical App',
                theme: lightTheme(context.read<AppCubit>().fontStyle, context),
                onGenerateRoute: (settings) {
                  return appRouter.generateRoute(settings);
                },
                darkTheme:
                    darkTheme(context.read<AppCubit>().fontStyle, context),
                themeMode: context.read<AppCubit>().themeMode,
                initialRoute: context.read<AppCubit>().isUserRegistered()
                    ? AppRoutes.mainScreen
                    : AppRoutes.language,
              );
            },
          ),
        );
      },
    );
  }
}
