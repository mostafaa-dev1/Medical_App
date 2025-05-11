import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/doctor_profile/logic/doctor_profile_cubit.dart';
import 'package:medical_system/features/doctor_profile/widgets/doctor_info.dart';
import 'package:medical_system/features/doctor_profile/widgets/experinces.dart';
import 'package:medical_system/features/doctor_profile/widgets/review_list.dart';
import 'package:medical_system/features/doctor_profile/widgets/work_times.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key, required this.clinic, required this.user});
  final Clinic clinic;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'doctorProfile.doctorProfile'.tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            persistentFooterButtons: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: CustomButton(
                  onPressed: () {
                    Appointment appointment = Appointment(
                      clinic: clinic,
                      clinicId: clinic.id,
                      patientId: user.id,
                      type: 'Upcoming',
                      doctor: clinic.doctor,
                      fee: clinic.fee,
                    );
                    log(appointment.clinic!.workTimes!.workTimes![0]
                        .toJson()
                        .toString());

                    context
                        .pushNamed(AppRoutes.pickAppointmentDate, arguments: {
                      'workTimes': clinic.workTimes,
                      'user': user,
                      //'doctor': clinic,
                      'appointment': appointment,
                      'reason': '',
                      'reschdule': false,
                      'appointmentId': '',
                      'doctorId': ''
                    });
                  },
                  buttonName: 'doctorProfile.bookAppointment'.tr(),
                  width: double.infinity,
                  paddingVirtical: 5,
                  height: 40,
                  paddingHorizental: 10,
                ),
              ),
            ],
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DoctorInfoProfile(doctor: clinic),
                        verticalSpace(20),
                        Divider(
                          color: Theme.of(context).dividerColor,
                          indent: AppPreferances.screenWidth(context) / 5.5,
                          endIndent: AppPreferances.screenWidth(context) / 5.5,
                        ),
                        verticalSpace(20),
                        Experinces(doctor: clinic),
                        verticalSpace(20),
                        Divider(
                          color: Theme.of(context).dividerColor,
                          indent: AppPreferances.screenWidth(context) / 5.5,
                          endIndent: AppPreferances.screenWidth(context) / 5.5,
                        ),
                        verticalSpace(20),
                        Text(
                          'doctorProfile.about'.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        verticalSpace(10),
                        Text(
                          LanguageChecker.isArabic(context)
                              ? clinic.doctorInfo!.aboutAr!
                              : clinic.doctorInfo!.about!,
                          // 'Dr. John Doe is a doctor who specializes in brain and nervous system disorders. He has been in practice for over 20 years and has been recognized for his expertise in treating patients with neurological disorders. He is a highly respected and respected doctor in the community.',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    height: 1.5,
                                    color: AppColors.lightBlue,
                                  ),
                        ),
                        verticalSpace(20),
                        WorkTimesList(workTimes: clinic.workTimes!),
                      ],
                    ),
                  ),
                  verticalSpace(10),
                  Divider(
                    color: Theme.of(context).dividerColor,
                    indent: AppPreferances.screenWidth(context) / 5.5,
                    endIndent: AppPreferances.screenWidth(context) / 5.5,
                  ),
                  verticalSpace(10),
                  ReviewList(
                    doctorId: clinic.doctor!.id!,
                  )
                ],
              ),
            ));
      },
    );
  }
}
// CustomScrollView(
//               slivers: [
//                 SliverAppBar(
//                   systemOverlayStyle: SystemUiOverlayStyle(
//                     statusBarColor: Colors.transparent,
//                   ),
//                   title: Text(
//                     'doctorProfile.doctorProfile'.tr(),
//                     style: Theme.of(context).textTheme.titleSmall,
//                   ),
//                   flexibleSpace: Container(
//                     height: 350,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.mainColor.withAlpha(220),
//                           AppColors.mainColor.withAlpha(130)
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(40),
//                         bottomRight: Radius.circular(40),
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(35),
//                                 child: CachedNetworkImage(
//                                     height: 155,
//                                     width: 155,
//                                     fit: BoxFit.fill,
//                                     imageUrl: doctor.doctor!.image!),
//                               ),
//                               horizontalSpace(10),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Column(
//                                         children: [
//                                           Icon(
//                                             Icons.group,
//                                             color: AppColors.darkBlue,
//                                             size: 30,
//                                           ),
//                                           verticalSpace(5),
//                                           Text('500',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .labelLarge!
//                                                   .copyWith(
//                                                     fontSize: 20,
//                                                   )),
//                                           verticalSpace(5),
//                                           Text('doctorProfile.patients'.tr(),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .labelMedium!)
//                                         ],
//                                       ),
//                                       horizontalSpace(50),
//                                       Column(
//                                         children: [
//                                           Icon(
//                                             Icons.star_rate,
//                                             color: AppColors.darkBlue,
//                                             size: 30,
//                                           ),
//                                           verticalSpace(5),
//                                           Text(
//                                               Format.formatNumber(
//                                                   doctor.rate, context),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .labelLarge!
//                                                   .copyWith(
//                                                     fontSize: 20,
//                                                   )),
//                                           verticalSpace(5),
//                                           Text('doctorProfile.rating'.tr(),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .labelMedium!)
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                   verticalSpace(10),
//                                   Row(
//                                     children: [
//                                       Column(
//                                         children: [
//                                           Icon(
//                                             Icons.reviews,
//                                             color: AppColors.darkBlue,
//                                             size: 30,
//                                           ),
//                                           verticalSpace(5),
//                                           Text(
//                                               Format.formatNumber(
//                                                   doctor.rateCount, context),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .labelLarge!
//                                                   .copyWith(
//                                                     fontSize: 20,
//                                                   )),
//                                           verticalSpace(5),
//                                           Text('doctorProfile.reviews'.tr(),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .labelMedium!)
//                                         ],
//                                       ),
//                                       horizontalSpace(50),
//                                       Column(
//                                         children: [
//                                           Icon(
//                                             Icons.medical_information,
//                                             color: AppColors.darkBlue,
//                                             size: 30,
//                                           ),
//                                           verticalSpace(5),
//                                           Text('+10',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .labelLarge!
//                                                   .copyWith(
//                                                     fontSize: 20,
//                                                   )),
//                                           verticalSpace(5),
//                                           Text('doctorProfile.experince'.tr(),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .labelMedium!)
//                                         ],
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                           verticalSpace(20),
//                           Text(
//                             '${'appointments.dr'.tr()} ${LanguageChecker.isArabic(context) ? doctor.doctor!.firstNameAr : doctor.doctor!.firstName} ${LanguageChecker.isArabic(context) ? doctor.doctor!.lastNameAr : doctor.doctor!.lastName}',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyLarge!
//                                 .copyWith(color: Colors.white),
//                           ),
//                           verticalSpace(5),
//                           Text(
//                             'specialities.${doctor.doctor!.specialty}'.tr(),
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodySmall!
//                                 .copyWith(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   expandedHeight: 300,
//                 ),
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         verticalSpace(10),
//                         Align(
//                           alignment: Alignment.center,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.location_on,
//                                 color: AppColors.mainColor,
//                                 size: 20,
//                               ),
//                               horizontalSpace(5),
//                               Text(
//                                 '${doctor.government}, ${doctor.city}, ${doctor.street}',
//                                 style: Theme.of(context).textTheme.labelMedium,
//                               ),
//                             ],
//                           ),
//                         ),
//                         verticalSpace(10),
//                         Divider(),
//                         verticalSpace(10),
//                         Text(
//                           'doctorProfile.about'.tr(),
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                         verticalSpace(10),
//                         Text(
//                           LanguageChecker.isArabic(context)
//                               ? doctor.doctorInfo!.aboutAr!
//                               : doctor.doctorInfo!.about!,
//                           // 'Dr. John Doe is a doctor who specializes in brain and nervous system disorders. He has been in practice for over 20 years and has been recognized for his expertise in treating patients with neurological disorders. He is a highly respected and respected doctor in the community.',
//                           style:
//                               Theme.of(context).textTheme.bodySmall!.copyWith(
//                                     height: 1.5,
//                                     color: AppColors.lightBlue,
//                                   ),
//                         ),
//                         verticalSpace(20),
//                         Text(
//                           'doctorProfile.workingTime'.tr(),
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                         verticalSpace(10),
//                         ...List.generate(
//                           doctor.workTimes!.workTimes!.length,
//                           (index) => Text(
//                             '${doctor.workTimes!.workTimes![index].day} From ${doctor.workTimes!.workTimes![index].start!.hour.toString().padLeft(2, '0')} : ${doctor.workTimes!.workTimes![index].start!.minute.toString().padLeft(2, '0')} To ${doctor.workTimes!.workTimes![index].end!.hour.toString().padLeft(2, '0')} : ${doctor.workTimes!.workTimes![index].end!.minute.toString().padLeft(2, '0')}',
//                             style:
//                                 Theme.of(context).textTheme.bodySmall!.copyWith(
//                                       height: 1.5,
//                                       color: AppColors.lightBlue,
//                                     ),
//                           ),
//                         ),
//                         verticalSpace(20),
//                         Row(
//                           children: [
//                             Text(
//                               'doctorProfile.reviews'.tr(),
//                               style: Theme.of(context).textTheme.bodyLarge,
//                             ),
//                             Spacer(),
//                             GestureDetector(
//                               onTap: () {
//                                 context.pushNamed(AppRoutes.reviews);
//                               },
//                               child: Text(
//                                 'doctorProfile.seeAll'.tr(),
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodySmall!
//                                     .copyWith(
//                                       height: 1.5,
//                                       color: AppColors.secondaryColor,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         verticalSpace(10),
//                         ReviewList()
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ));
