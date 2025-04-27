import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/features/home/logic/main_cubit.dart';
import 'package:medical_system/features/home/ui/widgets/home_header_item.dart';
import 'package:medical_system/features/home/ui/widgets/nearest_doctors/widgets/nearest_doctors_item.dart';
import 'package:medical_system/features/home/ui/widgets/nearest_doctors/widgets/nearest_doctors_loading.dart';

class NearestDoctors extends StatelessWidget {
  const NearestDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      var mainCubit = context.watch<MainCubit>();
      final doctors = mainCubit.doctors;
      if (state is MainLoading || state is PersonalInfoSuccess) {
        return NearestDoctorsLoading();
      } else {
        if (doctors.doctors == null || doctors.doctors!.isEmpty) {
          return const SizedBox();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeaderItem(
                  onPress: () {}, title: 'home.topRatedDoctors'.tr()),
              verticalSpace(10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: doctors.doctors!.length,
                  itemBuilder: (context, index) {
                    return NearestDoctorsItem(doctor: doctors.doctors![index]);
                  },
                ),
              )
            ],
          );
        }
      }
    });
  }
}
// OpenContainer(
//                 openBuilder: (BuildContext context, VoidCallback _) {
//                   return DoctorProfile();
//                 },
//                 tappable: true,
//                 transitionType: ContainerTransitionType.fade,
//                 closedShape: const RoundedRectangleBorder(),
//                 closedElevation: 0.0,
//                 closedBuilder: (BuildContext _, VoidCallback openContainer) {
//                   return Stack(
//                     alignment: Alignment.center,
//                     clipBehavior: Clip.none,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(
//                             left: LanguageChecker.isArabic(context) ? 0 : 60,
//                             right: LanguageChecker.isArabic(context)
//                                 ? index == 0
//                                     ? 10
//                                     : 60
//                                 : 0),
//                         padding: const EdgeInsets.only(left: 60, right: 10),
//                         width: Responsive.isTablet(context)
//                             ? Responsive.appWidth(context) / 2.2
//                             : Responsive.appWidth(context) / 1.5,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(35),
//                           color: Theme.of(context).colorScheme.primary,
//                           border: Border.all(
//                             color: AppColors.mainColor,
//                           ),
//                         ),
//                         child: Column(
//                           textDirection: ui.TextDirection.ltr,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Dr. John Doe',
//                               style: Theme.of(context).textTheme.bodyLarge,
//                             ),
//                             Text(
//                               'Brain and Nerves doctor',
//                               style: Theme.of(context).textTheme.labelMedium,
//                             ),
//                             verticalSpace(5),
//                             Row(
//                               textDirection: ui.TextDirection.ltr,
//                               children: [
//                                 Row(
//                                   textDirection: ui.TextDirection.ltr,
//                                   children: [
//                                     Icon(
//                                       Icons.star,
//                                       color: AppColors.mainColor,
//                                       size: 20,
//                                     ),
//                                     horizontalSpace(5),
//                                     Text('4.5',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodySmall!),
//                                     horizontalSpace(5),
//                                     Text('(200)',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodySmall!),
//                                   ],
//                                 ),
//                                 Spacer(),
//                                 Icon(
//                                   Icons.bookmark,
//                                   color: AppColors.mainColor,
//                                 )
//                               ],
//                             ),
//                             verticalSpace(10),
//                             Container(
//                               width: 100,
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 3),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: AppColors.mainColor,
//                               ),
//                               child: Center(
//                                 child: Text('home.bookNow'.tr(),
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodySmall!
//                                         .copyWith(color: Colors.white)),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       Positioned(
//                         left: -50,
//                         child: Container(
//                           margin: EdgeInsets.only(
//                               left: LanguageChecker.isArabic(context) ? 0 : 60,
//                               right:
//                                   LanguageChecker.isArabic(context) ? 10 : 0),
//                           height: 110,
//                           width: 100,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               color: Theme.of(context).colorScheme.primary,
//                               border: Border.all(
//                                 color: AppColors.mainColor,
//                               )),
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(50),
//                               child: Image(
//                                 image: AssetImage('assets/images/doctor.png'),
//                                 fit: BoxFit.fill,
//                               )),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               );
