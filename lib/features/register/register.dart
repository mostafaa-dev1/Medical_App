import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/regex.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/register/logic/register_cubit.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterError) {
          showDialog(
              context: context,
              builder: (context) => CustomDialog(
                    isError: true,
                    message: state.message.tr(),
                  ));
        } else if (state is RegisterSuccess) {
          context.pushReplacementNamed(AppRoutes.personalInfo,
              arguments: context.read<RegisterCubit>().user);
        }
      },
      builder: (context, state) {
        var cubit = context.read<RegisterCubit>();
        return Scaffold(
            body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                    Text(
                      'Auth.createAccount'.tr(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
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
                        keyboardType: TextInputType.emailAddress),
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
                      ),
                    ),
                    verticalSpace(50),
                    CustomButton(
                      buttonName: 'Auth.register'.tr(),
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.register();
                        }
                      },
                      width: MediaQuery.of(context).size.width / 1.5,
                      paddingVirtical: 10,
                      paddingHorizental: 20,
                      isLoading: state is RegisterLoading,
                    ),
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
                        GestureDetector(
                          onTap: () {
                            cubit.signUpWithFacebook();
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
                            cubit.signUpWithGoogle();
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
                              context.pushReplacementNamed(AppRoutes.login);
                            },
                          text: 'Auth.login'.tr(),
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
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
        ));
      },
    );
  }
}
