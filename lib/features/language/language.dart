import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/logic/app_cubit.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/language/widgets/language_select_button.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        int languageIndex = context.read<AppCubit>().languageIndex;
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppPreferances.padding),
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'language.welcomeTo'.tr(),
                          style: Theme.of(context).textTheme.headlineSmall!,
                          children: [
                            TextSpan(
                              text: ' Delma',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: AppColors.secondaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(50),
                      SvgPicture.asset(
                        'assets/images/logo.svg',
                        height: MediaQuery.of(context).size.width / 2.5,
                      ),
                      verticalSpace(50),
                      Text('language.selectLanguage'.tr(),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 20.sp,
                                  )),
                      verticalSpace(50),
                      LanguageButton(
                        onPressed: () {
                          context
                              .read<AppCubit>()
                              .toggleLanguage(context, 'en');
                        },
                        languageIndex: languageIndex,
                        title: 'English',
                        buttonIndex: 0,
                      ),
                      verticalSpace(20),
                      LanguageButton(
                        onPressed: () {
                          context
                              .read<AppCubit>()
                              .toggleLanguage(context, 'ar');
                        },
                        languageIndex: languageIndex,
                        title: 'عربي',
                        buttonIndex: 1,
                      ),
                      verticalSpace(50),
                      CustomButton(
                          buttonName: 'language.next'.tr(),
                          onPressed: () {
                            context.pushNamed(AppRoutes.onboarding);
                          },
                          width: MediaQuery.of(context).size.width / 1.5,
                          paddingVirtical: 10,
                          paddingHorizental: 20),
                      // CustomButton(
                      //     buttonName: 'Change Theme'.tr(),
                      //     onPressed: () {
                      //       context.read<AppCubit>().changeThemeMode();
                      //     },
                      //     width: MediaQuery.of(context).size.width / 1.5,
                      //     paddingVirtical: 10,
                      //     paddingHorizental: 20)
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
