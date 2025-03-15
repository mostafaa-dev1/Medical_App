import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/logic/app_cubit.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  // final List<IconData> icons = [
  //   IconBroken.Profile,
  //   IconBroken.Notification,
  //   IconBroken.Wallet,
  //   Icons.language,
  //   IconBroken.Show,
  //   IconBroken.Logout,
  //   Icons.help,
  //   IconBroken.User1
  // ];
  // final List<String> titles = [
  //   'profile.editProfile',
  //   'profile.notifications',
  //   'profile.payment',
  //   'profile.language',
  //   'profile.themeMode',
  //   'profile.logout',
  //   'profile.helpCenter',
  //   'profile.contactUs'
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AppLogout) {
          context.pushNamedAndRemoveUntil(AppRoutes.login);
        }
      },
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width / 1.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: title == 'profile.logout' ? Colors.red : null,
                  ),
                  horizontalSpace(10),
                  Text(title.tr(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color:
                              title == 'profile.logout' ? Colors.red : null)),
                  const Spacer(),
                  title == 'profile.themeMode'
                      ? AnimatedToggleSwitch.rolling(
                          borderWidth: .5,
                          active: true,
                          current: context.read<AppCubit>().themeIndex,
                          values: [0, 1],
                          height: 30,
                          onChanged: (value) {
                            context.read<AppCubit>().changeThemeMode(value);
                          },
                          iconBuilder: (value, foreground) {
                            return Icon(
                              value == 0 ? Icons.light_mode : Icons.dark_mode,
                              color: foreground ? Colors.white : Colors.grey,
                            );
                          },
                          style: ToggleStyle(
                              backgroundColor: Colors.grey[200],
                              indicatorGradient: LinearGradient(
                                colors: [
                                  AppColors.mainColor,
                                  AppColors.secondaryColor
                                ],
                              )),
                        )
                      : title != 'profile.logout'
                          ? Icon(LanguageChecker.isArabic(context)
                              ? IconBroken.Arrow___Left_2
                              : IconBroken.Arrow___Right_2)
                          : const SizedBox(),
                ],
              ),
            ),
          ),
          // ...List.generate(
          //   icons.length,
          //   (index) => Column(
          //     children: [
          //       GestureDetector(
          //         onTap: () {
          //           if (titles[index] == 'profile.logout') {
          //             context.read<AppCubit>().logout();
          //           } else if (titles[index] == 'profile.language') {
          //             context.pushNamed(AppRoutes.selectLanguage);
          //           }
          //         },
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(
          //               icons[index],
          //               color: titles[index] == 'profile.logout'
          //                   ? Colors.red
          //                   : null,
          //             ),
          //             horizontalSpace(10),
          //             Text(titles[index].tr(),
          //                 style: Theme.of(context)
          //                     .textTheme
          //                     .bodyMedium!
          //                     .copyWith(
          //                         color: titles[index] == 'profile.logout'
          //                             ? Colors.red
          //                             : null)),
          //             const Spacer(),
          //             titles[index] == 'profile.themeMode'
          //                 ? AnimatedToggleSwitch.rolling(
          //                     borderWidth: .5,
          //                     active: true,
          //                     current: context.read<AppCubit>().themeIndex,
          //                     values: [0, 1],
          //                     height: 30,
          //                     onChanged: (value) {
          //                       context.read<AppCubit>().changeThemeMode(value);
          //                     },
          //                     iconBuilder: (value, foreground) {
          //                       return Icon(
          //                         value == 0
          //                             ? Icons.light_mode
          //                             : Icons.dark_mode,
          //                         color:
          //                             foreground ? Colors.white : Colors.grey,
          //                       );
          //                     },
          //                     style: ToggleStyle(
          //                         backgroundColor: Colors.grey[200],
          //                         indicatorGradient: LinearGradient(
          //                           colors: [
          //                             AppColors.mainColor,
          //                             AppColors.secondaryColor
          //                           ],
          //                         )),
          //                   )
          //                 : titles[index] != 'profile.logout'
          //                     ? Icon(LanguageChecker.isArabic(context)
          //                         ? IconBroken.Arrow___Left_2
          //                         : IconBroken.Arrow___Right_2)
          //                     : const SizedBox(),
          //           ],
          //         ),
          //       ),

          // ],
          //),
          //),
        ],
      ),
    );
  }
}
