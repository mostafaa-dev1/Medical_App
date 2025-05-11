import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/main/logic/main_cubit.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem(
      {super.key,
      required this.index,
      required this.categories,
      required this.image});

  final int index;
  final List<String> categories;
  final String image;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MainCubit>();
    return GestureDetector(
      onTap: () {
        cubit.changeCategoryIndex(index);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: LanguageChecker.isArabic(context) ? 0 : 10,
          right: LanguageChecker.isArabic(context) ? 10 : 0,
        ),
        width: 125,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: index == cubit.categoryIndex
              ? AppColors.mainColor
              : AppColors.mainColor.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(image),
              height: 15,
              color: index == cubit.categoryIndex
                  ? Colors.white
                  : AppColors.darkBlue,
            ),
            // Icon(CupertinoIcons.person,
            //     size: 15,
            //     color: index == cubit.categoryIndex ? Colors.white : null),
            horizontalSpace(8),
            Text(
              categories[index].tr(),
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: index == cubit.categoryIndex ? Colors.white : null),
            ),
          ],
        ),
      ),
    );
  }
}
