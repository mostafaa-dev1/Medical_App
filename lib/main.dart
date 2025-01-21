import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/networking/shared_preferances.dart';
import 'package:medical_system/core/routing/router.dart';
import 'package:medical_system/medical_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CashHelper.init();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MedicalApp(
          appRouter: AppRouter(),
        )),
  );
}
