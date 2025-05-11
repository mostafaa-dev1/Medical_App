import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key, required this.email});
  final String email;

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Auth.forgetPassword'.tr(),
        style: Theme.of(context).textTheme.titleSmall,
      )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPreferances.padding),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('Auth.forgetPassword'.tr(),
                  //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  //           color: AppColors.secondaryColor,
                  //         )),
                  // verticalSpace(5),
                  // Text('Auth.noWorry'.tr(),
                  //     style: Theme.of(context).textTheme.bodySmall),
                  // verticalSpace(20),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/otp.svg',
                          height: MediaQuery.of(context).size.width / 2,
                        ),
                        verticalSpace(80),
                        CustomTextFrom(
                            hintText: 'Auth.email'.tr(),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Auth.emailRequired'.tr();
                              }
                              return null;
                            }),
                        verticalSpace(50),
                        CustomButton(
                          buttonName: 'Auth.submit'.tr(),
                          onPressed: () {
                            context.pushNamed(AppRoutes.otp, arguments: {
                              'email': _emailController.text.trim(),
                              'password': '',
                              'justVerify': true
                            });
                          },
                          width: MediaQuery.of(context).size.width / 1.5,
                          paddingVirtical: 10,
                          paddingHorizental: 20,
                        ),
                        verticalSpace(50),
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Arrow___Left,
                                size: 18,
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
        ),
      ),
    );
  }
}
