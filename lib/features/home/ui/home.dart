import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/home/logic/main_cubit.dart';
import 'package:medical_system/features/home/ui/widgets/categories/categories.dart';
import 'package:medical_system/features/home/ui/widgets/doctor_speciality/doctor_spciality.dart';
import 'package:medical_system/features/home/ui/widgets/home_banner.dart';
import 'package:medical_system/features/home/ui/widgets/offers/ui/offers.dart';
import 'package:medical_system/features/home/ui/widgets/services/ui/services.dart';
import 'package:medical_system/features/home/ui/widgets/upcoming_visits/upcoming_visits.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // Future<void> getUserLocation() async {
  //   try {
  //     // Check and request location permissions
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied ||
  //         permission == LocationPermission.deniedForever) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission != LocationPermission.whileInUse &&
  //           permission != LocationPermission.always) {
  //         print('Location permissions are denied.');
  //         return;
  //       }
  //     }

  //     // Check if location services are enabled
  //     if (!await Geolocator.isLocationServiceEnabled()) {
  //       print('Location services are disabled.');
  //       return;
  //     }

  //     // Get current position using platform-specific settings
  //     Position position = await Geolocator.getCurrentPosition(
  //       locationSettings: LocationSettings(
  //         accuracy: LocationAccuracy.high,
  //         // Adjust accuracy as needed
  //       ),
  //     );

  //     // Print coordinates
  //     print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

  //     // Get address from coordinates
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       position.latitude,
  //       position.longitude,
  //     );

  //     if (placemarks.isNotEmpty) {
  //       Placemark place = placemarks[0];
  //       print('City: ${place.locality}');
  //       print('Current Place: ${place.name}');
  //       print('Country: ${place.country}');
  //       print(
  //           'Full Address: ${place.street}, ${place.locality}, ${place.country}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is MainFailure) {
          showCustomDialog(
            context: context,
            message: state.error.tr(),
            title: 'dialog.oops'.tr(),
            onConfirmPressed: () => context.pop(),
            confirmButtonName: 'dialog.ok'.tr(),
            dialogType: DialogType.error,
          );
        } else if (state is LocationError &&
            state.error == 'dialog.locationDisabled') {
          showCustomDialog(
            context: context,
            message: state.error.tr(),
            title: 'dialog.oops'.tr(),
            onConfirmPressed: () {
              context.read<MainCubit>().openLocationSettings();
              context.pop();
            },
            confirmButtonName: 'dialog.enableLocation'.tr(),
            dialogType: DialogType.warning,
            withTowButtons: true,
            cancelButtonName: 'dialog.cancel'.tr(),
          );
        } else if (state is NoInternetConnection) {
          showCustomDialog(
            context: context,
            message: state.error.tr(),
            title: 'dialog.oops'.tr(),
            onConfirmPressed: () {},
            confirmButtonName: 'dialog.ok'.tr(),
            dialogType: DialogType.warning,
          );
        }
      },
      builder: (context, state) {
        var cubit = context.read<MainCubit>();
        UserModel user = cubit.user;
        return Scaffold(
          floatingActionButton: GestureDetector(
            onTap: () => context.pushNamed(AppRoutes.aiChat, arguments: {
              'user': user,
              'context': context,
            }),
            child: Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary,
                // boxShadow: [
                //   BoxShadow(
                //     color: Theme.of(context).colorScheme.shadow,
                //     spreadRadius: 5,
                //     blurRadius: 7,
                //     offset: const Offset(0, 3),
                //   ),
                // ]
              ),
              child: Icon(
                IconBroken.Chat,
                color: AppColors.mainColor,
                size: 30,
              ),
            ),
          ),
          body: SafeArea(
            child: RefreshIndicator(
              color: Colors.white,
              backgroundColor: AppColors.secondaryColor,
              onRefresh: () {
                if (state is! MainLoading) {
                  return cubit.init();
                } else {
                  return Future.value();
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppPreferances.padding),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed(AppRoutes.profile,
                                      arguments: user);
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      user.image != null && user.image != ''
                                          ? NetworkImage(user.image!)
                                          : const AssetImage(
                                              'assets/images/user.png',
                                            ),
                                ),
                              ),
                              horizontalSpace(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${'home.goodMorning'.tr()} 👋',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    '${user.firstName} ${user.lastName}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed(AppRoutes.notifications);
                                },
                                child: Badge(
                                  backgroundColor: AppColors.lightRed,
                                  label: Text('1'),
                                  child: Icon(
                                    IconBroken.Notification,
                                    size: 25,
                                  ),
                                ),
                              )
                            ],
                          ),
                          verticalSpace(30),
                          GestureDetector(
                            onTap: () =>
                                context.pushNamed(AppRoutes.search, arguments: {
                              'user': user,
                              'speciality': null,
                              'withSearch': true,
                            }),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        AppColors.secondaryColor.withAlpha(20)),
                                height: 40,
                                width: MediaQuery.sizeOf(context).width / 1.2,
                                child: Text(
                                  'home.search'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        color: AppColors.mainColor,
                                      ),
                                )),
                          )
                          // OpenContainer(
                          //     transitionType: ContainerTransitionType.fade,
                          //     closedShape: const RoundedRectangleBorder(),
                          //     closedElevation: 0.0,
                          //     openBuilder: (context, openContainer) => Search(),
                          //     closedBuilder: (context, openContainer) =>
                          //         Container(
                          //             padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //               border: Border.all(
                          //                   color: AppColors.mainColor),
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //             height: 40,
                          //             width:
                          //                 MediaQuery.sizeOf(context).width / 1.2,
                          //             child: Text(
                          //               'home.search'.tr(),
                          //               style: Theme.of(context)
                          //                   .textTheme
                          //                   .labelMedium!
                          //                   .copyWith(
                          //                     color: Colors.grey,
                          //                   ),
                          //             ))),
                        ],
                      ),
                    ),
                    verticalSpace(15),
                    Categories(),
                    verticalSpace(15),
                    HomeBanner(
                      user: user,
                      type: cubit.categoryIndex == 0 ? 'Doctor' : 'Lab',
                    ),
                    verticalSpace(25),
                    UpcomingVisits(),
                    verticalSpace(15),
                    DoctorSpciality(
                      user: user,
                      type: cubit.categoryIndex == 0 ? 'Doctor' : 'Lab',
                    ),
                    verticalSpace(20),
                    Services(
                      userId: user.id,
                    ),

                    verticalSpace(20),
                    Offers(),
                    // verticalSpace(15),
                    // NearestDoctors(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
