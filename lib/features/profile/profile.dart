import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/logic/app_cubit.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/profile/widgets/profile_buttons.dart';
import 'package:medical_system/features/profile/widgets/profile_photo.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    required this.user,
  });
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    // print(user.toJson());
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AppLogoutSuccess) {
          context.pushNamedAndRemoveUntil(AppRoutes.login);
        } else if (state is AppLogoutLoading) {
          context.loaderOverlay.show();
        } else if (state is AppLogoutError) {
          context.loaderOverlay.hide();
          showDialog(
              context: context,
              builder: (context) => CustomDialog(
                    dialogType: DialogType.error,
                    message: state.message,
                    onConfirmPressed: () => context.pop(),
                    confirmButtonName: 'dialog.ok'.tr(),
                    title: 'dialog.oops'.tr(),
                  ));
        }
      },
      child: Scaffold(
          appBar: AppBar(
            leadingWidth: 30,
            leading: Padding(
              padding: EdgeInsets.only(
                  left: LanguageChecker.isArabic(context) ? 0 : 10,
                  right: LanguageChecker.isArabic(context) ? 10 : 0),
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                width: 20,
                height: 15,
              ),
            ),
            title: Text('profile.profile'.tr(),
                style: Theme.of(context).textTheme.titleSmall),
          ),
          body: LoaderOverlay(
            child: Padding(
              padding: const EdgeInsets.all(AppPreferances.padding),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfilePhoto(
                          withEdit: false,
                          image: user.image!,
                        ),
                        verticalSpace(20),
                        Text('${user.firstName}${user.lastName}',
                            style: Theme.of(context).textTheme.titleSmall),
                        verticalSpace(5),
                        Text(user.phone!,
                            style: Theme.of(context).textTheme.labelLarge),
                        // verticalSpace(40),
                        // Divider(
                        //   color: Theme.of(context).dividerColor,
                        //   indent: AppPreferances.screenWidth(context) / 5.5,
                        //   endIndent: AppPreferances.screenWidth(context) / 5.5,
                        // ),
                        verticalSpace(20),
                        ProfileButton(
                          title: 'profile.editProfile',
                          icon: IconBroken.Profile,
                          onTap: () => context.pushNamed(AppRoutes.editProfile,
                              arguments: user),
                        ),
                        // verticalSpace(10),
                        // ProfileButton(
                        //     title: 'profile.notifications',
                        //     icon: IconBroken.Notification,
                        //     onTap: () {}),
                        // verticalSpace(20),
                        // ProfileButton(
                        //   title: 'profile.payment',
                        //   icon: IconBroken.Wallet,
                        //   onTap: () {},
                        // ),
                        verticalSpace(10),
                        ProfileButton(
                            title: 'profile.language',
                            icon: Icons.language,
                            onTap: () {
                              context.pushNamed(AppRoutes.selectLanguage);
                            }),
                        verticalSpace(10),
                        ProfileButton(
                          title: 'profile.themeMode',
                          icon: IconBroken.Show,
                          onTap: () {},
                        ),
                        verticalSpace(10),
                        ProfileButton(
                            title: 'profile.logout',
                            icon: IconBroken.Logout,
                            onTap: () {
                              showCustomDialog(
                                withTowButtons: true,
                                context: context,
                                message: 'dialog.logoutMessage'.tr(),
                                title: 'dialog.logout'.tr(),
                                onConfirmPressed: () {
                                  context.read<AppCubit>().logout();
                                },
                                confirmButtonName: 'dialog.ok'.tr(),
                                dialogType: DialogType.warning,
                                onCancel: () {
                                  context.pop();
                                },
                              );
                            }),
                        verticalSpace(10),
                        ProfileButton(
                          title: 'profile.helpCenter',
                          icon: Icons.help,
                          onTap: () {},
                        ),
                        verticalSpace(10),
                        ProfileButton(
                          title: 'profile.contactUs',
                          icon: IconBroken.User1,
                          onTap: () {},
                        ),
                      ]),
                ),
              ),
            ),
          )),
    );
  }
}
