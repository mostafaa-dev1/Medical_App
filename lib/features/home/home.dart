import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/features/home/widgets/categories.dart';
import 'package:medical_system/features/home/widgets/doctor_spciality.dart';
import 'package:medical_system/features/home/widgets/offers.dart';
import 'package:medical_system/features/home/widgets/top_rated_doctors.dart';
import 'package:medical_system/features/home/widgets/upcoming_visits.dart';

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
                            context.pushNamed(AppRoutes.language);
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: const AssetImage(
                              'assets/images/doctor.png',
                            ),
                          ),
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          'assets/images/logo.svg',
                          height: 30,
                          width: 30,
                        ),
                      ],
                    ),
                    verticalSpace(20),
                    SizedBox(
                      height: 40,
                      width: MediaQuery.sizeOf(context).width / 1.2,
                      child: CustomTextFrom(
                        hintText: 'home.search'.tr(),
                        controller: TextEditingController(),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(20),
              Categories(),
              verticalSpace(20),
              UpcomingVisits(),
              verticalSpace(10),
              DoctorSpciality(),
              verticalSpace(15),
              Offers(),
              verticalSpace(10),
              TopRatedDoctors()
            ],
          ),
        ),
      ),
    );
  }
}
