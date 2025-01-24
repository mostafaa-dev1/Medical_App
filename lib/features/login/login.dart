import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/dialog.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPreferances.padding),
        child: SingleChildScrollView(
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/logo.svg',
                height: MediaQuery.of(context).size.width / 2.5,
              ),
              verticalSpace(100),
              Text('Auth.loginToAccount'.tr(),
                  style: Theme.of(context).textTheme.headlineSmall!),
              verticalSpace(50),
              CustomTextFrom(
                hintText: 'Auth.email'.tr(),
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
              ),
              verticalSpace(20),
              CustomTextFrom(
                  hintText: 'Auth.password'.tr(),
                  controller: TextEditingController(),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.visibility_off_outlined,
                    ),
                  )),
              verticalSpace(10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Auth.forgotPassword'.tr(),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                  ),
                ),
              ),
              verticalSpace(20),
              CustomButton(
                  buttonName: 'Auth.login'.tr(),
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        useRootNavigator: false,
                        context: context,
                        builder: (context) {
                          return CustonDialog();
                        });
                  },
                  width: MediaQuery.of(context).size.width / 1.5,
                  paddingVirtical: 10,
                  paddingHorizental: 20),
              verticalSpace(20),
              Text(
                'Auth.or'.tr(),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.lightBlue,
                    ),
              ),
              verticalSpace(10),
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
              verticalSpace(10),
              Text.rich(TextSpan(
                text: 'Auth.dontHaveAccount'.tr(),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.lightBlue,
                    ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.pushNamed(AppRoutes.register);
                      },
                    text: 'Auth.register'.tr(),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                  ),
                ],
              )),
            ],
          )),
        ),
      ),
    ));
  }
}
