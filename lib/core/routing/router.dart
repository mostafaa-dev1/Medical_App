import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/features/appointments/appointments.dart';
import 'package:medical_system/features/doctor_profile/doctor_profile.dart';
import 'package:medical_system/features/forget_password/forget_password.dart';
import 'package:medical_system/features/home/home.dart';
import 'package:medical_system/features/home/logic/home_cubit.dart';
import 'package:medical_system/features/language/language.dart';
import 'package:medical_system/features/login/logic/login_cubit.dart';
import 'package:medical_system/features/login/login.dart';
import 'package:medical_system/features/main/main_screen.dart';
import 'package:medical_system/features/onBoarding/onBoarding.dart';
import 'package:medical_system/features/otp/otp.dart';
import 'package:medical_system/features/personal_info/logic/personal_info_cubit.dart';
import 'package:medical_system/features/personal_info/personal_info.dart';
import 'package:medical_system/features/pick_appointment_date/pick_appointment_date.dart';
import 'package:medical_system/features/profile/profile.dart';
import 'package:medical_system/features/profile/widgets/language.dart';
import 'package:medical_system/features/register/logic/register_cubit.dart';
import 'package:medical_system/features/register/register.dart';
import 'package:medical_system/features/search/search.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.language:
        return MaterialPageRoute(builder: (_) => const Language());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
      case AppRoutes.login:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoginCubit(),
                  child: const Login(),
                ));
      case AppRoutes.register:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => RegisterCubit(),
                  child: const Register(),
                ));
      case AppRoutes.personalInfo:
        User user = args as User;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => PersonalInfoCubit(),
            child: PersonalInfo(
              user: user,
            ),
          ),
        );
      case AppRoutes.otp:
        return MaterialPageRoute(builder: (_) => const Otp());
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      case AppRoutes.mainScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => HomeCubit()..init(),
                  child: const MainScreen(),
                ));
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => Home(),
        );
      case AppRoutes.appointments:
        return MaterialPageRoute(builder: (_) => const Appointments());
      case AppRoutes.profile:
        User user = args as User;
        return MaterialPageRoute(
            builder: (_) => Profile(
                  user: user,
                ));
      case AppRoutes.selectLanguage:
        return MaterialPageRoute(builder: (_) => const SelectLanguage());
      case AppRoutes.doctorProfile:
        return MaterialPageRoute(builder: (_) => const DoctorProfile());
      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => Search());
      case AppRoutes.pickAppointmentDate:
        return MaterialPageRoute(builder: (_) => const PickAppointmentDate());
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
