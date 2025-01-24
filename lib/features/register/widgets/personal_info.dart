import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: context.locale == Locale('ar')
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Text(
                  'Auth.createAccount'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              verticalSpace(30),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    child: SvgPicture.asset(
                      'assets/images/user.svg',
                      height: MediaQuery.of(context).size.width / 2.5,
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.mainColor,
                        child: Icon(
                          IconBroken.Camera,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
              verticalSpace(50),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFrom(
                        hintText: 'Auth.firstName'.tr(),
                        controller: TextEditingController(),
                        keyboardType: TextInputType.name),
                  ),
                  horizontalSpace(10),
                  Expanded(
                    child: CustomTextFrom(
                        hintText: 'Auth.lastName'.tr(),
                        controller: TextEditingController(),
                        keyboardType: TextInputType.name),
                  ),
                ],
              ),
              verticalSpace(20),
              CustomTextFrom(
                  hintText: 'Auth.phone'.tr(),
                  controller: TextEditingController(),
                  keyboardType: TextInputType.phone),
              verticalSpace(20),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFrom(
                        hintText: 'Auth.day'.tr(),
                        controller: TextEditingController(),
                        keyboardType: TextInputType.datetime),
                  ),
                  horizontalSpace(10),
                  Expanded(
                    child: CustomTextFrom(
                        hintText: 'Auth.month'.tr(),
                        controller: TextEditingController(),
                        keyboardType: TextInputType.datetime),
                  ),
                  horizontalSpace(10),
                  Expanded(
                    child: CustomTextFrom(
                        hintText: 'Auth.year'.tr(),
                        controller: TextEditingController(),
                        keyboardType: TextInputType.datetime),
                  ),
                ],
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      buttonName: 'Auth.male'.tr(),
                      onPressed: () {},
                      width: MediaQuery.of(context).size.width / 2.5,
                      paddingVirtical: 10,
                      paddingHorizental: 10),
                  horizontalSpace(10),
                  CustomButton(
                      buttonName: 'Auth.female'.tr(),
                      backgroundColor: AppColors.mainColor,
                      buttonColor: AppColors.mainColor,
                      withBorderSide: true,
                      onPressed: () {},
                      width: MediaQuery.of(context).size.width / 2.5,
                      paddingVirtical: 10,
                      paddingHorizental: 10),
                ],
              ),
              verticalSpace(80),
              CustomButton(
                  buttonName: 'Auth.next'.tr(),
                  onPressed: () {
                    context.pushNamed(AppRoutes.otp);
                  },
                  width: MediaQuery.of(context).size.width / 1.5,
                  paddingVirtical: 10,
                  paddingHorizental: 10),
            ],
          ),
        ),
      ),
    );
  }
}
