import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/logic/app_cubit.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/home/logic/home_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        log(context.read<AppCubit>().pageIndex.toString());
        return Scaffold(
          body: context.read<AppCubit>().pages(context.read<HomeCubit>().user)[
              context.read<AppCubit>().pageIndex],
          bottomNavigationBar: GNav(
              textStyle: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.white),
              tabMargin: EdgeInsets.all(8),
              tabBorderRadius: 15,
              selectedIndex: context.read<AppCubit>().pageIndex,
              onTabChange: (value) {
                context.read<AppCubit>().changePageIndex(value);
              },
              tabBackgroundColor: AppColors.mainColor,
              tabActiveBorder:
                  Border.all(color: AppColors.mainColor, width: .5),
              curve: Curves.ease,
              duration: Duration(milliseconds: 400),
              gap: 8,
              color: Colors.grey[400],
              activeColor: Colors.white,
              iconSize: 20,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              tabs: [
                GButton(
                  icon: IconBroken.Home,
                  text: 'main.home'.tr(),
                ),
                GButton(
                  icon: IconBroken.Calendar,
                  text: 'main.appointments'.tr(),
                ),
                GButton(
                  icon: IconBroken.Heart,
                  text: 'main.chatbot'.tr(),
                ),
                GButton(
                  icon: IconBroken.Profile,
                  text: 'main.profile'.tr(),
                )
              ]),
        );
      },
    );
  }
}
