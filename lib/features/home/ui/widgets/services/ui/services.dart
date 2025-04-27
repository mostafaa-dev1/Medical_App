import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/features/home/ui/widgets/home_header_item.dart';
import 'package:medical_system/features/home/ui/widgets/services/ui/widgets/services_item.dart';

class Services extends StatelessWidget {
  const Services({super.key, this.userId});
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeaderItem(onPress: () {}, title: 'Services', isSeeAll: false),
        verticalSpace(20),
        ServicesItem(
          onTap: () {
            context.pushNamed(AppRoutes.askQuestion, arguments: userId);
          },
          title: 'home.askMedicalQuestion'.tr(),
          description: 'home.askDetails'.tr(),
          buttonName: 'home.ask'.tr(),
          image: 'assets/images/chat.svg',
        ),
        verticalSpace(10),
        ServicesItem(
          onTap: () {
            context.pushNamed(AppRoutes.heartRate);
          },
          title: 'home.heartRate'.tr(),
          description: 'home.heartRateDetails'.tr(),
          image: 'assets/images/heart_rate.svg',
          buttonName: 'home.measure'.tr(),
        ),
        verticalSpace(10),
        ServicesItem(
          image: 'assets/images/medicine.svg',
          onTap: () {
            context.pushNamed(AppRoutes.findMedicine, arguments: userId);
          },
          title: 'home.findMedicine'.tr(),
          description: 'home.findMedicineDetails'.tr(),
          buttonName: 'home.find'.tr(),
        ),
      ],
    );
  }
}
