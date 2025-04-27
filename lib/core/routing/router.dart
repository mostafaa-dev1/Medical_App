import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/features/ai_chat/ai_chat.dart';
import 'package:medical_system/features/ai_chat/logic/ai_cubit.dart';
import 'package:medical_system/features/appointment_details/appointment_details.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/appointments/logic/appointments_cubit.dart';
import 'package:medical_system/features/appointments/ui/appointments.dart';
import 'package:medical_system/features/appointments/ui/widgets/cancel_reschedual_appointment/cancel_appointment.dart';
import 'package:medical_system/features/appointments/ui/widgets/cancel_reschedual_appointment/reschedual_appointment.dart';
import 'package:medical_system/features/book_appointment/book_appointment.dart';
import 'package:medical_system/features/book_appointment/logic/book_appointment_cubit.dart';
import 'package:medical_system/features/doctor_profile/doctor_profile.dart';
import 'package:medical_system/features/doctor_profile/logic/doctor_profile_cubit.dart';
import 'package:medical_system/features/forget_password/forget_password.dart';
import 'package:medical_system/features/home/logic/main_cubit.dart';
import 'package:medical_system/features/home/ui/home.dart';
import 'package:medical_system/features/home/ui/widgets/services/logic/services_cubit.dart';
import 'package:medical_system/features/home/ui/widgets/services/ui/ask_question/ask_question.dart';
import 'package:medical_system/features/home/ui/widgets/services/ui/find_medicine/find_medicine.dart';
import 'package:medical_system/features/home/ui/widgets/services/ui/heart_rate/heart_rate.dart';
import 'package:medical_system/features/language/language.dart';
import 'package:medical_system/features/login/logic/login_cubit.dart';
import 'package:medical_system/features/login/login.dart';
import 'package:medical_system/features/main/main_screen.dart';
import 'package:medical_system/features/map/map_location.dart';
import 'package:medical_system/features/notifications/notifications.dart';
import 'package:medical_system/features/onBoarding/onBoarding.dart';
import 'package:medical_system/features/otp/logic/otp_cubit.dart';
import 'package:medical_system/features/otp/otp.dart';
import 'package:medical_system/features/patient_details/patient_appointment_details.dart';
import 'package:medical_system/features/payment/payment.dart';
import 'package:medical_system/features/payment_web_view/payment_web_view.dart';
import 'package:medical_system/features/personal_info/logic/personal_info_cubit.dart';
import 'package:medical_system/features/personal_info/personal_info.dart';
import 'package:medical_system/features/profile/logic/profile_cubit.dart';
import 'package:medical_system/features/profile/profile.dart';
import 'package:medical_system/features/profile/widgets/edit_profile/edit_profile.dart';
import 'package:medical_system/features/profile/widgets/language.dart';
import 'package:medical_system/features/register/logic/register_cubit.dart';
import 'package:medical_system/features/register/register.dart';
import 'package:medical_system/features/review_summary/logic/review_summary_cubit.dart';
import 'package:medical_system/features/review_summary/review_summary.dart';
import 'package:medical_system/features/reviews/reviews.dart';
import 'package:medical_system/features/search/logic/search_cubit.dart';
import 'package:medical_system/features/search/search.dart';
import 'package:medical_system/features/spcialities/logic/spcialities_cubit.dart';
import 'package:medical_system/features/spcialities/spcialities.dart';
import 'package:medical_system/features/write_review/logic/write_review_cubit.dart';
import 'package:medical_system/features/write_review/write_review.dart';

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
        UserModel user = args as UserModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => PersonalInfoCubit(),
            child: PersonalInfo(
              user: user,
            ),
          ),
        );
      case AppRoutes.otp:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        String email = arg['email'];
        String password = arg['password'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => OtpCubit()..sendOtp(email: email),
                  child: Otp(
                    email: email,
                    password: password,
                  ),
                ));
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      case AppRoutes.mainScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => MainCubit()..init(),
                  child: const MainScreen(),
                ));
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => Home(),
        );
      case AppRoutes.appointments:
        UserModel user = args as UserModel;
        return MaterialPageRoute(
            builder: (_) => Appointments(
                  user: user,
                ));
      case AppRoutes.profile:
        UserModel user = args as UserModel;
        return MaterialPageRoute(
          builder: (_) => Profile(
            user: user,
          ),
        );
      case AppRoutes.selectLanguage:
        return MaterialPageRoute(builder: (_) => const SelectLanguage());
      case AppRoutes.doctorProfile:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      DoctorProfileCubit()..getReviews(arg['doctorId'], 3),
                  child: DoctorProfile(
                    doctor: arg['clinic'],
                    user: arg['user'],
                  ),
                ));
      case AppRoutes.search:
        Map<String, dynamic> arg = args as Map<String, dynamic>;

        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SearchCubit()
                    ..search(
                        spciality: arg['speciality'],
                        withSearch: arg['withSearch']),
                  child: Search(
                    user: arg['user'],
                  ),
                ));
      case AppRoutes.pickAppointmentDate:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => BookAppointmentCubit()
                    ..getAvailableDays(arg['workTimes']),
                  child: BookAppointment(
                    user: arg['user'],
                    workTimes: arg['workTimes'],
                    clinic: arg['doctor'],
                    reason: arg['reason'],
                    reschdule: arg['reschdule'],
                    appointMentId: arg['appointmentId'],
                    doctorId: arg['doctorId'],
                  ),
                ));
      case AppRoutes.patientAppointmentDetails:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => PatientAppointmentDetails(
                  user: arg['user'],
                  appointment: arg['appointment'],
                  doctor: arg['doctor'],
                ));

      case AppRoutes.payment:
        return MaterialPageRoute(builder: (_) => const Payment());
      case AppRoutes.rescheduleAppointment:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        String appointmentId = arg['appointmentId'];
        WorkTimes workTimes = arg['workTimes'];
        Clinic clinic = arg['clinic'];
        String doctorId = arg['doctorId'];

        return MaterialPageRoute(
            builder: (_) => ReschedualAppointment(
                  appointmentId: appointmentId,
                  workTimes: workTimes,
                  clinic: clinic,
                  doctorId: doctorId,
                ));
      case AppRoutes.reviews:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        String doctorId = arg['doctorId'];
        BuildContext context = arg['context'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: context.read<DoctorProfileCubit>()
                    ..getReviews(doctorId, null),
                  child: const Reviews(),
                ));
      case AppRoutes.reviewSummary:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ReviewSummaryCubit(),
                  child: ReviewSummary(
                    user: arg['user'],
                    appointment: arg['appointment'],
                    doctor: arg['doctor'],
                  ),
                ));
      case AppRoutes.map:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => MapLocation(
                  clinic: arg['clinic'],
                  doctor: arg['doctor'],
                ));
      case AppRoutes.writePreview:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        Doctor doctor = arg['doctor'];
        Clinic clinic = arg['clinic'];
        UserModel user = arg['user'];

        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => WriteReviewCubit(),
                  child: WriteReview(
                    doctor: doctor,
                    clinic: clinic,
                    user: user,
                  ),
                ));
      case AppRoutes.aiChat:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        UserModel user = arg['user'];
        BuildContext context = arg['context'];

        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => AiCubit()..init(context),
                  child: AiChat(
                    user: user,
                  ),
                ));
      case AppRoutes.notifications:
        return MaterialPageRoute(builder: (_) => const Notifications());
      case AppRoutes.editProfile:
        UserModel user = args as UserModel;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ProfileCubit()..init(user),
                  child: EditProfile(
                    user: user,
                  ),
                ));
      case AppRoutes.appointmentDetails:
        Appointment upcomingVisitsModel = args as Appointment;
        return MaterialPageRoute(
            builder: (_) => AppointmentDetails(
                  model: upcomingVisitsModel,
                ));
      case AppRoutes.spcialities:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        UserModel user = arg['user'];
        String type = arg['type'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SpcialtiesCubit()
                    ..getSpecialities(
                      type: type,
                    ),
                  child: Specialities(
                    user: user,
                  ),
                ));
      case AppRoutes.askQuestion:
        String userId = args as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ServicesCubit(),
                  child: AskQuestion(
                    userId: userId,
                  ),
                ));
      case AppRoutes.heartRate:
        return MaterialPageRoute(builder: (_) => const HeartRate2());
      case AppRoutes.findMedicine:
        String userId = args as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ServicesCubit(),
                  child: FindMedicine(
                    userId: userId,
                  ),
                ));
      case AppRoutes.paymentWebView:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        String token = arg['token'];
        Appointment appointment = arg['appointment'];
        UserModel user = arg['user'];
        Clinic doctor = arg['doctor'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: ReviewSummaryCubit(),
                  child: PaymentWebView(
                    token: token,
                    appointment: appointment,
                    userModel: user,
                    doctor: doctor,
                  ),
                ));
      case AppRoutes.cancelAppointment:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        Appointment appointment = arg['appointment'];
        BuildContext context = arg['context'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<AppointmentsCubit>(context),
                  child: CancelAppointment(
                    appointment: appointment,
                  ),
                ));
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
