import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/logic/app_cubit.dart';
import 'package:medical_system/core/themes/colors.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'profile.language'.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPreferances.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'profile.selectLanguage'.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              verticalSpace(20),
              Directionality(
                textDirection: ui.TextDirection.ltr,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  title: Text('English',
                      style: Theme.of(context).textTheme.bodyMedium),
                  trailing: Radio(
                    fillColor: WidgetStateColor.resolveWith(
                        (states) => AppColors.mainColor),
                    value: 0,
                    activeColor: AppColors.mainColor,
                    groupValue: context.read<AppCubit>().languageIndex,
                    onChanged: (value) {
                      context.read<AppCubit>().toggleLanguage(context, 'en');
                    },
                  ),
                ),
              ),
              Directionality(
                textDirection: ui.TextDirection.ltr,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  title: Text('Arabic',
                      style: Theme.of(context).textTheme.bodyMedium),
                  trailing: Radio(
                    activeColor: AppColors.mainColor,
                    fillColor: WidgetStateColor.resolveWith(
                        (states) => AppColors.mainColor),
                    value: 1,
                    groupValue: context.read<AppCubit>().languageIndex,
                    onChanged: (value) {
                      context.read<AppCubit>().toggleLanguage(context, 'ar');
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
