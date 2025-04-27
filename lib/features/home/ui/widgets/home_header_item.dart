import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/themes/colors.dart';

class HomeHeaderItem extends StatelessWidget {
  const HomeHeaderItem(
      {super.key, required this.onPress, required this.title, this.isSeeAll});
  final VoidCallback onPress;
  final String title;
  final bool? isSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Spacer(),
          isSeeAll ?? true
              ? GestureDetector(
                  onTap: onPress,
                  child: Text(
                    'home.seeAll'.tr(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
