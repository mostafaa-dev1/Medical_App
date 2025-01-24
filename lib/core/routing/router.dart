import 'package:flutter/material.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/features/home/home.dart';
import 'package:medical_system/features/language/language.dart';
import 'package:medical_system/features/login/login.dart';
import 'package:medical_system/features/onBoarding/onBoarding.dart';
import 'package:medical_system/features/otp/otp.dart';
import 'package:medical_system/features/register/register.dart';
import 'package:medical_system/features/register/widgets/personal_info.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    //var args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.language:
        return MaterialPageRoute(builder: (_) => const Language());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const Login());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const Register());
      case AppRoutes.personalInfo:
        return MaterialPageRoute(builder: (_) => const PersonalInfo());
      case AppRoutes.otp:
        return MaterialPageRoute(builder: (_) => const Otp());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const Home());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
