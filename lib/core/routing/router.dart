import 'package:flutter/material.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/features/onBoarding/onBoarding.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    //var args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
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
