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
import 'package:medical_system/features/book_appointment/patient_details/patient_appointment_details.dart';
import 'package:medical_system/features/book_appointment/review_summary/logic/review_summary_cubit.dart';
import 'package:medical_system/features/book_appointment/review_summary/review_summary.dart';
import 'package:medical_system/features/book_appointment/select_date_time/logic/date_time_cubit.dart';
import 'package:medical_system/features/book_appointment/select_date_time/select_date_time.dart';
import 'package:medical_system/features/clinics/clinics.dart';
import 'package:medical_system/features/clinics/data/model/clinic_model.dart';
import 'package:medical_system/features/clinics/logic/clinic_cubit.dart';
import 'package:medical_system/features/clinics/widgets/clinic_profile/clinic_profile.dart';
import 'package:medical_system/features/default.dart';
import 'package:medical_system/features/doctor_profile/doctor_profile.dart';
import 'package:medical_system/features/doctor_profile/logic/doctor_profile_cubit.dart';
import 'package:medical_system/features/forget_password/forget_password.dart';
import 'package:medical_system/features/home/ui/home.dart';
import 'package:medical_system/features/home/ui/widgets/services/logic/services_cubit.dart';
import 'package:medical_system/features/home/ui/widgets/services/ui/ask_question/ask_question.dart';
import 'package:medical_system/features/home/ui/widgets/services/ui/find_medicine/find_medicine.dart';
import 'package:medical_system/features/home/ui/widgets/services/ui/heart_rate/heart_rate.dart';
import 'package:medical_system/features/laboratories/data/model/labs_model.dart';
import 'package:medical_system/features/laboratories/logic/laboratories_cubit.dart';
import 'package:medical_system/features/laboratories/ui/laboratories.dart';
import 'package:medical_system/features/laboratories/ui/widgets/lab_profile/lab_profile.dart';
import 'package:medical_system/features/laboratories/ui/widgets/select_city.dart';
import 'package:medical_system/features/laboratories/ui/widgets/select_government.dart';
import 'package:medical_system/features/language/language.dart';
import 'package:medical_system/features/login/logic/login_cubit.dart';
import 'package:medical_system/features/login/login.dart';
import 'package:medical_system/features/main/logic/main_cubit.dart';
import 'package:medical_system/features/main/main_screen.dart';
import 'package:medical_system/features/map/google_map.dart';
import 'package:medical_system/features/map/map_location.dart';
import 'package:medical_system/features/medical_histroy/logic/ai_medical_histroy_cubit.dart';
import 'package:medical_system/features/medical_histroy/widgets/ai_medical_histroy/ai_medical_histroy.dart';
import 'package:medical_system/features/medical_histroy/widgets/questions/questions.dart';
import 'package:medical_system/features/notifications/logic/notifications_cubit.dart';
import 'package:medical_system/features/notifications/ui/notifications.dart';
import 'package:medical_system/features/offers/data/model/offers_model.dart';
import 'package:medical_system/features/offers/logic/offers_cubit.dart';
import 'package:medical_system/features/offers/ui/offers.dart';
import 'package:medical_system/features/offers/ui/widgets/offers_profile.dart/offers_profile.dart';
import 'package:medical_system/features/onBoarding/onBoarding.dart';
import 'package:medical_system/features/otp/logic/otp_cubit.dart';
import 'package:medical_system/features/otp/otp.dart';
import 'package:medical_system/features/payment/payment.dart';
import 'package:medical_system/features/payment_web_view/payment_web_view.dart';
import 'package:medical_system/features/personal_info/logic/personal_info_cubit.dart';
import 'package:medical_system/features/personal_info/personal_info.dart';
import 'package:medical_system/features/profile/logic/profile_cubit.dart';
import 'package:medical_system/features/profile/profile.dart';
import 'package:medical_system/features/profile/widgets/edit_profile/edit_profile.dart';
import 'package:medical_system/features/profile/widgets/labResult/labResult.dart';
import 'package:medical_system/features/profile/widgets/language.dart';
import 'package:medical_system/features/profile/widgets/questionAnswers/questionAnwsers.dart';
import 'package:medical_system/features/register/logic/register_cubit.dart';
import 'package:medical_system/features/register/register.dart';
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
        bool justVerify = arg['justVerify'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => OtpCubit()..sendOtp(email: email),
                  child: Otp(
                    justVerify: justVerify,
                    email: email,
                    password: password,
                  ),
                ));
      case AppRoutes.forgetPassword:
        String email = args as String;
        return MaterialPageRoute(
            builder: (_) => ForgetPassword(
                  email: email,
                ));
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
                    clinic: arg['clinic'],
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
                      withSearch: arg['withSearch'],
                      city: arg['city'],
                      gov: arg['govrnment'],
                    ),
                  child: Search(
                    spciality: arg['speciality'],
                    government: arg['govrnment'],
                    city: arg['city'],
                    user: arg['user'],
                  ),
                ));
      case AppRoutes.pickAppointmentDate:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      DateTimeCubit()..getAvailableDays(arg['workTimes']),
                  child: DateAndTime(
                    user: arg['user'],
                    workTimes: arg['workTimes'],
                    // clinic: arg['doctor'],
                    appointment: arg['appointment'],
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
                  //doctor: arg['doctor'],
                ));

      case AppRoutes.payment:
        return MaterialPageRoute(builder: (_) => const Payment());
      case AppRoutes.rescheduleAppointment:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        String appointmentId = arg['appointmentId'];
        WorkTimes workTimes = arg['workTimes'];
        //Clinic clinic = arg['clinic'];
        String doctorId = arg['doctorId'];
        Appointment appointment = arg['appointment'];

        return MaterialPageRoute(
            builder: (_) => ReschedualAppointment(
                  appointmentId: appointmentId,
                  workTimes: workTimes,
                  appointment: appointment,
                  //clinic: clinic,
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
                    // doctor: arg['doctor'],
                  ),
                ));
      case AppRoutes.map:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => MapLocation(
                  appointment: arg['appointment'],
                ));
      case AppRoutes.writePreview:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        Appointment appointment = arg['appointment'];
        UserModel user = arg['user'];

        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => WriteReviewCubit(),
                  child: WriteReview(
                    appointment: appointment,
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
        String patientId = args as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => NotificationsCubit()
                    ..getNotifications(patientId: patientId),
                  child: const Notifications(),
                ));
      case AppRoutes.editProfile:
        UserModel user = args as UserModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProfileCubit()..init(user),
            child: EditProfile(
              user: user,
            ),
          ),
        );
      case AppRoutes.myQuestionAnswers:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<ProfileCubit>(arg['context']),
            child: Questionanwsers(),
          ),
        );
      case AppRoutes.labResults:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<ProfileCubit>(arg['context']),
            child: LabResult(),
          ),
        );
      case AppRoutes.appointmentDetails:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        UserModel user = arg['user'];
        int id = arg['id'];

        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AppointmentsCubit()..getAppointment(id),
                  child: AppointmentDetails(
                    user: user,
                  ),
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
        BuildContext context = arg['context'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<ReviewSummaryCubit>(context),
                  child: PaymentWebView(
                    token: token,
                    appointment: appointment,
                    userModel: user,
                  ),
                ));
      case AppRoutes.cancelAppointment:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        Appointment appointment = arg['appointment'];
        BuildContext context = arg['context'];
        UserModel user = arg['user'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<AppointmentsCubit>(context),
                  child: CancelAppointment(
                    appointment: appointment,
                    user: user,
                  ),
                ));
      case AppRoutes.laboratories:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        String specialty = arg['specialty'];
        String government = arg['govrnment'];
        String city = arg['city'];
        UserModel user = arg['user'];
        bool? withSearch = arg['withSearch'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LaboratoriesCubit()
                    ..getLabs(
                        specialty: specialty,
                        gov: government,
                        city: city,
                        withSearch: withSearch ?? false),
                  child: Laboratories(
                    specialty: specialty,
                    government: government,
                    city: city,
                    user: user,
                  ),
                ));
      case AppRoutes.clinics:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        String government = arg['government'];
        String city = arg['city'];
        UserModel user = arg['user'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      ClinicCubit()..getClinics(gov: government, city: city),
                  child: AppClinics(
                    government: government,
                    city: city,
                    user: user,
                  ),
                ));
      case AppRoutes.clinicsProfile:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        ClinicInfo clinic = arg['clinic'];
        UserModel user = arg['user'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ClinicCubit(),
                  child: ClinicProfile(clinic: clinic, user: user),
                ));
      case AppRoutes.laboratoriesProfile:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        LabsInfo laboratory = arg['lab'];
        BuildContext context = arg['context'];
        UserModel user = arg['user'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<LaboratoriesCubit>(context),
                  child: LabProfile(lab: laboratory, user: user),
                ));
      case AppRoutes.offers:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        String provider = arg['provider'];
        UserModel user = arg['user'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => OffersCubit()..getOffers(provider),
                  child: Offers(
                    user: user,
                  ),
                ));
      case AppRoutes.selectGovernment:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        String speciality = arg['specialty'];
        String type = arg['type'];
        UserModel user = arg['user'];
        return MaterialPageRoute(
          builder: (_) => SelectGovernment(
            speciality: speciality,
            type: type,
            user: user,
          ),
        );
      case AppRoutes.selectCity:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        String speciality = arg['specialty'];
        String type = arg['type'];
        String government = arg['government'];
        UserModel user = arg['user'];
        return MaterialPageRoute(
          builder: (_) => SelectCity(
            speciality: speciality,
            user: user,
            type: type,
            government: government,
          ),
        );
      case AppRoutes.offersProfile:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        OffersModel offer = arg['offer'];
        UserModel user = arg['user'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => OffersCubit(),
                  child: OffersProfile(offer: offer, user: user),
                ));
      case AppRoutes.googlemap:
        Appointment appointment = args as Appointment;
        return MaterialPageRoute(
            builder: (_) => GoogleMapPage(
                  appointment: appointment,
                ));
      case AppRoutes.aiMedicalHistroy:
        BuildContext context = args as BuildContext;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AiMedicalHistroyCubit(),
                  child: AiMedicalHistroy(),
                ));
      case AppRoutes.histroyQuestions:
        Map<String, dynamic> arg = args as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<AiMedicalHistroyCubit>(arg['context']),
                  child: MedicalHistroyQuestions(
                    user: arg['user'],
                  ),
                ));

      default:
        return MaterialPageRoute(builder: (_) => Default());
    }
  }
}
