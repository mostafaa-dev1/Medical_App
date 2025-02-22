import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';

class Otp extends StatelessWidget {
  const Otp({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: Theme.of(context).textTheme.bodyLarge!,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.mainColor),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPreferances.padding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Auth.verify'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.secondaryColor,
                        )),
                verticalSpace(5),
                Text('Auth.code'.tr(),
                    style: Theme.of(context).textTheme.bodySmall),
                verticalSpace(20),
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/otp.svg',
                        height: MediaQuery.of(context).size.width / 2,
                      ),
                      verticalSpace(30),
                      Text.rich(
                        TextSpan(
                          text: 'Auth.codeSent'.tr(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          children: [
                            TextSpan(
                              text: '********909',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: AppColors.secondaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(20),
                      Text('3:00',
                          style: Theme.of(context).textTheme.bodyMedium!),
                      verticalSpace(20),
                      Pinput(
                        controller: TextEditingController(),
                        focusNode: FocusNode(),
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        validator: (value) {
                          return 'Pin is incorrect';
                        },
                        errorText: 'auth.pinIsIncorrect'.tr(),
                        errorTextStyle: Theme.of(context).textTheme.labelLarge,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: AppColors.mainColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.mainColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                      verticalSpace(50),
                      CustomButton(
                        buttonName: 'Auth.continue'.tr(),
                        onPressed: () {},
                        width: MediaQuery.of(context).size.width / 1.5,
                        paddingVirtical: 10,
                        paddingHorizental: 20,
                      ),
                      verticalSpace(20),
                      Text.rich(TextSpan(
                        text: 'Auth.don\'tReceiveCode'.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            text: 'Auth.resend'.tr(),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.secondaryColor,
                                    ),
                          ),
                        ],
                      )),
                      verticalSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconBroken.Arrow___Left,
                            size: 20,
                          ),
                          horizontalSpace(5),
                          Text(
                            'Auth.backToLogin'.tr(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // TextButton(
        //   onPressed: () {
        //     focusNode.unfocus();
        //     formKey.currentState!.validate();
        //   },
        //   child: const Text('Validate'),
        // ),
      ),
    );
  }
}
