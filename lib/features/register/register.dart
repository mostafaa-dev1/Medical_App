import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              height: MediaQuery.of(context).size.width / 2.5,
            ),
            Spacer(),
            Text(
              'Auth.createAccount'.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            verticalSpace(50),
            CustomTextFrom(
                hintText: 'Auth.email'.tr(),
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress),
            verticalSpace(20),
            CustomTextFrom(
                hintText: 'Auth.password'.tr(),
                controller: TextEditingController(),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true),
            verticalSpace(20),
            CustomButton(
                buttonName: 'Auth.register'.tr(),
                onPressed: () {
                  context.pushNamed(AppRoutes.personalInfo);
                },
                width: MediaQuery.of(context).size.width / 1.5,
                paddingVirtical: 10,
                paddingHorizental: 20),
            verticalSpace(20),
            Text(
              'Auth.orRegister'.tr(),
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColors.lightBlue,
                  ),
            ),
            verticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey[300]!,
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/images/facebook.svg',
                    height: 30,
                    width: 30,
                  ),
                ),
                horizontalSpace(50),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey[300]!,
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/images/google.svg',
                    height: 30,
                    width: 30,
                  ),
                ),
              ],
            ),
            verticalSpace(20),
            Text.rich(TextSpan(
              text: 'Auth.alreadyHaveAccount'.tr(),
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColors.lightBlue,
                  ),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.pushNamed(AppRoutes.login);
                    },
                  text: 'Auth.login'.tr(),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                ),
              ],
            )),
            Spacer(),
          ],
        )),
      ),
    ));
  }
}
