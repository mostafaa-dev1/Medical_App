import 'package:animations/animations.dart';
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
import 'package:medical_system/features/home/logic/home_cubit.dart';
import 'package:medical_system/features/home/widgets/categories.dart';
import 'package:medical_system/features/home/widgets/doctor_spciality.dart';
import 'package:medical_system/features/home/widgets/offers.dart';
import 'package:medical_system/features/home/widgets/top_rated_doctors.dart';
import 'package:medical_system/features/home/widgets/upcoming_visits.dart';
import 'package:medical_system/features/search/search.dart';

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
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        User user = cubit.user;
        return Scaffold(
          body: SafeArea(
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
                                backgroundImage: user.image != ''
                                    ? NetworkImage(user.image)
                                    : const AssetImage(
                                        'assets/images/doctor.png',
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
                                  user.name,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(
                              IconBroken.Notification,
                              size: 20,
                            )
                          ],
                        ),
                        verticalSpace(30),
                        OpenContainer(
                            transitionType: ContainerTransitionType.fade,
                            closedShape: const RoundedRectangleBorder(),
                            closedElevation: 0.0,
                            openBuilder: (context, openContainer) => Search(),
                            closedBuilder: (context, openContainer) =>
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.mainColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 40,
                                    width:
                                        MediaQuery.sizeOf(context).width / 1.2,
                                    child: Text(
                                      'home.search'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                            color: Colors.grey,
                                          ),
                                    ))),
                      ],
                    ),
                  ),
                  verticalSpace(25),
                  Categories(),
                  verticalSpace(25),
                  UpcomingVisits(),
                  verticalSpace(15),
                  DoctorSpciality(),
                  verticalSpace(20),
                  Offers(),
                  verticalSpace(15),
                  TopRatedDoctors(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
