import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/otp/logic/otp_cubit.dart';
import 'package:pinput/pinput.dart';

class Otp extends StatelessWidget {
  const Otp(
      {super.key,
      required this.email,
      required this.password,
      required this.justVerify});
  final String email;
  final String password;
  final bool justVerify;

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
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          context.pushReplacementNamed(AppRoutes.personalInfo,
              arguments: context.read<OtpCubit>().user);
        } else if (state is RegisterError) {
          showCustomDialog(
            context: context,
            message: state.errorMessage.tr(),
            title: 'dialog.oops',
            onConfirmPressed: () => context.pop(),
            confirmButtonName: 'dialog.ok'.tr(),
            dialogType: DialogType.error,
          );
        } else if (state is ForgetPasswordError) {
          showCustomDialog(
            context: context,
            message: state.errorMessage.tr(),
            title: 'dialog.oops',
            onConfirmPressed: () => context.pop(),
            confirmButtonName: 'dialog.ok'.tr(),
            dialogType: DialogType.error,
          );
        } else if (state is ForgetPasswordSuccess) {
          showCustomDialog(
            context: context,
            message: 'dialog.resetPasswordEmailSent'.tr(),
            title: 'dialog.success'.tr(),
            onConfirmPressed: () =>
                context.pushNamedAndRemoveUntil(AppRoutes.login),
            confirmButtonName: 'dialog.ok'.tr(),
            dialogType: DialogType.success,
          );
        } else if (state is OtpSendError) {
          showCustomDialog(
            context: context,
            message: state.errorMessage.tr(),
            title: 'dialog.oops'.tr(),
            onConfirmPressed: () => context.pop(),
            confirmButtonName: 'dialog.ok'.tr(),
            dialogType: DialogType.error,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Auth.verify'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppPreferances.padding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('Auth.verify'.tr(),
                  //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  //           color: AppColors.secondaryColor,
                  //         )),
                  // verticalSpace(5),
                  // Text('Auth.code'.tr(),
                  //     style: Theme.of(context).textTheme.bodySmall),
                  // verticalSpace(20),
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
                                text: email,
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
                        // TimerCountdown(
                        //   endTime: DateTime.now().add(Duration(seconds: 60)),
                        // ),
                        // Text(counter.toString(),
                        //     style: Theme.of(context).textTheme.bodyMedium!),
                        // verticalSpace(20),
                        Pinput(
                          controller: context.read<OtpCubit>().otpController,
                          focusNode: FocusNode(),
                          defaultPinTheme: defaultPinTheme,
                          separatorBuilder: (index) => const SizedBox(width: 8),
                          errorText: 'Auth.pinIsIncorrect'.tr(),
                          errorTextStyle:
                              Theme.of(context).textTheme.labelLarge,
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            context.read<OtpCubit>().verifyOtp(
                                email: email,
                                password: password,
                                justVerify: justVerify);
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
                          isLoading: state is OtpVerifyLoading ||
                              state is RegisterLoading,
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
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.read<OtpCubit>().sendOtp(
                                      email: email); // your resend logic
                                },
                              text: 'Auth.resend'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.secondaryColor),
                            ),
                          ],
                        )),
                        verticalSpace(20),
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Row(
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
