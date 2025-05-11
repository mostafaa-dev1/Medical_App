import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/regex.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/core/widgets/overlay_loading.dart';
import 'package:medical_system/features/login/logic/login_cubit.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          context.loaderOverlay.hide();
          showCustomDialog(
              context: context,
              message: state.message.tr(),
              dialogType: DialogType.error,
              title: 'dialog.oops'.tr(),
              confirmButtonName: 'dialog.ok'.tr(),
              onConfirmPressed: () => context.pop());
        }
        if (state is LoginSuccess) {
          context.loaderOverlay.hide();
          context.pushNamedAndRemoveUntil(AppRoutes.mainScreen,
              arguments: state.user);
        }
        if (state is LoginLoading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        var cubit = context.read<LoginCubit>();

        return Scaffold(
            body: LoaderOverlay(
          overlayWidgetBuilder: (context2) => OverlayLoading(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppPreferances.padding),
              child: SingleChildScrollView(
                child: Center(
                    child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/logo.svg',
                        height: MediaQuery.of(context).size.width / 2.5,
                      ),
                      verticalSpace(MediaQuery.of(context).size.height / 10),
                      Text('Auth.loginToAccount'.tr(),
                          style: Theme.of(context).textTheme.headlineSmall!),
                      verticalSpace(50),
                      CustomTextFrom(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Auth.emailRequired'.tr();
                          }
                          if (!AppRegex.isEmailValid(value)) {
                            return 'Auth.invalidEmail'.tr();
                          }
                          return null;
                        },
                        hintText: 'Auth.email'.tr(),
                        controller: cubit.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      verticalSpace(20),
                      CustomTextFrom(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Auth.passwordRequired'.tr();
                            }
                            if (value.length < 8) {
                              return 'Auth.invalidPassword'.tr();
                            }
                            return null;
                          },
                          hintText: 'Auth.password'.tr(),
                          controller: cubit.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.isPasswordObscure,
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.obscurePassword();
                            },
                            icon: Icon(
                              cubit.isPasswordObscure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 18,
                            ),
                          )),
                      verticalSpace(10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            context.pushNamed(AppRoutes.forgetPassword,
                                arguments: cubit.emailController.text);
                          },
                          child: Text(
                            'Auth.forgotPassword'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: AppColors.secondaryColor,
                                ),
                          ),
                        ),
                      ),
                      verticalSpace(20),
                      CustomButton(
                          isLoading: state is LoginLoading,
                          buttonName: 'Auth.login'.tr(),
                          onPressed: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.login();
                            }
                          },
                          width: MediaQuery.of(context).size.width / 1.5,
                          paddingVirtical: 10,
                          paddingHorizental: 20),
                      verticalSpace(20),
                      Text(
                        'Auth.or'.tr(),
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: AppColors.lightBlue,
                                ),
                      ),
                      verticalSpace(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.loginWithFacebook();
                            },
                            child: Container(
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
                          ),
                          horizontalSpace(50),
                          GestureDetector(
                            onTap: () {
                              cubit.loginWithGoogle();
                            },
                            child: Container(
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
                          ),
                        ],
                      ),
                      verticalSpace(10),
                      Text.rich(TextSpan(
                        text: 'Auth.dontHaveAccount'.tr(),
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: AppColors.lightBlue,
                                ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context
                                    .pushReplacementNamed(AppRoutes.register);
                              },
                            text: 'Auth.register'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: AppColors.secondaryColor,
                                ),
                          ),
                        ],
                      )),
                    ],
                  ),
                )),
              ),
            ),
          ),
        ));
      },
    );
  }
}
