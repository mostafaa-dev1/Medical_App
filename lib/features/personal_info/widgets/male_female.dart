import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/personal_info/logic/personal_info_cubit.dart';

class MaleFemale extends StatelessWidget {
  const MaleFemale({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<PersonalInfoCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          buttonName: 'Auth.male'.tr(),
          icon: Icons.male,
          reightIcon: true,
          onPressed: () {
            cubit.changeGenderIndex(0);
          },
          width: MediaQuery.of(context).size.width / 2.5,
          paddingVirtical: 10,
          paddingHorizental: 10,
          withBorderSide: cubit.gernderIndex != 0,
          backgroundColor: AppColors.mainColor,
          buttonColor:
              cubit.gernderIndex == 0 ? Colors.white : AppColors.mainColor,
        ),
        horizontalSpace(10),
        CustomButton(
            reightIcon: true,
            icon: Icons.female,
            buttonName: 'Auth.female'.tr(),
            backgroundColor: AppColors.mainColor,
            buttonColor:
                cubit.gernderIndex != 1 ? AppColors.mainColor : Colors.white,
            withBorderSide: cubit.gernderIndex != 1,
            onPressed: () {
              cubit.changeGenderIndex(1);
            },
            width: MediaQuery.of(context).size.width / 2.5,
            paddingVirtical: 10,
            paddingHorizental: 10),
      ],
    );
  }
}
