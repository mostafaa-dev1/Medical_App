import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/keys.dart';
import 'package:medical_system/core/networking/bloc_observer.dart';
import 'package:medical_system/core/networking/shared_preferances.dart';
import 'package:medical_system/core/routing/router.dart';
import 'package:medical_system/firebase_options.dart';
import 'package:medical_system/medical_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CashHelper.init();
  await EasyLocalization.ensureInitialized();
  await Supabase.initialize(
      url: 'https://rtyoiajuweefbckoyxod.supabase.co',
      anonKey: AppKeys.supabase);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();

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
